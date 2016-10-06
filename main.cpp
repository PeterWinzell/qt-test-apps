#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "SignalInterface.h"
#include <QQmlContext>
#include "WebSocketClient.h"
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

static const char * serverAdress = "192.168.31.111:8080/W3CSocketish/actions";

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	SignalInterface* signalInterface = new SignalInterface();
	QtQuick2ApplicationViewer viewer;


	viewer.rootContext()-> setContextProperty("signalinterface",signalInterface);
	viewer.setMainQmlFile(QStringLiteral("qml/HMITestAppQt/main.qml"));
	viewer.showExpanded();

	// init web socket protocol
	WsClient client(serverAdress);
	WebSocketClient wsClientHandler;

	//Connecting signals and slots
	QObject::connect(&wsClientHandler,&WebSocketClient::onMessage,signalInterface,&SignalInterface::onMessage);
	QObject::connect(&wsClientHandler,&WebSocketClient::onOpen,signalInterface,&SignalInterface::onOpen);
	QObject::connect(&wsClientHandler,&WebSocketClient::onClose,signalInterface,&SignalInterface::onClose);
	QObject::connect(&wsClientHandler,&WebSocketClient::onError,signalInterface,&SignalInterface::onError);

	QObject::connect(signalInterface,&SignalInterface::Send,&wsClientHandler,&WebSocketClient::Send);

	// open up the socket and start communication
	// add reference to WsClient
	wsClientHandler.setWsClient(&client);
	signalInterface -> setWsClient(&wsClientHandler);

	// Start client thread and connect to server
	wsClientHandler.start();



    return app.exec();
}
