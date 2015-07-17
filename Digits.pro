TEMPLATE = app

QT += qml quick widgets network
SOURCES += src/main.cpp \
    src/GameLogic.cpp \
    src/AsyncCalc.cpp

HEADERS += \
    src/GameLogic.h \
    src/AsyncCalc.h \
    src/GAnalitics.h

RESOURCES += qml.qrc

QMAKE_CXXFLAGS += -std=gnu++11

DISTFILES += \
    android/AndroidManifest.xml

lupdate_only {
SOURCES = qml/*.qml
}
TRANSLATIONS += digits_ru.ts
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
