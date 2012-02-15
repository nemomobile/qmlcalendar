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

PageStackWindow {



    showStatusBar: false;
    //showToolBar: true;

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
     }
     ToolBarLayout {
         id: commonTools
         visible: true
         ToolIcon {
             platformIconId: "toolbar-view-menu"
             anchors.right: (parent === undefined) ? undefined : parent.right
             onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
         }
         ToolIcon {
             platformIconId: "toolbar-back";
             onClicked: { myMenu.close(); pageStack.pop(); }
             anchors.left: parent.left;
         }
     }

     Menu {
         id: myMenu
         visualParent: pageStack
         MenuLayout {
             MenuItem { text: qsTr("Sample menu item") }
         }
     }
 }
