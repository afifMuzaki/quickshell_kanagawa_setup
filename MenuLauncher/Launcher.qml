import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "./SearchInput.qml"
import "./AppList.qml"

FloatingWindow {
    id: menuLauncher
    title: 'menu-launcher'
    visible: false
    width: 750
    height: 450

    property int selectedIndex: 0

    function moveSelected(delta: int): void {
        var count = appFilter.filtered.length;
        if (count === 0)
            return;
        selectedIndex = Math.max(0, Math.min(count - 1, selectedIndex + delta));
        appList.positionViewAtIndex(selectedIndex, ListView.Beginning);
    }

    function launchSelected(): void {
        if (appFilter.filtered.length === 0)
            return;
        appFilter.filtered[selectedIndex].execute();
        menuLauncher.visible = false;
    }

    onVisibleChanged: {
        if (visible) {
            searchInput.forceActiveFocus();
        } else {
            searchInput.text = "";
            selectedIndex = 0;
            appList.positionViewAtBeginning();
        }
    }

    Shortcut {
        sequence: 'Esc'
        onActivated: menuLauncher.visible = false
    }

    QtObject {
        id: appFilter
        readonly property var filtered: {
            var q = searchInput.text.trim().toLowerCase();
            var result = [];
            for (var i = 0; i < DesktopEntries.applications.values.length; i++) {
                var app = DesktopEntries.applications.values[i];
                if (q === "" || app.name.toLowerCase().includes(q))
                    result.push(app);
            }
            return result;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#16161D"
        radius: 12
        border.color: "#DCD7BA"
        border.width: 2

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            SearchInput {
                id: searchInput
                onTextChanged: selectedIndex = 0

                Keys.onUpPressed: menuLauncher.moveSelected(-1)
                Keys.onDownPressed: menuLauncher.moveSelected(1)
                Keys.onReturnPressed: menuLauncher.launchSelected()
            }

            AppList {
                model: appFilter.filtered
                currentIndex: menuLauncher.selectedIndex
                onAppActivated: {
                    app.execute();
                    menuLauncher.visible = false;
                }
            }
        }
    }

    IpcHandler {
        target: 'menuLauncher'

        function toggleLauncher(): void {
            menuLauncher.visible = !menuLauncher.visible;
        }
    }
}
