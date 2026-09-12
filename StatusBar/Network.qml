import Quickshell.Networking
import QtQuick

Item {
    id: root

    readonly property var activeDevice: {
        const devices = Networking.devices.values;
        for (let i = 0; i < devices.length; ++i) {
            const device = devices[i];
            if (device && device.connected)
                return device;
        }
        return null;
    }

    readonly property bool hasInternet: Networking.connectivity !== NetworkConnectivity.None && Networking.connectivity !== NetworkConnectivity.Limited

    readonly property string icon: {
        if (!activeDevice)
            return codepoint(0xF05AA);  // nf-md-wifi_off
        if (!hasInternet)
            return codepoint(0xF16B5);   // nf-md-wifi_alert
        if (activeDevice.type === DeviceType.Wired)
            return codepoint(0xF0200);  // nf-md-ethernet
        return codepoint(0xF05A9);                     // nf-md-wifi
    }

    readonly property color textColor: !activeDevice ? '#7F849C' : !hasInternet ? '#F38BA8' : '#DCD7BA'

    implicitWidth: statusText.implicitWidth
    implicitHeight: statusText.implicitHeight

    Text {
        id: statusText
        text: root.icon
        font.family: 'CaskaydiaCove Nerd Font'
        font.pixelSize: 13
        color: root.textColor
    }

    function codepoint(cp) {
        return String.fromCodePoint(cp);
    }
}
