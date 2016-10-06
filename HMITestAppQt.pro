# Add more folders to ship with the application, here
folder_01.source = qml/HMITestAppQt
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01


QMAKE_CXXFLAGS += -std=c++0x
#QMAKE_CXXFLAGS += -DBOOST_SYSTEM_NO_DEPRECATED
#QMAKE_CXXFLAGS += -lboost_system -lboost_filesystem

LIBS += -lboost_system
LIBS += -lcrypto -lssl
# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    WebSocketClient.cpp \
    SignalInterface.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    WebSocketClient.h \
    SignalInterface.h \
    Simple-WebSocket-Server/client_ws.hpp \
    Simple-WebSocket-Server/crypto.hpp
