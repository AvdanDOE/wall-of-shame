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
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.3
import QtWayland.Compositor 1.15
import QtGraphicalEffects 1.15

Item{
    property int windowIndex:index
    anchors.fill: parent
    id:chrome
    DropShadow{
        samples:20
        radius: 10
        source:windowItem
        width:windowItem.width
        height:windowItem.height
        x:windowItem.x
        y:windowItem.y
    }
    Repeater{
        model: {
            var m = [];
            m.push(wallpaper);
            let i=0;
            for (i=0;i < index;i++){
                m.push(windowRepeater.itemAt(i));
            };
            return m
        }
        Item{
            anchors.fill: parent
            ShaderEffectSource{
                x:windowItem.x
                y:windowItem.y
                width:windowItem.width
                height:windowItem.height
                sourceRect: Qt.rect(x,y,width,height)
                id:be
                visible: false
                sourceItem:modelData
            }
            FastBlur{
                source:be
                radius:50
                id:blur2
                anchors.fill: be
                visible: false
            }
            OpacityMask {
                source: blur2
                anchors.fill: be
                maskSource: Item{
                    width:windowItem.width
                    height:windowItem.width
                    Rectangle {
                        anchors.fill: parent
                        radius: windowRect.radius
                        color:"#ffffff"
                    }
                }
            }
        }
    }
    Item{
        id:windowItem
        x:200
        y:200
        width:1280
        height:720

        Rectangle{
            color:"transparent"
            border.color:"#88000000"
            border.width: 5
            anchors.fill: parent
            id:windowRect
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
                            windowItem.y = windowItem.y + mouseY;
                            windowItem.height = windowItem.height - mouseY;
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
                            windowItem.height = windowItem.height+mouseY;
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
                            windowItem.width = windowItem.width - mouseX;
                            windowItem.x = windowItem.x + mouseX;
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
                            windowItem.width = windowItem.width+mouseX;
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
                            windowItem.width = windowItem.width - mouseX
                            windowItem.x = windowItem.x + mouseX
                        }
                    }
                    onMouseYChanged: {
                        if(drag.active){
                            windowItem.height = windowItem.height - mouseY
                            windowItem.y = windowItem.y + mouseY
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
                            windowItem.width = windowItem.width + mouseX;
                        }
                    }
                    onMouseYChanged: {
                        if(drag.active){
                            windowItem.height = windowItem.height - mouseY;
                            windowItem.y = windowItem.y + mouseY;
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
                            windowItem.width = windowItem.width - mouseX;
                            windowItem.x = windowItem.x + mouseX;
                        }
                    }
                    onMouseYChanged: {
                        if(drag.active){
                            windowItem.height = windowItem.height+mouseY;
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
                            windowItem.width = windowItem.width+mouseX;
                        }
                    }
                    onMouseYChanged: {
                        if(drag.active){
                            windowItem.height = windowItem.height+mouseY;
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
                clip:false
                color:"#88000000"
                //Title Bar Draging
                DragHandler{
                    target:windowItem
                }

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
                            onClicked: {
                                for (let i=0;i < modelData.count;i++){
                                    shellSurfaces.get(windowIndex).tabs.get(i).shellSurface.toplevel.sendClose();
                                }

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
                    clip: false
                    background: Rectangle{color:"transparent"}
                    spacing:5
                    id:windowTabBar
                    DragHandler{
                        target: windowItem
                    }

                    Repeater{
                        model:modelData
                        property alias tabModel:tabRepeater.model
                        id:tabRepeater
                        TabButton{
                            property point beginDrag;
                            property bool caught: false
                            property int windowIndex:index
                            width:titleLabel.width+80 > 150 ? titleLabel.width+100 : 150
                            height:30
                            spacing:5
                            MouseArea{
                                anchors.fill: parent
                                //drag.target:parent
                                //drag.axis: Drag.XAndYAxis
                                onClicked: windowStack.currentIndex = index
                                //onPressed: {
                                //    parent.beginDrag = Qt.point(parent.x, parent.y);
                                //}
                                //onReleased: {
                                //    if(!parent.caught) {
                                //        backAnimX.from = parent.x;
                                //        backAnimX.to = parent.beginDrag.x;
                                //        backAnimY.from = parent.y;
                                //        backAnimY.to = parent.beginDrag.y;
                                //        backAnim.start()
                                //    }
                                //}
                            }
                            //ParallelAnimation {
                            //    id: backAnim
                            //    NumberAnimation { id: backAnimX; target: parent; property: "x"; duration: 200;}
                            //    NumberAnimation { id: backAnimY; target: parent; property: "y"; duration: 200;}
                            //}
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
                                onClicked: modelData.toplevel.sendClose()
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
                //DropArea{
                //    x:windowTabBar.width
                //    y:-5
                //    height:parent.height+5
                //    width:parent.width-(windowTabBar.width+windowControlsRect.width)
                //    onEntered: {drag.source.caught = true;console.log("drag.source.titleLabel.text")}
                //    onExited: {drag.source.caught = false;console.log("drag.source.titleLabel.text.ex")}
                //}
            }
            StackLayout{
                id:windowStack
                width: parent.width-10
                height:parent.height-45
                x:5
                y:40
                Repeater{
                    property alias stackModel:stackRepeater.model
                    id:stackRepeater
                    model:modelData
                    ShellSurfaceItem{
                        property int stackIndex:index
                        property bool activated:modelData.toplevel.activated
                        shellSurface: modelData
                        onWidthChanged: modelData.toplevel.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
                        onHeightChanged: {
                            modelData.toplevel.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
                        }
                        Component.onCompleted: {
                            modelData.toplevel.sendConfigure(Qt.size(windowStack.width,windowStack.height),XdgSurface);
                            chrome.z = activated ? 1 : 0
                        }
                        sizeFollowsSurface: true
                        onSurfaceDestroyed:{
                            if(shellSurfaces.get(windowIndex).tabs.count == 1){
                                shellSurfaces.remove(windowIndex);
                            } else {
                                shellSurfaces.get(windowIndex).tabs.remove(index);
                            }

                        }
                        onActivatedChanged: activated ? 1 : 0
                    }
                }
            }
        }
    }
}
