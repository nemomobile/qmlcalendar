/****************************************************************************
**
** Copyright (C) 2012 Nicola De Filippo.
** All rights reserved.
** Contact: Nicola De Filippo (nicola.defilippo@lizard-solutions.com)
**
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** This qml components is replication of agenda meego how on N950
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
import "month.js" as Month
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import com.nokia.meego 1.0

Rectangle  {


    height: 400
    width: 454
    id:calendarView
    property int month: Month.today().getMonth()
    property int year: Month.today().getFullYear()
    property date firstDayOfMonth:new Date(year, month, 1)
    property int weekDayOfFirst:firstDayOfMonth.getDay()
    property Rectangle prevCircle
    property Text prevText
    property color background: "#e7e7e7"
    property color orange: "#ef5500"
    property string currentMonth: Month.getMonthName(Month.today()) + " " + year
    color:  background

    property date currentDate:new Date();

    property int day:currentDate.getDate()

    z:0



    property OrganizerModel organizer:OrganizerModel{
        id: organizer
        manager:"qtorganizer:memory:id=qml"
        startPeriod: currentDate
        endPeriod: Month.tomorrow(currentDate);
        autoUpdate:true
        Component.onCompleted : {
            console.log("ITEM " + organizer.itemCount)
            //if (managerName == "memory")
                /*organizer.importItems(Qt.resolvedUrl("qrc:/contents/test.ics"));*/
        }
    }


    Rectangle {
        width: parent.width
        color: background
        height: 60
        anchors.top: parent.top
        id: header
        Image {
            id: left
            source: "qrc:/images/left_arrow.png"
            anchors.left: parent.left

            MouseArea {
                id: mouseAreaL

                anchors.fill: parent

                onClicked: {
                    if (month > 0)
                        month--
                    else {
                        year--;
                        month = 11;
                    }

                    firstDayOfMonth = new Date(year, month, 1);
                    weekDayOfFirst = firstDayOfMonth.getDay();
                    month = firstDayOfMonth.getMonth();
                    year = firstDayOfMonth.getFullYear();
                    currentMonth = Month.getMonthName(firstDayOfMonth) + " " + year;


                }

            }


        }
        Image {
            id: right
            source: "qrc:/images/right_arrow.png"
            anchors.right: parent.right

            MouseArea {
                id: mouseAreaR

                anchors.fill: parent

                onClicked: {
                    if (month < 11)
                        month++
                    else {
                        year++;
                        month = 0;
                    }

                    firstDayOfMonth = new Date(year, month, 1);
                    weekDayOfFirst = firstDayOfMonth.getDay();
                    month = firstDayOfMonth.getMonth();
                    year = firstDayOfMonth.getFullYear();
                    currentMonth = Month.getMonthName(firstDayOfMonth) + " " + year;

                }

            }

        }

        DatePickerDialog {
             id: tDialog
             titleText: "Date of birth"
             onAccepted: callbackFunction()
         }

        Text {
            id: monthTitle
            text: currentMonth
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 14

            MouseArea {
                id: mouseAreaTitle

                anchors.fill: parent

                onClicked: {
                    tDialog.open();
                    //console.log("TITLE " + currentMonth);


                }

            }

        }
    }

    Grid {

        id:container

        anchors.fill: parent
        anchors.topMargin: 60

        columns: 7
        Repeater {
            model:["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            Rectangle { width: container.width / 7
                        height: 35
                        color: background

                        Text {
                            text: modelData

                            verticalAlignment: Text.AlignVCenter

                            anchors.centerIn: parent
                            color: (index > 4)?orange:"#737573"
                        }

            }
        }



        Repeater { model: 42

                   Rectangle {

                       id:dayContainer
                       width: container.width / 7
                       height: (container.height - 35) / 7

                       Rectangle {
//                           gradient:  Gradient {
//                                  GradientStop { id: stop1; position: 0.0; color: background }
//                                  GradientStop { id: stop2; position: 1.0; color: background }

//                              }
                           id: circle
                           radius: 8
                           color: orange
                           width: parent.width / 2
                           height: parent.height / 2
                           anchors.centerIn: parent
                           visible: {
                               if (Month.isToday(Month.today(),   index - weekDayOfFirst)) {
                                   prevCircle = circle;
                                   return true;
                               }
                               return false;

                           }

                       }

                       Text {

                           id: journey;
                           text: Month.getDayOfMonth(firstDayOfMonth,   index - weekDayOfFirst )

                           font.pointSize: 12
                           anchors.centerIn: parent
                           color: {
                               if (circle.visible) return "white";
                               else
                                   return Month.getColorOfDay(firstDayOfMonth,   index - weekDayOfFirst );
                           }


                       }


                       MouseArea {
                           id: mouseArea
                           hoverEnabled:true
                           anchors.fill: parent

                           onClicked: {
                                 if (prevText)
                                   prevText.color = "black";
                               prevText = journey;


                               prevCircle.visible = false;
                               circle.visible = true;

                               prevText = journey;
                               prevCircle = circle;


                                 var dum = year + "/" + (month + 1) + "/" + journey.text;
                                 currentDate= new Date(dum);
                                 console.log("DAy " + journey.text + " dum " + dum);

                                 dayView.opacity = 1;
                                 dayView.z = 1;

                                 //calendarView.opacity = 0;

                                 mainStack.pageStack.push(dayView);
                                toolBack.visible = true;
                           }

                       }
                   }
        }
    }


}
