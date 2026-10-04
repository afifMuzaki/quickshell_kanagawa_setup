pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: memory

    property real memTotal: 0
    property real memUsed: 0
    property real memFree: 0
    property real memCached: 0
    property real swapTotal: 0
    property real swapUsed: 0
    property real swapFree: 0

    readonly property real gibDivider: 1048576
    readonly property real mibDivider: 1024

    FileView {
        id: meminfo
        path: "/proc/meminfo"
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            meminfo.reload();
            const t = meminfo.text();
            const get = k => {
                const m = t.match(new RegExp("^" + k + ":\\s+(\\d+)", "m"));
                const intValue = m ? parseInt(m[1]) : 0;

                if (intValue >= memory.gibDivider) {
                    return (intValue / memory.gibDivider).toFixed(1);
                }

                return Math.round(intValue / memory.mibDivider);
            };

            memory.memTotal = get("MemTotal");
            memory.memFree = get("MemAvailable");
            memory.memUsed = (memory.memTotal - memory.memFree).toFixed(1);
            memory.memCached = get("Cached");
            memory.swapTotal = get("SwapTotal");
            memory.swapFree = get("SwapFree");
            memory.swapUsed = (memory.swapTotal - memory.swapFree).toFixed(1);

            console.warn("Total Memory: ", memory.memTotal);
            console.warn("Memory Used: ", memory.memUsed);
            console.warn("Memory Cached: ", memory.memCached);
            console.warn("Memory Free: ", memory.memFree);
            console.warn("Total Swap: ", memory.swapTotal);
            console.warn("Swap Used: ", memory.swapUsed);
            console.warn("Swap Free: ", memory.swapFree);
            console.warn("==========");
        }
    }
}
