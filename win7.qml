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
import QtQuick.Controls 2.15
import QtQuick.Window 2.3
import QtWayland.Compositor 1.15
import QtGraphicalEffects 1.15
WaylandCompositor{
    id:comp
    WaylandOutput{
        compositor: comp
        sizeFollowsWindow: true
        id:output
        window: Window{
            title:"Compositor Example"
            visible:true
            width:1280
            height:720
            visibility: "FullScreen"
            WaylandMouseTracker {
                id: mouseTracker
                anchors.fill: parent
                //windowSystemCursorEnabled: output.isNestedCompositor
                windowSystemCursorEnabled: true
                Image {
                    id: wallpaper
                    source: "https://wparena.com/wp-content/uploads/2009/09/img8.jpg"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                }
                Item{
                    x:0
                    y:0
                    width:parent.width
                    height:parent.height-dock.height
                    Repeater{
                        model:shellSurfaces
                        //ShellSurfaceItem{
                        //    shellSurface: modelData
                        //    onSurfaceDestroyed: shellSurfaces.remove(index)
                        //    //touchEventsEnabled: true
                        //}
                        Rectangle {
                            id: chrome
                            width: shellSurfaceItem.implicitWidth+20
                            height:shellSurfaceItem.implicitHeight+50
                            radius: 10
                            color:"#88000000"
                            border.color:"white"
                            visible: modelData.toplevel.decorationMode === XdgToplevel.ServerSideDecoration
                            border.width:1
                            Item{
                                x:10
                                y:0
                                id:titleBar
                                height:40
                                width:parent.width-20
                                Label{
                                    text:modelData.toplevel.title
                                    color:"white"
                                    x:0
                                    y:(parent.height/2)-(height/2)
                                }
                                Image {
                                    id: closeButton
                                    source: "https://cdn.discordapp.com/attachments/1028974230672523294/1041012510276468776/unknown.png"
                                    x:parent.width-width
                                    y:0
                                    cache:true
                                    height:30*0.8
                                    width:69.7*0.8
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: modelData.toplevel.sendClose()
                                    }
                                }
                                Image{
                                    id:maximizeButton
                                    source:"https://cdn.discordapp.com/attachments/1028974230672523294/1041012509949317140/unknown.png"
                                    y:0
                                    x:parent.width-(width+closeButton.width)
                                    height:30*0.8
                                    cache:true
                                    width:42.8*0.8
                                }
                                Image{
                                    id:minimizeButton
                                    cache:true
                                    y:0
                                    x:parent.width-(width+closeButton.width+maximizeButton.width)
                                    height:30*0.8
                                    width:42.8*0.8
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {modelData.toplevel.setMinimize=true;console.log(modelData.toplevel.minimize);}
                                    }

                                    source:"https://cdn.discordapp.com/attachments/1028974230672523294/1041012509638926347/unknown.png"
                                }

                                DragHandler {
                                    target: chrome
                                }
                            }
                            ShellSurfaceItem {
                                x:10
                                y:40
                                id: shellSurfaceItem
                                moveItem: parent
                                shellSurface: modelData
                                onSurfaceDestroyed: shellSurfaces.remove(index)
                            }
                        }
                    }
                }
                Rectangle{
                    clip:true
                    height:700
                    width:575
                    y:parent.height-(height+48)
                    x:10
                    visible: false
                    color:"transparent"
                    Rectangle{
                        //height:700
                        //width:575
                        //y:parent.height-(height+48+10)
                        //x:10
                        x:0
                        y:0
                        width:parent.width
                        height:parent.height-10
                        radius:10
                        id:startMenu
                        border.width: 1
                        border.color: "white"
                        color:"#88000000"
                        Rectangle{
                            id:leftPane
                            height:parent.height-20
                            width:parent.width-195
                            x:10
                            y:10
                            radius:10
                        }
                        Item{
                            id:rightPane
                            height:parent.height-20
                            width:165
                            x:parent.width-175
                            y:10
                            ColumnLayout{
                                x:0;y:80
                                width:parent.width
                                height:childrenRect.height-(y+60)
                                spacing:10
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Yegender"}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Documents"}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Pictures"}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Music"}
                                Item{width:parent.width;height:1;Rectangle{width:parent.width-20;height:1;anchors.centerIn: parent}}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Games"}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Computer"}
                                Item{width:parent.width;height:1;Rectangle{width:parent.width-20;height:1;anchors.centerIn: parent}}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Settings"}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Appearance"}
                                StartMenuLeftPaneButton{width:parent.width;height:40;label: "Devices"}
                            }
                        }
                        StartMenuRightIconButton{width:40;height:40;anchors.right: parent.right;anchors.bottom: parent.bottom;
                            anchors.rightMargin: 10;anchors.bottomMargin: 10;icon.name:"system-shutdown-symbolic";icon.width:32;icon.height:32;icon.color:"white"}
                    }
                }
                Rectangle{
                    height:48
                    width:parent.width
                    color:"#88000000"
                    x:0
                    y:parent.height-height
                    id:dock
                    Rectangle{x:0;y:0;width:parent.width;height:1}
                }
                WaylandCursorItem {
                    inputEventsEnabled: false
                    x: mouseTracker.mouseX
                    y: mouseTracker.mouseY
                    seat: output.compositor.defaultSeat
                }
            }

        }
    }
    ListModel{id: shellSurfaces}
    //Wl Shell is depreceated as I heard
    //WlShell {
    //    onWlShellSurfaceCreated:
    //        shellSurfaces.append({shellSurface: shellSurface});
    //}
    XdgShell {
        onToplevelCreated:{
            shellSurfaces.append({shellSurface: xdgSurface});

            //xdgSurface.sendConfigure(Qt.size(ssi.width,ssi.height),XdgShellSurface.NoneEdge);
        }
    }
    XdgDecorationManagerV1 {
        preferredMode: XdgToplevel.ServerSideDecoration
    }
    //IviApplication {
    //    onIviSurfaceCreated: {
    //        shellSurfaces.append({shellSurface: iviSurface});
    //        //iviSurface.sendConfigure(Qt.size(ssi.width,ssi.height),IviShellSurface.NoneEdge);
    //    }
    //}

}
