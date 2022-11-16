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
import QtQuick.Controls 2.5

CustomContextMenuBase
{
    x:(parent.width/2)-(width/2)
    y:pinnedApp.y-(height+10)
    Action { text: qsTr("Open in New Window"); }
    Action { text: qsTr("Unpin from the TaskBar");onTriggered: taskBarEntries.remove(index) }
    MenuSeparator{contentItem: Rectangle{color:"white";implicitHeight: 1}}
    Action { text: qsTr("Enter Edit Mode");onTriggered: editor.editMode = true;}
}
