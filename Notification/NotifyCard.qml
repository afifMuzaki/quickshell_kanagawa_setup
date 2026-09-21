import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications

import "./NotifyHeader.qml"

Rectangle {
    required property Notification modelData

    Layout.fillWidth: true
    implicitHeight: col.height + 35
    color: "#B016161D"
    border.color: "#DCD7BA"
    border.width: 1
    radius: 8

    Timer {
        interval: modelData.expireTimeout > 0 ? modelData.expireTimeout : 5000
        running: true
        repeat: false
        onTriggered: modelData.dismiss()
    }

    ColumnLayout {
        id: col
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 15
        }

        NotifyHeader {
            appName: modelData.appName
            appIcon: modelData.appIcon
            appImage: modelData.image
            onDismissClicked: modelData.dismiss
        }

        Text {
            text: modelData.summary
            color: "#f38ba8"
            font.bold: true
            font.pixelSize: 14
            Layout.fillWidth: true
            wrapMode: Text.Wrap
        }

        Text {
            text: modelData.body
            color: "#bac2de"
            font.pixelSize: 12
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            visible: text !== ""
        }
    }
}
