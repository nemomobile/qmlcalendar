// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
/*import QtQuick 1.1
import Qt 4.7
import "month.js" as Month
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import com.nokia.meego 1.0
*/

import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0


PageStackWindow {


    id: mainStack
    showStatusBar: false;

     initialPage: Page {
         id: pageStack;
         tools: commonTools
        CalendarView {
            id: calendarView;
        }

        DayView {
            id: dayView;
            calendarView: calendarView;
            anchors.fill: parent;
            opacity: 0;
        }
        ItemView {
            id: itemView;
            opacity: 0;
            calendarView: calendarView;
        }
        What {
            id: whatItem;
            opacity: 0;
            organizer: calendarView.organizer;
            anchors.fill: parent;
        }
     }
     ToolBarLayout {
         id: commonTools
         visible: true

         ToolIcon {
             id: toolBack
             visible: false
             platformIconId: "toolbar-back";
             onClicked: {  mainStack.pageStack.pop(); toolBack.visible = false;}
             anchors.left: parent.left;
         }

         ToolIcon {
             id: toolDone
             visible: false
             platformIconId: "toolbar-done";
             onClicked: {  whatItem.save(); mainStack.pageStack.pop(); toolDone.visible = false;}
             anchors.left: toolBack.right;
         }

         ToolIcon {
             id: toolDelete
             visible: false
             platformIconId: "toolbar-delete";
             onClicked: {  whatItem.remove();mainStack.pageStack.pop(); toolDelete.visible = false;}
             anchors.left: toolDone.right;
         }

     }





 }
