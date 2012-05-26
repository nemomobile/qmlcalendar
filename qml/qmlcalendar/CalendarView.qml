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

Item  {
    id:calendarView

    height: (parent.height > parent.width) ? parent.width : parent.height
    width: height

    property int month: Month.today().getMonth()
    property int year: Month.today().getFullYear()
    property date firstDayOfMonth:new Date(year, month, 1)
    property int weekDayOfFirst:firstDayOfMonth.getDay()
    property Rectangle prevCircle
    property Text prevText
    property color background: "#e7e7e7"
    property color orange: "#ef5500"
    property string currentMonth: Month.getMonthName(Month.today()) + " " + year

    property date currentDate:new Date();

    property int day:currentDate.getDate()

    z:0


//    property OrganizerModel organizer:OrganizerModel{
    OrganizerModel{
        id: organizer
        //manager:"qtorganizer:mkcal:"
        //startPeriod: currentDate
        //endPeriod: Month.tomorrow(currentDate);
        startPeriod:'2011-01-01'
        endPeriod:'2012-12-31'
        autoUpdate:true
        Component.onCompleted : {
            console.log("manager " + organizer.manager + " ITEM " + organizer.itemCount)
            if (managerName == "mkcal") {
                //console.log("LOAD " + organizer.itemCount + " start " + organizer.startPeriod + " end " + organizer.endPeriod);

                //organizer.importItems(Qt.resolvedUrl("/home/user/MyDocs/qmlcalendar.ics"));
                //console.log("LOAD " + organizer.itemCount + " start " + organizer.startPeriod + " end " + organizer.endPeriod);
                console.log("current " + currentDate + " +60 " + Month.plus1Hour(currentDate));
            }
        }
        Component.onDestruction:  {
            console.log("Destroy ITEM " + organizer.itemCount)
            if (managerName == "mkcal") {
                console.log("Save");
                organizer.exportItems(Qt.resolvedUrl("/home/user/MyDocs/qmlcalendar.ics"));
            }
        }
    }

    DatePickerDialog {
         id: tDialog
         titleText: "Date of birth"
         onAccepted: callbackFunction()
    }


    Column {
        anchors.fill: parent

        Row {
            id: headerRow
            anchors{top: parent.top; left: parent.left; right: parent.right}
            height: parent.height * 0.125

            Item{
                id: previous

                anchors{left: parent.left; top: parent.top; bottom: parent.bottom}
                width: height

                Image {
                    anchors.centerIn: parent
                    source: "../../images/left_arrow.png"
                }

                MouseArea {
                    id: mouseAreaPrevious

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

            Item{
                id: next

                anchors{right: parent.right; top: parent.top; bottom: parent.bottom}
                width: height

                Image {
                    anchors.centerIn: parent
                    opacity: 1
                    source: "../../images/right_arrow.png"
                }

                MouseArea {
                    id: mouseAreaNext

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

            Item {
                id: monthTitle

                anchors{left: previous.right; right: next.left; top: parent.top; bottom: parent.bottom}

                Text {
                    anchors.fill: parent

                    text: currentMonth
                    font.pointSize: parent.height * 0.5
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

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

        Row{
            id: headingsLabelRow

            anchors{top: headerRow.bottom; topMargin: 8; left: parent.left; right: parent.right}
            height: parent.height * 0.08

            Repeater {
                id: headerLabelRepeater

                model:["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

                Text {
                    text: modelData

                    width: parent.width / 7
                    font.pointSize: parent.height * 0.5
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignHCenter

                    color: (index > 4)?orange:"#737573"
                }
            }
        }

        Grid {
            id:container

            anchors{top: headingsLabelRow.bottom; topMargin: 2; bottom: parent.bottom; left: parent.left; right: parent.right}

            columns: 7

            Repeater {
                model: 42

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
                        width: parent.width * 0.8
                        height: parent.height * 0.8
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

                        font.pointSize: parent.height * 0.5
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
                            console.log("Day " + journey.text + " dum " + dum);

                            dayView.opacity = 1;
                            dayView.z = 1;

                            //calendarView.opacity = 0;

                            console.log("N ITEM " + organizer.itemCount);
                            var items = organizer.items;
                            var i;
                            for (i = 0; i < organizer.itemCount;i++) {
                                console.log("item " + i + " start date" + items[i].itemStartTime);
                            }
                        }

                        onDoubleClicked: {
                            mainStack.pageStack.push(dayView);
                            toolBack.visible = true;
                        }
                    }
                }
            }
        }
    }
}
