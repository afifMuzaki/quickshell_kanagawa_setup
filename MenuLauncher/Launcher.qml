import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FloatingWindow {
    id: menuLauncher
    title: 'menu-launcher'
    visible: false
    width: 750
    height: 450

    property int selectedIndex: 0

    function moveSelected(delta: int): void {
        var count = appFilter.filtered.length;
        if (count === 0) return;
        selectedIndex = Math.max(0, Math.min(count - 1, selectedIndex + delta));
        appList.positionViewAtIndex(selectedIndex, ListView.Beginning);
    }

    function launchSelected(): void {
        if (appFilter.filtered.length === 0) return;
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

            TextField {
                id: searchInput
                Layout.fillWidth: true
                padding: 12
                font.pixelSize: 16
                placeholderText: "Search apps..."
                placeholderTextColor: '#DCD7BA'
                color: "#DCD7BA"
                background: Rectangle {
                    color: "#2A2A37"
                    radius: 6
                    border.color: searchInput.activeFocus ? "#DCD7BA" : "#363646"
                }

                Component.onCompleted: {
                    searchInput.forceActiveFocus();
                }

                onTextChanged: selectedIndex = 0;

                Keys.onUpPressed: menuLauncher.moveSelected(-1);
                Keys.onDownPressed: menuLauncher.moveSelected(1);
                Keys.onReturnPressed: menuLauncher.launchSelected();
            }

            ListView {
                id: appList
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 6
                model: appFilter.filtered
                currentIndex: menuLauncher.selectedIndex
                highlightFollowsCurrentItem: true

                delegate: ItemDelegate {
                    required property var modelData
                    required property int index
                    property bool isSelected: index === appList.currentIndex

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

                    onClicked: {
                        modelData.execute();
                        menuLauncher.visible = false;
                    }
                }
            }
        }
    }

    IpcHandler {
        target: 'menuLauncher'

        function toggleLauncher(): void {
            console.log(menuLauncher.visible);
            menuLauncher.visible = !menuLauncher.visible;
        }
    }
}
