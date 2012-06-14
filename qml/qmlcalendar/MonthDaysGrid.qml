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

Grid {
    id: monthDaysGrid

    columns: 7


    property date firstDayOfMonth
    property int weekDayOfFirst


    onFirstDayOfMonthChanged: {
        weekDayOfFirst = Month.dayIdxByLocalizedDayName(firstDayOfMonth);
    }


    Repeater {
        model: 42

        Rectangle {
            id: dayContainer
            width: monthDaysGrid.width / 7
            height: (monthDaysGrid.height - 35) / 7

            Rectangle {
                id: circle

                //                           gradient:  Gradient {
                //                                  GradientStop { id: stop1; position: 0.0; color: background }
                //                                  GradientStop { id: stop2; position: 1.0; color: background }

                //                              }

                radius: 8
                color: orange
                width: parent.width * 0.8
                height: parent.height * 0.8
                anchors.centerIn: parent
                visible: false
            }

            Text {
                id: journey;

                text: Month.getDayOfMonth(firstDayOfMonth,   index - weekDayOfFirst )

                font.pointSize: parent.height * 0.5
                anchors.centerIn: parent
                color: {
                    if (circle.visible) return "white";
                    else
                        return Month.getColorOfDay(firstDayOfMonth,   index - weekDayOfFirst );
                }
            }

            MouseArea {
                id: mouseAreaDay
                hoverEnabled:true
                anchors.fill: parent

                onClicked: {
                    if (prevText)
                        prevText.color = "black";
                    prevText = journey;

                    if(prevCircle)
                        prevCircle.visible = false;
                    circle.visible = true;

                    prevText = journey;
                    prevCircle = circle;

                    dayView.opacity = 1;
                    //dayView.z = 1;

                    //calendarView.opacity = 0;

                    console.log("N ITEM " + organizer.itemCount);
                    var items = organizer.items;
                    var i;
                    for (i = 0; i < organizer.itemCount;i++) {
                        console.log("item " + i + " start date" + items[i].itemStartTime);
                    }
                }

                onDoubleClicked: {
                    var dum = year + "/" + (month + 1) + "/" + journey.text;
                    var currentDate= new Date(dum);
                    console.log("Day " + journey.text + " dum " + dum);
                    calendarView.currentDate = currentDate;
                    mainStack.pageStack.push(dayView);
                }
            }
        }
    }
}
