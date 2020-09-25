QT += quick multimedia quickcontrols2 3dcore 3dquick qml

QT_OPENGL=desktop

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Mp3Player.cpp \
        config.cpp \
        service.cpp

RESOURCES += qml.qrc\
 qtquickcontrols2.conf

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    MP3Player.pro.user \
    Pictures/list.png \
    Pictures/media-next.png \
    Pictures/media-previous.png \
    Pictures/media-repeat-alt.png \
    Pictures/media-repeat.png \
    Pictures/media-volume-1.png \
    Pictures/media-volume-2.png \
    Pictures/media-volume-3.png \
    Pictures/pause.png \
    Pictures/play-button.png \
    qtquickcontrols2.conf

HEADERS += \
    config.h \
    service.h
