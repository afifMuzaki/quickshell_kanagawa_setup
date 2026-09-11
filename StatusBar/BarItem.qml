import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    property string text
    property int fontSize: 12

    spacing: 8

    Rectangle {
        width: workspaces.implicitWidth + 30
        height: workspaces.implicitHeight + 25
        color: '#16161D'
        anchors.centerIn: parent
        radius: 8

        Text {
            id: workspaces
            anchors.centerIn: parent
            text: root.text
            font.pixelSize: root.fontSize
            font.family: 'CaskaydiaCove Nerd Font'
            color: "#DCD7BA"
        }
    }
}
