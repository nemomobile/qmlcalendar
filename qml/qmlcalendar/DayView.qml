/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt 4.7

import QtMobility.organizer 1.1

Rectangle
{
    id:dayView
    property variant calendarView;
    property variant itemIds:calendarView.organizer.itemIds(calendarView.currentDate, new Date(calendarView.year, calendarView.month, calendarView.day+1))



    ListView {
        anchors.fill: parent
        id: hourList
        model : hourModel
        delegate : hourDelegate
    }

        Component {
                id: hourDelegate


                Item {
                    width : hourList.width
                    height : childrenRect.height
                    property int rowIndex : index
                    id:hourDelegateInstanceItem

                    Column {
                        // Draw a line under the previous Hour list tiem
                        Rectangle {
                            height : 1
                            width : hourList.width
                            color : "black"
                        }

                        Text {
                           // text: hour
                            id: dum
                            text: index + ":00"
                            width: hourList.width
                             font.pointSize: 18
                           // property OrganizerItem oi: calendarView.organizer.item(repeater.modelData)
                             MouseArea {
                                id: mouseAreaHour

                                anchors.fill: parent

                                onClicked: {
                                     console.log("hour " + dum.text);
                                     hourList.currentIndex = index;
                                     whatItem.startTime = dum.text;
                                     whatItem.day = Qt.formatDate(calendarView.currentDate, "dd-MM-yy");
                                    //console.log("index " + repeater.model.);
                                    var items = calendarView.organizer.itemIds(new Date(calendarView.year, calendarView.month, calendarView.day)
                                                                                   , new Date(calendarView.year, calendarView.month, calendarView.day+1));
                                    var item = null;
                                    if (items) {
                                        var i;
                                        console.log("ITEM length " + items.length);
                                        for (i = 0; i < items.length; i++) {
                                            var itemo = calendarView.organizer.item(items[i]);
                                            console.log("time " + (Qt.formatTime( itemo.startDateTime, "h" ) + ":00") + " dum.text " + dum.text);
                                            if ( (Qt.formatTime( itemo.startDateTime, "h" ) + ":00") === dum.text) {
                                                console.log("ITEM START TIME" + itemo.startDateTime + " " + Qt.formatTime( itemo.startDateTime, "hh" ));
                                                item = calendarView.organizer.item(items[i]);
                                                break;
                                            }
                                        }

                                        if (item)
                                            console.log("item.desc " + item.description)
                                    }


                                     dayView.opacity = 0;
                                     whatItem.opacity = 1;
                                }
                            }
                        }



                        // List all, if any, of the events within this hour.
                        Repeater {

                            focus: true
                            id: repeater
                            // Simple fetch ALL events on this day...and we will filter them by hour.
                            model: calendarView.organizer.items? calendarView.organizer.itemIds(new Date(calendarView.year, calendarView.month, calendarView.day)
                                                                                        , new Date(calendarView.year, calendarView.month, calendarView.day+1))
                                                           : 0

                            Row {

                                spacing:  4


                                Text {
                                    id: itemText
                                    clip: true
                                    focus: true
                                    property OrganizerItem oi: calendarView.organizer.item(modelData)

                                    text: ((hourDelegateInstanceItem.rowIndex == Qt.formatTime(oi.startDateTime, "hh")) ?  oi.description:"")

                                }

                            }
                        }
                    }
                }

            }


/*
        Component {
                 id: dayDelegate
                 Rectangle {
                     id: wrapper
                     width: 180
                     height: 40
                     //color: ListView.index ? "black" : "red"
                     Text {
                         id: time
                         text: hour
                         color: wrapper.ListView.isCurrentItem ? "red" : "black"
                         font.pointSize: 18
                     }
                     Text {
                         anchors {left: time.right}
                         id: infoTime
                         text: description
                         color: wrapper.ListView.isCurrentItem ? "red" : "black"
                         font.pointSize: 18
                     }
                     MouseArea {
                         id: mouseAreaHour

                         anchors.fill: parent

                         onClicked: {
                             console.log("hour " + time.text);
                             hourList.currentIndex = index;
                             whatItem.startTime = time.text;
                             whatItem.day = Qt.formatDate(calendarView.currentDate, "dd-MM-yy");
                             dayView.opacity = 0;
                             whatItem.opacity = 1;
                        }
                     }
                 }
             }
        model: dayModel
        //z:1
        delegate: dayDelegate
        //focus: true
        highlight: Rectangle { color: "red"; radius: 5 }
        highlightFollowsCurrentItem: true
    }
*/


    /*gradient: Gradient {
             GradientStop { position: 0.0; color: "lightsteelblue" }
             GradientStop { position: 1.0; color: "blue" }
         }
    */
    /*
     ListModel {
         id:dayModel
         ListElement {hour : "0:00"; description : {calendarView.organizer.itemCount();}}
                ListElement {hour : "1:00"; description : "2";}
                ListElement {hour : "2:00"; description : "3";}
                ListElement {hour : "3:00"; description : "4";}
                ListElement {hour : "4:00"; description : "5";}
                ListElement {hour : "5:00"; description : "";}
                ListElement {hour : "6:00"; description : "";}
                ListElement {hour : "7:00"; description : "";}
                ListElement {hour : "8:00"; description : "";}
                ListElement {hour : "9:00"; description : "";}
                ListElement {hour : "10:00"; description : "";}
                ListElement {hour : "11:00"; description : "";}
                ListElement {hour : "12:00"; description : "";}
                ListElement {hour : "13:00"; description : "";}
                ListElement {hour : "14:00"; description : "";}
                ListElement {hour : "15:00"; description : "";}
                ListElement {hour : "16:00"; description : "";}
                ListElement {hour : "17:00"; description : "";}
                ListElement {hour : "18:00"; description : "";}
                ListElement {hour : "19:00"; description : "";}
                ListElement {hour : "20:00"; description : "";}
                ListElement {hour : "21:00"; description : "";}
                ListElement {hour : "22:00"; description : "";}
                ListElement {hour : "23:00"; description : "";}
            }
        */ListModel {
        id : hourModel
        ListElement {hour : "0:00"}
        ListElement {hour : "1:00"}
        ListElement {hour : "2:00"}
        ListElement {hour : "3:00"}
        ListElement {hour : "4:00"}
        ListElement {hour : "5:00"}
        ListElement {hour : "6:00"}
        ListElement {hour : "7:00"}
        ListElement {hour : "8:00"}
        ListElement {hour : "9:00"}
        ListElement {hour : "10:00"}
        ListElement {hour : "11:00"}
        ListElement {hour : "12:00"}
        ListElement {hour : "13:00"}
        ListElement {hour : "14:00"}
        ListElement {hour : "15:00"}
        ListElement {hour : "16:00"}
        ListElement {hour : "17:00"}
        ListElement {hour : "18:00"}
        ListElement {hour : "19:00"}
        ListElement {hour : "20:00"}
        ListElement {hour : "21:00"}
        ListElement {hour : "22:00"}
        ListElement {hour : "23:00"}
    }



}
