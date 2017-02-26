#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "polygon.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Polygon>("SMExtensions", 1, 0, "Polygon");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
