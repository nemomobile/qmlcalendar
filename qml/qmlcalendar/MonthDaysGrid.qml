/*
 * Copyright (C) 2012 Nicola De Filippo (nicola.defilippo@lizard-solutions.com)
 *                    Ruediger Gad (r.c.g@gmx.de)
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in
 * the documentation and/or other materials provided with the
 * distribution.
 * * Neither the name of Nemo Mobile nor the names of its contributors
 * may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.0
import "month.js" as Month
import QtOrganizer 5.0
import com.nokia.meego 2.0

Grid {
    id: monthDaysGrid

    columns: 7


    property date firstDayOfMonth
    property int weekDayOfFirst
    property int selectedIndex
    property int oldSelectedIndex: -1


    onFirstDayOfMonthChanged: {
        console.log("First day of month changed.")
        weekDayOfFirst = Month.weekDayIdxByLocalizedDayName(firstDayOfMonth);

        updateSelection()
    }

    onSelectedIndexChanged: {
        if(oldSelectedIndex >= 0) {
            dayGridRepeater.itemAt(oldSelectedIndex).selected = false
        }

        var selectedDayItem = dayGridRepeater.itemAt(selectedIndex)
        selectedDayItem.selected = true

        oldSelectedIndex = selectedIndex
    }

    Component.onCompleted: {
        selectedIndex = weekDayOfFirst + new Date().getDate()
    }


    function updateSelection() {
        selectedIndex = weekDayOfFirst + calendarView.currentDate.getDate()
    }


    Repeater {
        id: dayGridRepeater
        model: 42

        Rectangle {
            id: dayDelegate
            width: monthDaysGrid.width / 7
            height: (monthDaysGrid.height - 35) / 7

            property bool selected: false
            property alias dayString: dayText.text

            Rectangle {
                id: dayHighlight

                radius: 8
                color: orange
                width: parent.width * 0.8
                height: parent.height * 0.8
                anchors.centerIn: parent
                visible: parent.selected
            }

            Text {
                id: dayText;

                text: Month.getDayOfMonth(firstDayOfMonth,   index - weekDayOfFirst )

                font.pointSize: parent.height * 0.5
                anchors.centerIn: parent
                color: parent.selected ? "white" : Month.getColorOfDay(firstDayOfMonth,   index - weekDayOfFirst )
            }

            MouseArea {
                id: mouseAreaDay
                hoverEnabled:true
                anchors.fill: parent

                onClicked: {
                    monthDaysGrid.selectedIndex = index

                    var dum = calendarView.currentDate.getFullYear() + "/" + (calendarView.currentDate.getMonth() + 1) + "/" + dayString;
                    var currentDate= new Date(dum);
                    console.log("Day " + dayString + " dum " + dum);
                    calendarView.currentDate = currentDate;
                }

                onDoubleClicked: {
                    mainStack.pageStack.push(dayView);
                }
            }
        }
    }
}
