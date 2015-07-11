#include <QCoreApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "GameLogic.h"


QCoreApplication *coreApp;

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setOrganizationName(ORG_NAME);
    QApplication::setOrganizationDomain(ORG_DOMAIN);
    QApplication::setApplicationName(APP_NAME);
    QApplication::setApplicationVersion(G_VERSION("7"));
    coreApp = &app;
    QQmlApplicationEngine engine;
    qmlRegisterType<GameLogic>("GameLogic", 1, 0, "GameLogic");
    engine.load(QUrl(QStringLiteral("qrc:///qml/main.qml")));

    return app.exec();
}
