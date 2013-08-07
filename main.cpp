#include <QGuiApplication>
#include <QtDebug>

#include <QQuickView>
#include <QQmlEngine>

#include <QOrganizerManager>
#include <QOrganizerAbstractRequest>

#ifdef HAS_BOOSTER
#include <MDeclarativeCache>
#endif

using namespace QtOrganizer;

#ifdef HAS_BOOSTER
Q_DECL_EXPORT
#endif
int main(int argc, char *argv[])
{
#ifdef HAS_BOOSTER
    QScopedPointer<QGuiApplication> app(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QQuickView> view(MDeclarativeCache::qQuickView());
#else
    QScopedPointer<QGuiApplication> app(new QGuiApplication(argc, argv));
    QScopedPointer<QQuickView> view(new QQuickView);
#endif

    qRegisterMetaType<QOrganizerAbstractRequest::State>("QOrganizerAbstractRequest::State");
    qRegisterMetaType<QList<QOrganizerItemId> >("QList<QOrganizerItemId>");
    qRegisterMetaType<QList<QOrganizerCollectionId> >("QList<QOrganizerCollectionId>");
    qRegisterMetaType<QOrganizerAbstractRequest::State>("QOrganizerAbstractRequest::State");
    qRegisterMetaType<QOrganizerItemId>("QOrganizerItemId");
    qRegisterMetaType<QOrganizerCollectionId>("QOrganizerCollectionId");

    view->setSource(QUrl("/opt/qmlcalendar/qml/qmlcalendar/main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->showFullScreen();

    return app->exec();
}
