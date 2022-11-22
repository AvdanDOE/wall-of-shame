/*
 * Copyright (C) 2022 ColdFlameOS Team.
 *
 * Author:     Yegender <yegenderkumar124001@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.5
Menu {
    id:mMenu
    enter: Transition {
        NumberAnimation { property: "height"; from: 0.0; to: menu.implicitHeight ;duration:100}
        //NumberAnimation { property: "width"; from: 0.0; to: menu.width ;duration:100}
    }
    topPadding: 10
    bottomPadding: 10
    leftPadding: 10
    rightPadding: 10

    delegate: MenuItem {
        id: menuItem
        implicitWidth: 200
        implicitHeight: 40
        indicator: Item {
            implicitWidth: 40
            implicitHeight: 40
            Rectangle {
                width: 26
                height: 26
                anchors.centerIn: parent
                visible: menuItem.checkable
                border.color: "#21be2b"
                radius: 3
                Rectangle {
                    width: 14
                    height: 14
                    anchors.centerIn: parent
                    visible: menuItem.checked
                    color: "#21be2b"
                    radius: 2
                }
            }
        }
        contentItem: Text {
            leftPadding: 5
            text: menuItem.text
            font: menuItem.font
            color: menuItem.highlighted ? "#ffffff" : "#ffffff"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            anchors.centerIn: parent.center
            radius:5
            color: menuItem.highlighted ? "#88000000" : "transparent"
        }
    }

    background: Item{
        implicitWidth: 200
        implicitHeight: 40
        ShaderEffectSource{
            anchors.fill: parent
            sourceItem:wallpaper
            sourceRect: Qt.rect(mMenu.x,mMenu.y,mMenu.width,mMenu.height)
            id:mEffectSource
            visible: false
        }
        FastBlur{
            anchors.fill: parent
            source:mEffectSource
            radius:100
            visible: false
            id:mBlurEffect
        }
        OpacityMask{
            source:mBlurEffect
            width:mMenu.width
            height:mMenu.height
            visible:true
            maskSource: Item{
                width:mMenu.width
                height:mMenu.height
                Rectangle{
                    anchors.fill: parent
                    radius:5
                }
            }
        }

        Item{
            id:mBackground
            anchors.fill: parent
            Rectangle {
                anchors.fill: parent
                color: "#88000000"
                radius: 5
            }
        }
    }
}
