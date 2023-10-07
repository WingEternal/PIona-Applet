/*
 * SPDX-FileCopyrightText: 2023 WingEternal <dradcr7@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0
 */

import QtQuick 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0

Item {
  id: root

  width: 360 * PlasmaCore.Units.devicePixelRatio
  height: 180 * PlasmaCore.Units.devicePixelRatio 

  Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

  PlasmaCore.DataSource {
    id: time_source
    engine: "time"
    connectedSources: "Local"
    interval: 1000

    property int years
    property string months
    property string days
    property string hours
    property string minutes
    property string seconds

    function addZero(num) {
      return num > 9 ? num : "0" + num;
    }

    onDataChanged: {
      var date = new Date();
      years = date.getFullYear();
      months = addZero(date.getMonth() + 1);
      days = addZero(date.getDate());
      hours = addZero(date.getHours());
      minutes = addZero(date.getMinutes());
      seconds = addZero(date.getSeconds());
    }
    Component.onCompleted: {
      onDataChanged();
    }
  } // PlasmaCore.DataSource time_source

  Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
  Plasmoid.compactRepresentation: MouseArea {
    id: compact
    
    Layout.minimumWidth: Plasmoid.formFactor !== PlasmaCore.Types.Vertical ? compact.height : PlasmaCore.Units.gridUnit
    Layout.minimumHeight: Plasmoid.formFactor === PlasmaCore.Types.Vertical ? compact.width : PlasmaCore.Units.gridUnit

    Image {
      id: portrait
      source: "../image/portrait.png"
      fillMode: Image.PreserveAspectFit
      anchors {
        top: parent.top
        bottom: parent.bottom
        right: parent.right
      }
    } // Image portrait

    Item {
      id: data_ui
      x: 0.05 * parent.width
      y: 0
      width: 0.4 * parent.width
      height: 0.7 * parent.height

      ColumnLayout {
        anchors.fill: parent
        PlasmaComponents3.Label {
          id: time
          text: getTimeString()
          font.pixelSize: 50 * PlasmaCore.Units.devicePixelRatio
          Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
          function getTimeString() {
            return time_source.hours + ":" + time_source.minutes + ":" +
                   time_source.seconds;
          }
        } // PlasmaComponents3.Label time

        PlasmaComponents3.Label {
          id: date
          text: getDateString()
          font.pixelSize: 20 * PlasmaCore.Units.devicePixelRatio
          Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
          function getDateString() {
            return time_source.years + "-" + time_source.months + "-" +
                   time_source.days;
          }
        } // PlasmaComponents3.Label date
      } // ColumnLayout
    } // Item data_ui
  } // compactRepresentation MouseArea compact
} // Item root
