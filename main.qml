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
            title:"CFWM"
            visibility: "FullScreen"
            visible:true
            Image {
                id: wallpaper
                source: "qrc:/wallpaper.jpg"
                anchors.fill: parent
                cache: true
                fillMode: Image.PreserveAspectCrop
            }
            MouseArea{
                anchors.fill: parent
                acceptedButtons:Qt.RightButton
                onClicked: menu.popup()
                CM.DesktopContextMenu{id:menu}
            }
            Repeater{
                model:shellSurfaces
                property alias windowModel:model
                id:windowRepeater
                Rectangle{
                    color:"transparent"
                    border.color:"#88000000"
                    border.width: 5
                    x:200
                    y:200
                    id:windowRect
                    property int windowIndex:index
                    width:640
                    height:480
                    radius:5
                    //![mouseResizeHelpers]
                    Item{
                        anchors.fill: parent
                        //TopEdge
                        MouseArea{
                            width:parent.width-10
                            x:5
                            y:0
                            height:1
                            cursorShape: Qt.SizeVerCursor
                            Item{
                                id:topEdgeTarget
                                anchors.fill: parent
                            }
                            drag.target: topEdgeTarget
                            drag.axis: Drag.YAxis
                            onMouseYChanged: {
                                if(drag.active){
                                    windowRect.y = windowRect.y + mouseY;
                                    windowRect.height = windowRect.height - mouseY;
                                }
                            }
                        }
                        //BottomEdge
                        MouseArea{
                            width:parent.width-10
                            x:5
                            y:parent.height-1
                            height:1
                            cursorShape: Qt.SizeVerCursor
                            Item{
                                id:bottomEdgeDragTarget
                                anchors.fill: parent
                            }
                            drag.target:bottomEdgeDragTarget
                            drag.axis: Drag.YAxis
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.height = windowRect.height+mouseY;
                                }
                            }
                        }
                        //LeftEdge
                        MouseArea{
                            height:parent.height-10
                            x:0
                            y:5
                            width: 1
                            Item{
                                id:leftEdgeDragTarget
                                anchors.fill: parent
                            }
                            drag.target:leftEdgeDragTarget
                            drag.axis: Drag.XAxis
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.width = windowRect.width - mouseX;
                                    windowRect.x = windowRect.x + mouseX;
                                }
                            }
                            cursorShape: Qt.SizeHorCursor
                        }
                        //RightEdge
                        MouseArea{
                            height:parent.height-10
                            x:parent.width-1
                            width:1
                            y:5
                            Item{
                                id:rightEdgeDragTarget
                                anchors.fill: parent
                            }
                            cursorShape: Qt.SizeHorCursor
                            drag.target:rightEdgeDragTarget
                            drag.axis: Drag.XAxis
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.width = windowRect.width+mouseX;
                                }
                            }
                        }
                        //Top Left Corner
                        MouseArea{
                            width:5
                            x:0
                            y:0
                            height:5
                            Item{
                                anchors.fill: parent
                                id:topLeftCornerDragTarget
                            }
                            cursorShape: Qt.SizeFDiagCursor
                            drag.target:topLeftCornerDragTarget
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.width = windowRect.width - mouseX
                                    windowRect.x = windowRect.x + mouseX
                                }
                            }
                            onMouseYChanged: {
                                if(drag.active){
                                    windowRect.height = windowRect.height - mouseY
                                    windowRect.y = windowRect.y + mouseY
                                }
                            }
                        }
                        //Top Right Corner
                        MouseArea{
                            height:5
                            x:parent.width-5
                            y:0
                            width: 5
                            cursorShape: Qt.SizeBDiagCursor
                            Item{
                                id:topRightCornerDragTarget
                                anchors.fill: parent
                            }
                            drag.target:topRightCornerDragTarget
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.width = windowRect.width + mouseX;
                                }
                            }
                            onMouseYChanged: {
                                if(drag.active){
                                    windowRect.height = windowRect.height - mouseY;
                                    windowRect.y = windowRect.y + mouseY;
                                }
                            }
                        }
                        //Bottom Left Corner
                        MouseArea{
                            height:5
                            x:0
                            width:5
                            y:parent.height-5
                            cursorShape: Qt.SizeBDiagCursor
                            Item{
                                id:bottomLeftCornerDragTarget
                                anchors.fill: parent
                            }
                            drag.target:bottomRightCornerDragTarget
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.width = windowRect.width - mouseX;
                                    windowRect.x = windowRect.x + mouseX;
                                }
                            }
                            onMouseYChanged: {
                                if(drag.active){
                                    windowRect.height = windowRect.height+mouseY;
                                }
                            }
                        }
                        //Bottom Right Corner
                        MouseArea{
                            height:5
                            x:parent.width-5
                            y:parent.height-5
                            width:5
                            cursorShape: Qt.SizeFDiagCursor
                            Item{
                                id:bottomRightCornerDragTarget
                                anchors.fill: parent
                            }
                            drag.target:bottomRightCornerDragTarget
                            onMouseXChanged: {
                                if(drag.active){
                                    windowRect.width = windowRect.width+mouseX;
                                }
                            }
                            onMouseYChanged: {
                                if(drag.active){
                                    windowRect.height = windowRect.height+mouseY;
                                }
                            }
                        }
                    }
                    //![mouseResizeHelpers]
                    Rectangle{
                        id:titleBar
                        x:parent.border.width
                        width:parent.width-10
                        y:parent.border.width
                        height:35
                        color:"#88000000"
                        //Title Bar Draging
                        MouseArea{anchors.fill: titleBar;drag.target: windowRect}

                        //Window Controls
                        Rectangle{
                            anchors.right: parent.right
                            height:30
                            color:"#20ffffff"
                            width:100
                            radius:5
                            id:windowControlsRect
                            RowLayout{
                                spacing:5
                                anchors.fill: parent
                                Button{
                                    implicitWidth: parent.height
                                    implicitHeight: parent.height
                                    background:Rectangle{
                                        color:"transparent"
                                    }
                                    padding:0
                                    icon.color:"white"
                                    icon.width:32
                                    icon.cache: true
                                    icon.height:32
                                    icon.name:"window-maximize-symbolic"
                                }
                                Button{
                                    implicitWidth: parent.height
                                    implicitHeight: parent.height
                                    padding:0
                                    background:Rectangle{
                                        color:"transparent"
                                    }
                                    icon.color:"white"
                                    icon.cache: true
                                    icon.width:32
                                    icon.height:32
                                    icon.name:"window-minimize-symbolic"
                                }
                                Button{
                                    implicitWidth: parent.height
                                    padding:0
                                    implicitHeight: parent.height
                                    background:Rectangle{
                                        color:"transparent"
                                    }
                                    icon.color:"white"
                                    icon.width:32
                                    icon.cache: true
                                    icon.height:32
                                    icon.name:"window-close-symbolic"
                                }
                            }
                        }

                        //Tabs
                        TabBar{
                            x:0
                            y:0
                            height:parent.height-5
                            //width:parent.width-(windowControlsRect.width+5)
                            background: Rectangle{color:"transparent"}
                            spacing:5
                            id:windowTabBar
                            Repeater{
                                model:modelData
                                property alias tabModel:model
                                id:tabRepeater
                                TabButton{
                                    property int windowIndex:index
                                    width:titleLabel.width+80 > 150 ? titleLabel.width+100 : 150
                                    height:30
                                    spacing:5
                                    Label{
                                        id:titleLabel
                                        anchors.centerIn: parent
                                        text:modelData.toplevel.title
                                        color:"white"
                                        //font.pixelSize: 17
                                    }
                                    Button{
                                        padding:3
                                        anchors.right: parent.right
                                        height:30
                                        width:30
                                        background:Item{}
                                        icon.color: "white"
                                        icon.name: "window-close-symbolic"

                                        icon.width: 24
                                        icon.height: 24
                                        icon.cache: true

                                    }
                                    Button{
                                        padding:3
                                        width:30
                                        height:30
                                        icon.name:modelData.toplevel.appId
                                        icon.width: 24
                                        icon.height: 24
                                        background:Item{}
                                        icon.color: "transparent"
                                        enabled: false
                                        x:0
                                        y:0
                                    }

                                    text:" " //Workaround to keep things normal :(
                                    background: Rectangle{
                                        color:"#20ffffff"
                                        radius:5
                                        width:parent.width
                                    }
                                }
                            }
                        }
                    }
                    StackLayout{
                        id:windowStack
                        width: parent.width-10
                        height:parent.height-45
                        x:5
                        y:40
                        currentIndex: windowTabBar.currentIndex
                        Repeater{
                            property alias stackModel:model
                            id:stackRepeater
                            model:modelData
                            ShellSurfaceItem{
                                shellSurface: modelData
                                onWidthChanged: {
                                    modelData.toplevel.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
                                }
                                onHeightChanged: {
                                    modelData.toplevel.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
                                }
                                Component.onCompleted: {
                                    modelData.toplevel.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
                                }
                                sizeFollowsSurface: true
                                //onSurfaceDestroyed:
                                //onActiveFocusChanged: {if(modelData.toplevel.activated){
                                //    windowRect.z = 1;}
                                //else
                                //    {windowRect.z = 0;}
                                //}

                            }
                        }
                    }
                }
            }

            Dock{}
            ListModel{
                id:aa
                ListElement{bb:[ListElement{cc:"dd"},
                                ListElement{cc:"dd"}]}
                ListElement{bb:[ListElement{cc:"dd"},
                                ListElement{cc:"dd"}]}
            }
            Component.onCompleted: {aa.get(0)}
        }
    }
    //<models>
    ListModel { id: shellSurfaces }
    ListModel{
        id:taskBarEntries
        ListElement{
            name:"Music aka Elisa"
            cicon:"elisa"
            exec:"elisa"
        }
        ListElement{
            name:"File Manager aka Dolphin"
            cicon:"org.kde.dolphin"
            exec:"dolphin -platform wayland"
        }
        ListElement{
            name:"Konsole aka Konsole"
            cicon:"konsole"
            exec:"konsole -platform wayland"
        }
        ListElement{
            name:"Calculator aka KCalc"
            cicon:"kcalc"
            exec:"kcalc -platform wayland"
        }
        ListElement{
            name:"QtCreator"
            cicon:"qtcreator"
            exec:"qtcreator -platform wayland"
        }
        ListElement{
            name:"Text Editor aka Kate"
            cicon:"kate"
            exec:"kate -platform wayland"
        }
        ListElement{
            name:"KDevelop"
            cicon:"kdevelop"
            exec:"kdevelop -platform wayland"
        }
        ListElement{
            name:"Builder"
            cicon:"builder"
            exec:"builder"
        }
        ListElement{
            name:"GParted"
            cicon:"gparted"
            exec:"gparted"
        }
        ListElement{
            name:"Inkscape"
            cicon:"inkscape"
            exec:"inkscape"
        }
        ListElement{
            name:"GIMP"
            cicon:"gimp"
            exec:"gimp"
        }
        ListElement{
            name:"Virtualbox"
            cicon:"virtualbox"
            exec:"virtualbox -platform wayland"
        }
    }
    //</models>

    //<shells>
    XdgShell {
        onToplevelCreated:{
            shellSurfaces.append({tabs:[{shellSurface:xdgSurface}]});
            //xdgSurface.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
        }
    }
    XdgDecorationManagerV1 {
        preferredMode: XdgToplevel.ServerSideDecoration
    }
    //</shells>

}
