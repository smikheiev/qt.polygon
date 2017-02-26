TEMPLATE = app

QT += qml quick
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += sources/main.cpp \
    sources/polygon.cpp

HEADERS += \
    sources/polygon.h

RESOURCES += resources/_resources.qrc
