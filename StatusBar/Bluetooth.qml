import Quickshell.Bluetooth
import QtQuick

Item {
    id: bluetoothIndicator

    readonly property bool isBluetoothEnable: Bluetooth.defaultAdapter.enabled
    readonly property string indicator: !isBluetoothEnable ? codepoint(0xF00B2) : codepoint(0xF00AF)
    readonly property color iconColor: !isBluetoothEnable ? '#7F849C' : '#DCD7BA'

    implicitWidth: statusText.implicitWidth
    implicitHeight: statusText.implicitHeight

    function codepoint(cp) {
        return String.fromCodePoint(cp);
    }

    Text {
        id: statusText
        text: bluetoothIndicator.indicator
        font.family: 'CaskaydiaCove Nerd Font'
        font.pixelSize: 15
        color: bluetoothIndicator.iconColor
    }
}
