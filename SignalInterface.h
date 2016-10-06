/*
 **	SignalInterface.h
 **	（ここに概要を記載）
 **	VICTORIA Vehicle Information Platform
 **	COPYRIGHT (C) 2016 MITSUBISHI ELECTRIC CORPORATION ALL RIGHTS RESERVED
 **	適用元ファイル--------------------------------------------------------------
 **
 **	更新履歴--------------------------------------------------------------------
 **	Ver. 00.01: 2016.09.19 UserName		: 新規作成
 */

#ifndef SIGNALINTERFACE_H
#define SIGNALINTERFACE_H
// #include "boost/asio.hpp"
//#include "crypto/cryptodev.h"

#include <QObject>
#include <QTimer>
#include "WebSocketClient.h"

class  SignalInterface: public QObject
{
	Q_OBJECT
public:
	explicit SignalInterface(QObject *parent = 0);
	   ~SignalInterface();

	void sendMessageToQML(QString message);
	void startTimer();
	void setWsClient(WebSocketClient* wsCl){ wsClient = wsCl;}
	QString ParseResponse(QString message);
protected:
	QTimer *timer;
	int number;
	WebSocketClient* wsClient;
public slots:
	void update();

	// socket state slots
	void onMessage(QString message);
	void onOpen(QString message);
	void onError(QString message);
	void onClose(QString message);
signals:
	void updateSpeed(QString speed);
	void Send(QString message);
};

#endif // SIGNALINTERFACE_H
