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

import QtQuick 1.1
import QtMobility.organizer 1.1

Rectangle
{
    id:itemView

    radius: 5
    color: "steelblue"

    property string  itemId
    property OrganizerItem item
    property int startTime
    property int endTime
    property variant calendarView;

    onItemIdChanged : {
        if (itemId != "") {
            item = calendarView.organizer.item(itemId);
            startTime = item.itemStartTime.getHours() * 60 + item.itemStartTime.getMinutes();
            endTime = item.itemEndTime.getHours() * 60 + item.itemEndTime.getMinutes();
            itemLabel.text = item.displayLabel;
            itemDesc.text = item.description;
        }
    }

    Column {
        spacing: 2
        Text { id: itemLabel; color: "yellow"; wrapMode: Text.Wrap;  font.bold: true; horizontalAlignment: Text.AlignHCenter; style: Text.Raised; verticalAlignment: Text.AlignVCenter; font.pointSize: 12;  }
        Text { id: itemDesc; color: "black"; wrapMode: Text.Wrap;  font.pointSize: 10; text:itemLabel.text}
    }

    MouseArea {
        anchors.fill: parent
        onClicked : {
            detailsView.itemId = itemId
        }
    }
}
