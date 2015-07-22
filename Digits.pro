TEMPLATE = app



android {
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

QT += androidextras

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/project.properties \
    android/src/org/qtproject/example/admobqt/AdMobQtActivity.java \

DISTFILES += \
    android/AndroidManifest.xml \
    android/src/org/qtproject/example/admobqt/AdMobQtActivity.java \
    android/project.properties
}

QT += qml quick widgets  network

SOURCES += src/main.cpp \
    src/GameLogic.cpp \
    src/AsyncCalc.cpp

HEADERS += \
    src/GameLogic.h \
    src/AsyncCalc.h \
    src/GAnalitics.h

RESOURCES += qml.qrc

QMAKE_CXXFLAGS += -std=gnu++11



lupdate_only {
SOURCES = qml/*.qml
}

TRANSLATIONS += digits_ru.ts
