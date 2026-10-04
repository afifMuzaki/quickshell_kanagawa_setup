pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: cpu

    property real currentTemp: 0
    property real minTemp: 0
    property real maxTemp: 0
    property real avgTemp: 0
    property var tempHold: [0]
    property real currentUsage: 0
    property real clockSpeed: 0
    property string fanSpeed: "{}"

    readonly property int holdLength: 10

    Process {
        id: cpuTemp
        running: true
        command: [Quickshell.shellPath("../scripts/cpu_temp.sh")]
        stdout: StdioCollector {
            onStreamFinished: {
                const value = this.text.trim();
                cpu.currentTemp = value;

                if (cpu.tempHold[0] === 0 || cpu.tempHold.length == cpu.holdLength) {
                    cpu.tempHold.splice(0, 1);
                }

                cpu.tempHold.push(value);
                cpu.tempHold = cpu.tempHold;
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.warn("error:", this.text.trim());
                }
            }
        }
    }

    Process {
        id: cpuUsage
        running: true
        command: ["sh", "-c", "vmstat 1 2 | awk 'NR==4 {print $13 + $14}'"]
        stdout: SplitParser {
            onRead: data => cpu.currentUsage = data.trim()
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.warn("error:", this.text.trim());
                }
            }
        }
    }

    Process {
        id: cpuClockSpeed
        running: true
        command: ["sh", "-c", "cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq | awk '{s+=\$1; n++} END {printf \"%.0f\\n\", s/n/1000}'"]
        stdout: SplitParser {
            onRead: data => cpu.clockSpeed = data.trim()
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.warn("error:", this.text.trim());
                }
            }
        }
    }

    Process {
        id: cpuFanSpeed
        running: true
        command: [Quickshell.shellPath("../scripts/cpu_fan.sh")]
        stdout: StdioCollector {
            onStreamFinished: cpu.fanSpeed = this.text.trim()
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.warn("error:", this.text.trim());
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuTemp.running = true;
            cpuUsage.running = true;
            cpuClockSpeed.running = true;
            cpuFanSpeed.running = true;

            cpu.maxTemp = Math.max(...cpu.tempHold);
            cpu.minTemp = Math.min(...cpu.tempHold);
            cpu.avgTemp = Math.round(cpu.tempHold.reduce((acc, current) => parseInt(acc) + parseInt(current), 0) / cpu.tempHold.length);

            console.warn("current temp: ", cpu.currentTemp);
            console.warn("tempHold: ", cpu.tempHold);
            console.warn("average temp: ", cpu.avgTemp);
            console.warn("min temp: ", cpu.minTemp);
            console.warn("max temp: ", cpu.maxTemp);
            console.warn("CPU Usage: ", `${cpu.currentUsage}%`);
            console.warn("CPU clock speed: ", `${cpu.clockSpeed} MHz`);
            console.warn("fan: ", cpu.fanSpeed);
            console.warn("==========");
        }
    }
}
