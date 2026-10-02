import QtQuick.Layouts
import QtQuick

import "./Indicators"

Item {
    id: root

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    RowLayout {
        id: row
        spacing: 14

        Bluetooth {
            Layout.alignment: Qt.AlignBottom
        }
        Network {
            Layout.alignment: Qt.AlignBottom
        }
        Battery {
            Layout.alignment: Qt.AlignBottom
        }
    }
}
