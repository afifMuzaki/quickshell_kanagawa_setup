import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Notifications

Button {
    id: actionButton
    required property NotificationAction modelData

    Layout.preferredHeight: 28
    Layout.preferredWidth: actionButton.contentItem.implicitWidth + 24

    onClicked: modelData.invoke()

    contentItem: Text {
        text: actionButton.modelData.text
        color: "#DCD7BA"
        font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        color: actionButton.down ? "#2A161D" : "#B016161D"
        border.color: actionButton.hovered ? "#f38ba8" : "#DCD7BA"
        border.width: 1
        radius: 8
    }
}
