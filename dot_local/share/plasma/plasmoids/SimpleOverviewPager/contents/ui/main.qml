/*
 * Copyright 2012  Luís Gabriel Lima <lampih@gmail.com>
 * Copyright 2016  Kai Uwe Broulik <kde@privat.broulik.de>
 * Copyright 2016  Eike Hein <hein@kde.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddonsComponents
import org.kde.draganddrop 2.0
import org.kde.plasma.private.pager 2.0

MouseArea {
    id: root

    property bool isActivityPager: (plasmoid.pluginName === "org.kde.plasma.activitypager")
    readonly property bool inPanel: (plasmoid.location === PlasmaCore.Types.TopEdge
                                     || plasmoid.location === PlasmaCore.Types.RightEdge
                                     || plasmoid.location === PlasmaCore.Types.BottomEdge
                                     || plasmoid.location === PlasmaCore.Types.LeftEdge)

    property bool vertical: (plasmoid.formFactor === PlasmaCore.Types.Vertical)
    //    property var activityDataSource: null


    Layout.minimumWidth: {
        if (!inPanel) {
            return units.iconSizeHints.panel;
        }

        if (vertical) {
            return -1;
        } else {
            return 24// TODO: fix from settings
        }
    }

    Layout.minimumHeight: {
        if (!inPanel) {
            return units.iconSizeHints.panel;
        }

        if (vertical) {
            return Math.min(units.iconSizeHints.panel, parent.width) * 1//buttonIcon.aspectRatio;
        } else {
            return -1;
        }
    }

    Layout.maximumWidth: {
        if (!inPanel) {
            return -1;
        }

        if (vertical) {
            return units.iconSizeHints.panel;
        } else {
            return 24//parent.height + 2//350// TODO: fix from settings
        }
    }

    Layout.maximumHeight: {
        if (!inPanel) {
            return -1;
        }

        if (vertical) {
            return 26//Math.min(units.iconSizeHints.panel, parent.width) * 1//buttonIcon.aspectRatio;
        } else {
            return units.iconSizeHints.panel;
        }
    }

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.status: pagerModel.shouldShowPager ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.HiddenStatus

    //    Layout.fillWidth:  false//root.vertical
    //    Layout.fillHeight: false//!root.vertical

    property bool dragging: false
    property string dragId

    property int dragSwitchDesktopIndex: -1

    property int wheelDelta: 0

    //    anchors.fill: parent
    acceptedButtons: Qt.NoButton

    hoverEnabled: true

    function colorWithAlpha(color, alpha) {
        return Qt.rgba(color.r, color.g, color.b, alpha)
    }

    Rectangle{
        id: aRectArea
        anchors.fill: parent
        color: "transparent"

        Rectangle{
            id: square
            anchors.centerIn: parent
            width:  parent.width > 25 ? 22 : parent.width-2//square.height > 20 ? 24 : square.height
            height: square.width < 23 ? square.width - 4  : square.width-8 // parent.height > 22 ? 20 : parent.height -2
            color: "transparent"
            border.color: theme.textColor
            border.width: 1
            radius: 1

            PlasmaComponents.Label {
                anchors.centerIn: parent
                text: pagerModel.currentPage + 1

                wrapMode: Text.NoWrap
                elide: Text.ElideRight

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: Math.min(height, theme.defaultFont.pixelSize)
                // unset pointSize set by PlasmaComponents.Label to avoid "Both point size and pixel size set." warning
                font.pointSize: -1

                z: 9999 // The label goes above everything
            }

        }

        Rectangle{
            anchors.horizontalCenter: square.horizontalCenter
            anchors.top: square.bottom
            anchors.topMargin: 1
            width: square.width-6
            height: 1
            color: "transparent"
            border.color: theme.textColor
            border.width: 1
            visible: false//aRectArea.height > 24

        }
        Rectangle{
            anchors.horizontalCenter: square.horizontalCenter
            anchors.bottom: square.top
            anchors.bottomMargin: 1
            width: square.width-6
            height: 1
            color: "transparent"
            border.color: theme.textColor
            border.width: 1
            visible: false//aRectArea.height > 24

        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                exposeDesktop()
            }
        }
    }

    function action_addDesktop() {
        pagerModel.addDesktop();
    }

    function action_removeDesktop() {
        pagerModel.removeDesktop();
    }

    function action_openKCM() {
        KQuickControlsAddonsComponents.KCMShell.open("kcm_kwin_virtualdesktops");
    }

    function action_showActivityManager() {
        if (!activityDataSource) {
            activityDataSource = Qt.createQmlObject('import org.kde.plasma.core 2.0 as PlasmaCore; \
                PlasmaCore.DataSource { id: dataSource; engine: "org.kde.activities"; \
                connectedSources: ["Status"] }', root);
        }

        var service = activityDataSource.serviceForSource("Status")
        var operation = service.operationDescription("toggleActivityManager")
        service.startOperationCall(operation)
    }

    onContainsMouseChanged: {
        if (!containsMouse && dragging) {
            // Somewhat heavy-handed way to clean up after a window delegate drag
            // exits the window.
            pagerModel.refresh();
            dragging = false;
        }
    }


    onWheel: {
        // Magic number 120 for common "one click, see:
        // http://qt-project.org/doc/qt-5/qml-qtquick-wheelevent.html#angleDelta-prop

        wheelDelta += wheel.angleDelta.y || wheel.angleDelta.x;

        var increment = 0;

        while (wheelDelta >= 120) {
            wheelDelta -= 120;
            increment++;
        }

        while (wheelDelta <= -120) {
            wheelDelta += 120;
            increment--;
        }

        while (increment !== 0) {
            if (increment < 0) {
                var nextPage = plasmoid.configuration.wrapPage?
                            (pagerModel.currentPage + 1) % pagerModel.count :
                            Math.min(pagerModel.currentPage + 1, pagerModel.count - 1);
                pagerModel.changePage(nextPage);
            } else {
                var previousPage = plasmoid.configuration.wrapPage ?
                            (repeater.count + pagerModel.currentPage - 1) % pagerModel.count :
                            Math.max(pagerModel.currentPage - 1, 0);
                pagerModel.changePage(previousPage);
            }

            increment += (increment < 0) ? 1 : -1;
        }
    }

    PagerModel {
        id: pagerModel

        enabled: root.visible

        showDesktop: (plasmoid.configuration.currentDesktopSelected === 1)

        showOnlyCurrentScreen: plasmoid.configuration.showOnlyCurrentScreen
        screenGeometry: plasmoid.screenGeometry

        pagerType: isActivityPager ? PagerModel.Activities : PagerModel.VirtualDesktops
    }

    Connections {
        target: plasmoid.configuration

        onShowWindowIconsChanged: {
            // Causes the model to reset; Component.onCompleted in the
            // window delegate now gets a chance to create the icon item,
            // which it otherwise will not do.
            pagerModel.refresh();
        }

        onDisplayedTextChanged: {
            // Causes the model to reset; Component.onCompleted in the
            // desktop delegate now gets a chance to create the label item,
            // which it otherwise will not do.
            pagerModel.refresh();
        }
    }


    Component.onCompleted: {
        if (isActivityPager) {
            plasmoid.setAction("showActivityManager", i18n("Show Activity Manager..."), "activities");
        } else {
            if (KQuickControlsAddonsComponents.KCMShell.authorize("kcm_kwin_virtualdesktops.desktop").length > 0) {
                plasmoid.setAction("addDesktop", i18n("Add Virtual Desktop"), "list-add");
                plasmoid.setAction("removeDesktop", i18n("Remove Virtual Desktop"), "list-remove");
                plasmoid.action("removeDesktop").enabled = Qt.binding(function() {
                    return pagerModel.count > 1;
                });

                plasmoid.setAction("openKCM", i18n("Configure Virtual Desktops..."), "configure");
            }
        }
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: disconnectSource(sourceName)

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }

    function exposeDesktop() {
        executable.exec('qdbus org.kde.kglobalaccel /component/kwin invokeShortcut Overview')
    }
}
