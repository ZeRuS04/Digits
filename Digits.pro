TEMPLATE = app

QT += qml quick widgets

SOURCES += src/main.cpp \
    src/GameLogic.cpp \
    src/AsyncCalc.cpp

HEADERS += \
    src/GameLogic.h \
    src/AsyncCalc.h

RESOURCES += qml.qrc


DISTFILES += \
    android/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
