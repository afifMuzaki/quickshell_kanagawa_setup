import Quickshell
import QtQuick
import QtQuick.Layouts

import "./BarItem.qml"
import "./Workspaces.qml"
import "./Clock.qml"

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: window
            anchors {
                top: true
                left: true
                right: true
            }
            margins {
                top: 5
                bottom: 2
            }
            height: 45
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 10

                BarItem {
                    content: Component {
                        Workspaces {}
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                BarItem {
                    text: Clock.time
                    fontSize: 16
                }

                Item {
                    Layout.fillWidth: true
                }

                BarItem {
                    text: 'Wi-Fi | 80%'
                }
            }
        }
    }
}
