/*
 **	SignalInterface.cpp
 **	（ここに概要を記載）
 **	VICTORIA Vehicle Information Platform
 **	COPYRIGHT (C) 2016 MITSUBISHI ELECTRIC CORPORATION ALL RIGHTS RESERVED
 **	適用元ファイル--------------------------------------------------------------
 **
 **	更新履歴--------------------------------------------------------------------
 **	Ver. 00.01: 2016.09.19 UserName		: 新規作成
 */

#include "SignalInterface.h"

#include <QMetaObject>
#include <QVariant>
#include <QDebug>
#include <QTimer>
#include <QtQml>
#include <QtMath>
#include <QJsonValue>


SignalInterface::SignalInterface (QObject *parent) : QObject(parent),number(0),wsClient(0)
{
}

SignalInterface::~SignalInterface()
{
	/*if (timer != 0){
		if (timer ->isActive())
			timer ->stop();
	}
	delete timer;*/
}

void SignalInterface::startTimer()
{

	//timer = new QTimer(this);
	//connect(timer, SIGNAL(timeout()), this, SLOT(update()));

	// timer->start(200);

}



//slot connected to timer
void SignalInterface::update(){
}

QString SignalInterface::ParseResponse(QString message){

	QJsonDocument jsonDocument;
	QJsonDocument document = jsonDocument.fromJson(message.toUtf8());
	QJsonObject jSonObject = document.object();

	QJsonValue jsonValue = jSonObject.value("value");
	int val = jsonValue.toInt();

	return QString::number(val);
}

void SignalInterface::onMessage(QString message){
	qDebug() << "message sent via emit from WebSocket Client " << message;
	sendMessageToQML(ParseResponse(message));
}

void SignalInterface::onOpen(QString message){
	qDebug() << " socket is open " << message;

	// Subscribe to
	emit Send("{\"action\":\"subscribe\",\"type\":\"change\",\"path\":\"Vehicle.speed\"}");
}

void SignalInterface::onClose(QString message){
	qDebug() << " socket is closed " << message;
}

void SignalInterface::onError(QString message){
	qDebug() << " error in socket handling" << message;
}

void SignalInterface::sendMessageToQML(QString message){
	emit updateSpeed(message);
}


