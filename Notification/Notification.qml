import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

import "./NotifyCard.qml"

ShellRoot {
    NotificationServer {
        id: notifyServer
        actionsSupported: true
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true;
        }
    }

    PanelWindow {
        id: notificationWindow
        visible: notifyServer.trackedNotifications.values.length > 0

        anchors {
            top: true
            right: true
        }
        margins {
            top: 20
            right: 12
        }

        width: 400
        height: contentColumn.height + 20
        color: "transparent"

        ColumnLayout {
            id: contentColumn
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: 8

            Repeater {
                model: notifyServer.trackedNotifications.values
                delegate: NotifyCard {}
            }
        }
    }
}
