import Quickshell
import QtQuick

import "./StatusBar" as StatusBar
import "./MenuLauncher/" as Launcher

Scope {
    id: root

    Launcher.Launcher {}
    StatusBar.Bar {}
}
