#include <QCoreApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "GameLogic.h"

QCoreApplication *coreApp;

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QTranslator myTranslator;
    myTranslator.load(":/digits_" + QLocale::system().name());
    app.installTranslator(&myTranslator);
    QApplication::setOrganizationName(ORG_NAME);
    QApplication::setOrganizationDomain(ORG_DOMAIN);
    QApplication::setApplicationName(APP_NAME);
    QApplication::setApplicationVersion(G_VERSION("9"));
    coreApp = &app;
    QQmlApplicationEngine engine;
    qmlRegisterType<GameLogic>("GameLogic", 1, 0, "GameLogic");
    engine.load(QUrl(QStringLiteral("qrc:///qml/main.qml")));

    return app.exec();
}
