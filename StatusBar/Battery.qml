import Quickshell
import Quickshell.Services.UPower
import QtQuick

Item {
    id: root

    readonly property var battery: UPower.displayDevice
    readonly property bool available: battery && battery.ready && battery.isLaptopBattery
    readonly property int percentage: available ? Math.round(battery.percentage * 100) : -1
    readonly property var state: available ? battery.state : UPowerDeviceState.Unknown

    readonly property bool isCharging: state === UPowerDeviceState.Charging || state === UPowerDeviceState.PendingCharge
    readonly property bool isDischarging: state === UPowerDeviceState.Discharging || state === UPowerDeviceState.PendingDischarge
    readonly property bool isFull: state === UPowerDeviceState.FullyCharged
    readonly property bool isCritical: available && !isCharging && percentage <= 20

    readonly property string percentText: available ? percentage + '%' : ''
    readonly property string color: isCritical ? '#F38BA8' : isCharging ? '#9ECE6A' : isDischarging ? '#7F849C' : '#DCD7BA'

    readonly property string icon: {
        if (!available)
            return '';
        if (isFull)
            return codepoint(0xF0085);
        if (isCharging)
            return chargingIcon();
        if (percentage < 10)
            return codepoint(0xF0083);
        return codepoint(batteryLevelCodepoint(Math.min(Math.max(Math.floor(percentage / 10) * 10, 10), 90)));
    }

    visible: available
    implicitWidth: statusText.implicitWidth
    implicitHeight: statusText.implicitHeight

    Text {
        id: statusText
        text: root.icon + ' ' + root.percentText
        font.family: 'CaskaydiaCove Nerd Font'
        font.pixelSize: 13
        color: root.color
    }

    function codepoint(cp) {
        return String.fromCodePoint(cp);
    }

    function chargingIcon() {
        if (percentage >= 90)
            return codepoint(0xF008B);
        if (percentage >= 80)
            return codepoint(0xF008A);
        if (percentage >= 60)
            return codepoint(0xF0089);
        if (percentage >= 40)
            return codepoint(0xF0088);
        if (percentage >= 30)
            return codepoint(0xF0087);
        if (percentage >= 20)
            return codepoint(0xF0086);
        return codepoint(0xF0084);
    }

    function batteryLevelCodepoint(level) {
        return 0xF0079 + level / 10;
    }
}
