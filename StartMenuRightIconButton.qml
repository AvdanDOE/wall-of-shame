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
import QtQuick.Controls 2.15
Item {
    property alias icon:button.icon
    Rectangle{
        height:parent.height
        width:parent.width
        color:"transparent"
        id:background
        opacity: 0.5
        Image{
            x:0
            y:0
            id:left
            width:10
            cache:true
            height:parent.height
            source:"qrc:/assets/startmenurightleft.png"
        }
        Image{
            x:10
            y:0
            id:center
            cache:true
            width:parent.width-20
            height:parent.height
            source:"qrc:/assets/startmenurightcenter.png"
        }
        Image{
            x:parent.width-10
            y:0
            id:right
            width:10
            cache:true
            height: parent.height
            source:"qrc:/assets/startmenuleftright.png"
        }
    }
    Button{id:button;anchors.fill: parent;anchors.margins: 4;background:Item{}}
    MouseArea{
        id:mouseReciever
        hoverEnabled: true
        anchors.fill: parent

    }
}
