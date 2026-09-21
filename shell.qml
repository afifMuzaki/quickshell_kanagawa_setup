import Quickshell
import QtQuick

import "./StatusBar" as StatusBar
import "./MenuLauncher" as Launcher
import "./Notification" as Notification

Scope {
    id: root

    Notification.Notification {}
    Launcher.Launcher {}
    StatusBar.Bar {}
}
