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

//![Importing Neccessary Modules]
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.3
import QtWayland.Compositor 1.15
import QtGraphicalEffects 1.15
import QtMultimedia 5.15
import "ContextMenus" as CM

WaylandCompositor{
    id:comp
    WaylandOutput{
        compositor:comp
        sizeFollowsWindow: true
        id:output
        window:Window{
            width:1280
            height:720
            title:"IgniteShell"
            visibility: "FullScreen"
            visible:true
            WaylandMouseTracker{
                id: mouseTracker
                width:parent.width
                height:parent.height
                windowSystemCursorEnabled: true
                Item{
                    id:wmArea
                    anchors.fill:parent
                    Item{
                        id:wallpaper
                        anchors.fill: parent
                        /*
                        Item{
                            Component.onCompleted: {resetTimer.start()}
                            id:dynamicWallpaper
                            anchors.fill: parent
                            Timer {
                                id: resetTimer
                                interval: 5000
                                onTriggered: {
                                    nightWallp.opacity = 1;
                                    dayWallp.opacity = 0;
                                }
                            }

                            Image {
                                id: nightWallp
                                source:"file:///home/yegender/HDD/MyFiles/Downloads/isodark.png"
                                anchors.fill: parent
                                cache: true
                                opacity: 0
                                Behavior on opacity{

                                    NumberAnimation {
                                        from: 0
                                        to: 1
                                        duration: 2000

                                    }
                                }
                                fillMode: Image.PreserveAspectCrop
                            }
                            Image {
                                id: dayWallp
                                //source: "file:///home/yegender/Pictures/ghost.png"
                                //source:"file:///home/yegender/Downloads/Windows 20 Concept - Dark Mode.png"
                                source:"file:///home/yegender/HDD/MyFiles/Downloads/isolight.png"
                                anchors.fill: parent
                                cache: true
                                Behavior on opacity {
                                    NumberAnimation{
                                        from: 1
                                        to: 0
                                        duration: 2000
                                        onRunningChanged: {
                                            console.log(running)
                                        }
                                    }

                                }
                                visible: true
                                fillMode: Image.PreserveAspectCrop
                            }
                        }
                        */
                        Image {
                            id: staticWallpaper
                            anchors.fill: parent
                            source:"qrc:/../../temporary-testing-assets/wallpaper.jpg"
                            fillMode:Image.PreserveAspectCrop
                        }
                        /*
                        Video{
                            source:"file:///home/yegender/HDD/MyFiles/Downloads/wall.mp4"
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            Component.onCompleted: {
                                play();
                            }
                            onStopped: {seek(0);play()}
                            muted: true
                            id:videoWallpaper
                        }
                        */
                    }
                    MouseArea{
                        anchors.fill: parent
                        acceptedButtons:Qt.RightButton
                        onClicked: menu.popup()
                        CM.DesktopContextMenu{id:menu}
                    }
                    Repeater{
                        model:shellSurfaces
                        property alias windowModel:windowRepeater.model
                        id:windowRepeater
                        Chrome{}
                    }
                }
                Dock{
                    y:parent.height-(height+10)
                    x:(parent.width/2)-(width/2)

                }
            }
        }
    }
    //<models>
    ListModel { id: shellSurfaces
        //ListElement{                         //For testing Tabs uncomment this
        //    tabs:[]
        //}
    }
    ListModel{                 //Dummy taskbar pinned list
        id:taskBarEntries
        ListElement{
            name:"Brave"
            cicon:"brave"
            exec:"brave"
        }

        ListElement{
            name:"Music aka Elisa"
            cicon:"elisa"
            exec:"elisa"
        }
        ListElement{
            name:"File Manager aka Dolphin"
            cicon:"org.kde.dolphin"
            exec:"dolphin"
        }
        ListElement{
            name:"Konsole aka Konsole"
            cicon:"konsole"
            exec:"konsole"
        }
        ListElement{
            name:"Calculator aka KCalc"
            cicon:"kcalc"
            exec:"kcalc"
        }
        ListElement{
            name:"QtCreator"
            cicon:"qtcreator"
            exec:"qtcreator"
        }
        ListElement{
            name:"Text Editor aka Kate"
            cicon:"kate"
            exec:"kate"
        }
        ListElement{
            name:"KDevelop"
            cicon:"kdevelop"
            exec:"kdevelop"
        }
    }
    //</models>

    //<shells>
    XdgShell {
        onToplevelCreated:{
            shellSurfaces.append({tabs:[{shellSurface:xdgSurface}]});
            //shellSurfaces.get(0).tabs.append({shellSurface:xdgSurface});             //Just for testing Tabs. Until proper drag and drop is implemented
        }
    }
    XdgDecorationManagerV1 {
        preferredMode: XdgToplevel.ServerSideDecoration
    }
    //</shells>

}
