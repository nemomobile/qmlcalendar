#include <QGuiApplication>
#include <QtDebug>

#include <QQuickView>
#include <QQmlEngine>

#include <QOrganizerManager>
#include <QOrganizerAbstractRequest>

using namespace QtOrganizer;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;

    qRegisterMetaType<QOrganizerAbstractRequest::State>("QOrganizerAbstractRequest::State");
    qRegisterMetaType<QList<QOrganizerItemId> >("QList<QOrganizerItemId>");
    qRegisterMetaType<QList<QOrganizerCollectionId> >("QList<QOrganizerCollectionId>");
    qRegisterMetaType<QOrganizerAbstractRequest::State>("QOrganizerAbstractRequest::State");
    qRegisterMetaType<QOrganizerItemId>("QOrganizerItemId");
    qRegisterMetaType<QOrganizerCollectionId>("QOrganizerCollectionId");

    view.setSource(QUrl("/opt/qmlcalendar/qml/qmlcalendar/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.showFullScreen();

    return app.exec();
}
