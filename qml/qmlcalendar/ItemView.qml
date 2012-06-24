import QtQuick 1.1
import QtMobility.organizer 1.1

Rectangle
{
    id:itemView
    property string  itemId
    property OrganizerItem item
    property int startTime
    property int endTime
    property variant calendarView;
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
        Text { id: itemLabel; color: "yellow"; wrapMode: Text.Wrap;  font.bold: true; horizontalAlignment: Text.AlignHCenter; style: Text.Raised; verticalAlignment: Text.AlignVCenter; font.pointSize: 12;  }
        Text { id: itemDesc; color: "black"; wrapMode: Text.Wrap;  font.pointSize: 10; text:itemLabel.text}
    }

    MouseArea {
        anchors.fill: parent
        onClicked : {
            detailsView.itemId = itemId
            //calendarView.state = "DetailsView"
        }
    }
}
