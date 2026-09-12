import QtQuick

Item {
    id: root
    property string text: 'BarItem'
    property Component content
    property int fontSize: 12

    implicitWidth: itemComponent.implicitWidth + 30
    implicitHeight: itemComponent.implicitHeight + 25

    Rectangle {
        color: '#16161D'
        anchors.fill: parent
        radius: 8

        Loader {
            id: itemComponent
            anchors.centerIn: parent
            sourceComponent: root.content ?? fallbackText
        }

        Component {
            id: fallbackText
            Text {
                anchors.centerIn: parent
                text: root.text
                font.pixelSize: root.fontSize
                font.family: 'CaskaydiaCove Nerd Font'
                color: "#DCD7BA"
            }
        }
    }
}
