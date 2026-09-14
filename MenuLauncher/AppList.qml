import QtQuick
import QtQuick.Layouts

import "./AppItem.qml"

ListView {
    id: appList
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 10
    clip: true
    highlightFollowsCurrentItem: true
    signal appActivated(var app)

    delegate: AppItem {
        isSelected: index === appList.currentIndex

        onClicked: {
            appList.appActivated(modelData);
        }
    }
}
