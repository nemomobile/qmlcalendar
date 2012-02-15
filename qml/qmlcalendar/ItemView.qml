import Qt 4.7

import QtMobility.organizer 1.1

Rectangle
{
    id:itemView
    property string  itemId
    property OrganizerItem item
    property int startTime
    property int endTime
    onItemIdChanged :{
        if (itemId != "") {
            item = calendarView.organizer.item(itemId);
            startTime = item.itemStartTime.getHours() * 60 + item.itemStartTime.getMinutes();
            endTime = item.itemEndTime.getHours() * 60 + item.itemEndTime.getMinutes();
            itemLabel.text = item.displayLabel;
            itemDesc.text = item.description;
        }
    }
    radius: 5
    color: "steelblue"

    Column {
        spacing: 2
        Text { id: itemLabel; color: "yellow"; wrapMode: Text.Wrap;  font.bold: true; horizontalAlignment: Text.AlignHCenter; style: Text.Raised; verticalAlignment: Text.AlignVCenter; font.pointSize: 12; text:"ciao" }
        Text { id: itemDesc; color: "white"; wrapMode: Text.Wrap;  font.pointSize: 10; text:"ciao"}
    }

    MouseArea {
        anchors.fill: parent
        onClicked : {
            detailsView.itemId = itemId
            //calendarView.state = "DetailsView"
        }
    }
}
