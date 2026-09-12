import QtQuick

import "./Battery.qml"
import "./Network.qml"

Item {
    id: root

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        spacing: 14

        Network {}
        Battery {}
    }
}
