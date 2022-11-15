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
                property alias windowModel:windowRepeater.model
                id:windowRepeater
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
