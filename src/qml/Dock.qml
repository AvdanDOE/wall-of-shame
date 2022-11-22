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
import QtGraphicalEffects 1.15
import "ContextMenus" as CM
import Process 1.0
Item{

    id:dock
    width:childrenRect.width
    height:childrenRect.height

    RowLayout{
        spacing: 10
        Item{
            id:taskBarDock
            implicitWidth:taskBarDockRect.width
            height:50
            ShaderEffectSource{
                sourceItem: wmArea
                anchors.fill: parent
                sourceRect: Qt.rect(taskBarDock.x+dock.x,taskBarDock.x+dock.x,taskBarDock.width,taskBarDock.height)
                visible:false
                id:taskBarDockEffectSource
            }
            FastBlur{
                source:taskBarDockEffectSource
                radius:100
                id:taskBarDockBlur
                width: parent.width
                height: parent.height
                visible:false
            }
            OpacityMask{
                source:taskBarDockBlur
                width: parent.width
                height: parent.height
                maskSource:Item{
                    width: taskBarDockRect.width
                    height: taskBarDockRect.height
                    Rectangle{
                        anchors.fill: parent
                        radius:taskBarDockRect.radius
                    }
                }
            }
            Rectangle{
                color:"#88000000"
                radius:5
                visible: true
                implicitWidth:childrenRect.width+2
                clip: true
                height:50
                id:taskBarDockRect
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
                            Process {
                                id: process
                                onReadyRead: console.log(readAll());
                            }
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
                                    else
                                        if(exec == "brave")
                                            process.start("brave",["--enable-features=UseOzonePlatform","--ozone-platform=wayland"])
                                        else
                                            process.start(exec,["-platform","wayland"])
                                }
                                onPressAndHold: {
                                    if (mouse.source === Qt.MouseEventNotSynthesized)
                                        menu.open()
                                }
                                CM.TaskBarContextMenu{id:menu;y:pinnedApp.y-(height+10)}
                            }
                        }
                    }
                    Rectangle{width:1;height:30;color:"#ffffff";visible: shellSurfaces.count}
                    Repeater{
                        model:{
                            var m = []
                            for(let i=0;i < shellSurfaces.count;i++){
                                for(let j=0; j < shellSurfaces.get(i).tabs.count;j++){
                                    m.push(shellSurfaces.get(i).tabs.get(j));
                                }
                            }
                            return m;
                        }

                        Button{
                            id:runningApp
                            icon.name: modelData.shellSurface.toplevel.appId
                            icon.width: 64
                            icon.height:64
                            icon.color: "transparent"
                            icon.cache: true
                            implicitWidth: 48
                            implicitHeight: 48
                            background: Item{
                                Rectangle{
                                    color:modelData.shellSurface.toplevel.activated ? "green" : "white"
                                    width: 20
                                    height: 3
                                    radius:3
                                    x:(parent.width/2)-(width/2)
                                    y:parent.height-height-2

                                }
                            }
                            MouseArea{
                                id:runningAppMouseArea
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                                onClicked: {
                                    if (mouse.button === Qt.RightButton)
                                        menu2.open()

                                }
                                onPressAndHold: {
                                    if (mouse.source === Qt.MouseEventNotSynthesized)
                                        menu2.open()
                                }
                                CM.TaskBarContextMenu{id:menu2;y:runningApp.y-(height+10)}
                            }
                        }
                    }
                }
            }
        }
        Item{
            id:mainDock
            implicitWidth:150
            height:50
            ShaderEffectSource{
                sourceItem: wmArea
                anchors.fill: parent
                sourceRect: Qt.rect(mainDock.x+dock.x,mainDock.y+dock.y,mainDock.width,mainDock.height)
                visible:false
                id:mainDockEffectSource
            }
            FastBlur{
                source:mainDockEffectSource
                radius:100
                id:mainDockBlur
                width: parent.width
                height: parent.height
                visible:false
            }
            OpacityMask{
                source:mainDockBlur
                width: parent.width
                height: parent.height
                maskSource:Item{
                    width: mainDockRect.width
                    height: mainDockRect.height
                    Rectangle{
                        anchors.fill: parent
                        radius:mainDockRect.radius
                    }
                }
            }
            Rectangle{
                id:mainDockRect
                color:"#88000000"
                radius:5
                anchors.fill: parent
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
        }
        Item{
            id:notificationDock
            implicitWidth:300
            height:50
            ShaderEffectSource{
                sourceItem: wmArea
                anchors.fill: parent
                sourceRect: Qt.rect(notification.x+dock.x,notificationDock.y+dock.y,notificationDock.width,notificationDock.height)
                visible:false
                id:notificationDockEffectSource
            }
            FastBlur{
                source:notificationDockEffectSource
                radius:100
                id:notificationDockBlur
                width: parent.width
                height: parent.height
                visible:false
            }
            OpacityMask{
                source:notificationDockBlur
                width: parent.width
                height: parent.height
                maskSource:Item{
                    width: notificationDockRect.width
                    height: notificationDockRect.height
                    Rectangle{
                        anchors.fill: parent
                        radius:notificationDockRect.radius
                    }
                }
            }
            Rectangle{
                color:"#88000000"
                radius:5
                anchors.fill: parent
                id:notificationDockRect
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
                        pm = hours < 12
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
                        text: parent.hours + ":" + (parent.minutes.toString().length < 2 ? "0"+parent.minutes.toString() : parent.minutes.toString())
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
        }
        Item{
            id:trayDock
            implicitWidth:trayDockRect.width
            height:50
            ShaderEffectSource{
                sourceItem: wmArea
                anchors.fill: parent
                sourceRect: Qt.rect(trayDock.x+dock.x,trayDock.y+dock.y,trayDock.width,trayDock.height)
                visible:false
                id:trayDockEffectSource
            }
            FastBlur{
                source:taskBarDockEffectSource
                radius:100
                id:trayDockBlur
                width: parent.width
                height: parent.height
                visible:false
            }
            OpacityMask{
                source:taskBarDockBlur
                width: parent.width
                height: parent.height
                maskSource:Item{
                    width: trayDockRect.width
                    height: trayDockRect.height
                    Rectangle{
                        anchors.fill: parent
                        radius:trayDockRect.radius
                    }
                }
            }
            Rectangle{
                color:"#88000000"
                radius:5
                height:50
                id:trayDockRect
                width:childrenRect.width+20
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
}

