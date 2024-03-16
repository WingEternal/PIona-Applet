/*
 * SPDX-FileCopyrightText: 2023 WingEternal <dradcr7@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0
 */

import QtQuick 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasma5support 2.0 as P5Support
import org.kde.ksvg 1.0 as KSvg

PlasmoidItem {
  id: root

  width: 360
  height: 180

  Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

  P5Support.DataSource {
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
      PlasmaComponents.Label {
        id: time
        text: getTimeString()
        font.pixelSize: 50
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        function getTimeString() {
          return time_source.hours + ":" + time_source.minutes + ":" +
                  time_source.seconds;
        }
      } // PlasmaComponents.Label time

      PlasmaComponents.Label {
        id: date
        text: getDateString()
        font.pixelSize: 20
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        function getDateString() {
          console.error(time_source.years + "-" + time_source.months + "-" +
                      time_source.days)
          return time_source.years + "-" + time_source.months + "-" +
                  time_source.days;
        }
      } // PlasmaComponents.Label date
    } // Item data_ui
  } // compactRepresentation MouseArea compact
} // Item root
