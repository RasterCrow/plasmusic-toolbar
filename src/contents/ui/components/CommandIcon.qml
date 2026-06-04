import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami

Item {
    id: container
    property alias size: icon.width
    property int padding: Math.round(Kirigami.Units.smallSpacing / 2)
    property bool active: false;
    property alias source: icon.source
    signal clicked()

    Layout.preferredWidth: size + padding * 2
    Layout.preferredHeight: size + padding * 2

    Rectangle {
        anchors.fill: parent
        radius: Math.min(width, height) / 2
        color: container.active || mouse.containsMouse ? Kirigami.Theme.highlightColor : "transparent"
        opacity: {
            if (!container.enabled) {
                return 0
            }
            if (mouse.pressed) {
                return 0.24
            }
            if (container.active) {
                return mouse.containsMouse ? 0.22 : 0.14
            }
            return mouse.containsMouse ? 0.14 : 0
        }

        Behavior on opacity {
            NumberAnimation {
                duration: Kirigami.Units.shortDuration
            }
        }
    }

    Kirigami.Icon {
        id: icon
        width: Kirigami.Units.iconSizes.small;
        height: width;
        anchors.centerIn: parent
        opacity: container.enabled ? 1.0 : 0.35
        color: container.active ? Kirigami.Theme.highlightColor : Kirigami.Theme.textColor
    }

    MouseArea {
        id: mouse

        anchors.fill: parent
        enabled: container.enabled
        hoverEnabled: true
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: container.clicked()
    }
}
