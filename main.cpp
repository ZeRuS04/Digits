#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "GameLogic.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setOrganizationName("EugeneSinel");
    QApplication::setOrganizationDomain("EugeneSinel.com");
    QApplication::setApplicationName("Digits");
    QQmlApplicationEngine engine;
    qmlRegisterType<GameLogic>("GameLogic", 1, 0, "GameLogic");
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
