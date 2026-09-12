import Quickshell.I3
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 6

    Component.onCompleted: I3.refreshWorkspaces()

    Repeater {
        model: I3.workspaces
        delegate: Text {
            text: modelData.number >= 0 ? modelData.number : modelData.name
            font.family: 'CaskaydiaCove Nerd Font'
            font.pixelSize: 13
            font.bold: modelData.focused
            color: modelData.focused ? '#DCD7BA' : '#7F849C'
        }
    }
}
