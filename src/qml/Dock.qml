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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "ContextMenus" as CM
Item{
    id:dock
    width:childrenRect.width
    height:childrenRect.height
    Behavior on y {
        NumberAnimation{
            id:raiseDock
            duration:150
            from:dock.parent.height*2
            easing.type: Easing.InOutQuad
            to:parent.height-height-10
        }
    }
    y:parent.height-height-10
    x:(parent.width/2)-(width/2)
    RowLayout{
        spacing: 10
        Rectangle{
            id:taskBarDock
            implicitWidth:childrenRect.width+2
            height:50
            color:"#88000000"
            radius:5
            clip: true
            Behavior on implicitWidth {
                NumberAnimation{
                    duration:200
                }
            }

            RowLayout{
                anchors.centerIn: parent.verticalcenter
                spacing: 10
                Repeater{
                    model:taskBarEntries
                    Button{
                        id:pinnedApp
                        icon.name: cicon
                        icon.width: 64
                        icon.height:64
                        icon.color: "transparent"
                        icon.cache: true
                        implicitWidth: 48
                        implicitHeight: 48
                        background: Item{}
                        MouseArea{
                            id:mouseArea
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                            onClicked: {
                                if (mouse.button === Qt.RightButton)
                                    menu.open()

                            }
                            onPressAndHold: {
                                if (mouse.source === Qt.MouseEventNotSynthesized)
                                    menu.open()
                            }
                            CM.TaskBarContextMenu{id:menu}
                        }
                    }
                }
                //Rectangle{width:1;height:30;color:"#ffffff"}
                //Label{text:"TODO: Pending adding running apps    ";color:"white"}
            }
        }
        Rectangle{
            id:mainDock
            //implicitWidth:childrenRect.width+10
            implicitWidth:150
            height:50
            color:"#88000000"
            radius:5
            RowLayout{
                anchors.centerIn: parent
                spacing: 10
                Button{
                    icon.name: "search-icon"
                    icon.width: 40
                    icon.height:40
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
                Button{
                    icon.name: "start-here-symbolic"
                    icon.width: 128
                    icon.height:128
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
                Button{
                    icon.name: "desktop-symbolic"
                    icon.width: 40
                    icon.height:40
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
            }
        }
        Rectangle{id:notificationDock
            implicitWidth:300
            height:50
            color:"#88000000"
            radius:5
            Item{
                property int hours;
                property int pm;
                property int pmhr;
                property int minutes;
                property int seconds;
                property string day;
                property int date;
                property string month;
                function timeChanged() {
                    var tdate = new Date;
                    month = [
                                "January",
                                "Feburary",
                                "March",
                                "April",
                                "May",
                                "June",
                                "July",
                                "August",
                                "September",
                                "October",
                                "November",
                                "December"
                            ][tdate.getMonth()]
                    date = tdate.getDate()
                    day = [
                                "Sunday",
                                "Monday",
                                "Tuesday",
                                "Wednesday",
                                "Thrusday",
                                "Friday",
                                "Saturday"
                            ][tdate.getDay()]
                    hours = tdate.getHours()
                    pm = hours > 12
                    pmhr = hours > 12 ? hours - 12 : hours
                    minutes = tdate.getMinutes()
                    seconds = tdate.getUTCSeconds();
                }
                Timer {
                    interval: 100; running: true; repeat: true;
                    onTriggered: parent.timeChanged()
                }
                width:280
                height:40
                anchors.centerIn: parent
                Label{
                    text: parent.pmhr + ":" + (parent.minutes.toString().length < 2 ? "0"+parent.minutes.toString() : parent.minutes.toString()) + (parent.pm ? " AM" : " PM")
                    color:"white"
                    font.pixelSize: 17
                }
                Label{
                    text:parent.day+", "+parent.month+" "+parent.date
                    color:"white"
                    font.pixelSize: 15
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                }
                Button{
                    icon.name:"weather-clouds-symbolic"
                    icon.color:"white"
                    width:parent.height
                    height:parent.height
                    anchors.right:parent.right
                    icon.width: parent.height
                    icon.height: parent.height
                    background:Item{}
                }
            }
        }
        Rectangle{
            id:trayDock
            implicitWidth:childrenRect.width+20
            height:50
            color:"#88000000"
            radius:5
            RowLayout{
                anchors.centerIn: parent
                spacing: 0
                Button{
                    icon.name: "network-wireless-connected-symbolic"
                    padding:10
                    icon.width: 40
                    icon.height:40
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
                Button{
                    icon.name: "bluetooth-active-symbolic"
                    icon.width: 40
                    icon.height:40
                    padding:10
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
                Button{
                    icon.name: "audio-volume-high-symbolic"
                    icon.width: 40
                    padding:10
                    icon.height:40
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
                Button{
                    icon.name: "battery-100-symbolic"
                    icon.width: 40
                    padding:10
                    icon.height:40
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
                Button{
                    icon.name: "arrow-up"
                    icon.width: 40
                    icon.height:40
                    padding:10
                    icon.color: "white"
                    icon.cache: true
                    implicitWidth: 40
                    implicitHeight: 40
                    background: Item{}
                }
            }
        }
    }
}
