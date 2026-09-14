import QtQuick
import QtQuick.Controls

ItemDelegate {
    required property var modelData
    required property int index
    property bool isSelected: false

    height: 40
    width: ListView.view.width

    background: Rectangle {
        color: isSelected ? "#DCD7BA" : "#2A2A37"
        radius: 6
    }

    contentItem: Row {
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter

        Image {
            width: 24
            height: 24
            source: modelData.icon ? 'image://icon/' + modelData.icon : ''
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: modelData.name
            color: isSelected ? "#2A2A37" : "#dcd7ba"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
