import QtQuick

import "./Battery.qml"

Item {
    id: root

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        spacing: 10

        Battery {}
    }
}
