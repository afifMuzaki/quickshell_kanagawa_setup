import QtQuick
import QtQuick.Layouts

RowLayout {
    required property string appName
    required property string appIcon
    required property string appImage
    required property var onDismissClicked

    Layout.fillWidth: true
    Image {
        source: {
            if (!appIcon && !appImage)
                return "";

            var icon = appIcon || appImage;
            return icon.startsWith("/") ? "file://" + icon : "image://icon/" + icon;
        }

        Layout.preferredWidth: 16
        Layout.preferredHeight: 16
        fillMode: Image.PreserveAspectFit

        visible: status === Image.Ready && source !== ""
    }

    Text {
        text: appName || "Notification"
        color: "#cdd6f4"
        font.bold: true
        font.pixelSize: 12
        Layout.fillWidth: true
    }

    Text {
        text: "✕"
        color: "#a6adc8"
        font.pixelSize: 12

        MouseArea {
            anchors.fill: parent
            onClicked: onDismissClicked()
        }
    }
}
