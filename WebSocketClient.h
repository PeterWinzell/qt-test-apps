/*
 **	WebSocketClient.h
 **	（ここに概要を記載）
 **	VICTORIA Vehicle Information Platform
 **	COPYRIGHT (C) 2016 MITSUBISHI ELECTRIC CORPORATION ALL RIGHTS RESERVED
 **	適用元ファイル--------------------------------------------------------------
 **
 **	更新履歴--------------------------------------------------------------------
 **	Ver. 00.01: 2016.09.20 UserName		: 新規作成
 */

#ifndef WEBSOCKETCLIENT_H
#define WEBSOCKETCLIENT_H


// #include "boost/asio.hpp"
#include "Simple-WebSocket-Server/client_ws.hpp"
#include <QObject>
#include <QThread>

using namespace std;

typedef SimpleWeb::SocketClient<SimpleWeb::WS> WsClient;

enum class socketstate{
	ONOPEN,
	ONMESSAGE,
	ONCLOSE,
	ONERROR
};


class WebSocketClient: public QThread
{
 Q_OBJECT
public:

	WebSocketClient();

	void setWsClient(WsClient* client){
		zeClient = client;
	}

	void initSockets(WsClient* client){


			// Set reference to socket client
			client ->setQtSocketClient( this );

			client->onmessage=[](shared_ptr<WsClient::Message> message) {
				auto message_str=message->string();

				cout << "Client: Message received: \"" << message_str << "\"" << endl;
				// Message holds a reference to WebSocketClient
				WebSocketClient* cl = message -> getQtCl_2();
				cl->emitMessage(socketstate::ONMESSAGE,message_str);

			};

			client->onopen=[&client]() {
				cout << "Client: Opened connection" << endl;
				client->getQtSocketClient()-> emitMessage(socketstate::ONOPEN," connection is open ");
			};

			client->onclose=[](int status, const std::string& /*reason*/) {
				cout << "Client: Closed connection with status code " << status << endl;
			};

			//See http://www.boost.org/doc/libs/1_55_0/doc/html/boost_asio/reference.html, Error Codes for error code meanings
			client->onerror=[](const boost::system::error_code& ec) {
				cout << "Client: Error: " << ec << ", error message: " << ec.message() << endl;
			};

			client->start();


	}



	void Send_2(QString mess,WsClient* client){
		if (client != 0){
			std::string message(mess.toStdString().c_str());
			auto send_stream=make_shared<WsClient::SendStream>();

			*send_stream << message;
			client->send(send_stream);

			cout << message << " sent " << endl;
		}
	}

public slots:
	void Send(QString message){ Send_2(message,zeClient);}
signals:
	void onOpen(QString message);
	void onMessage(QString message);
	void onClose(QString message);
	void onError(QString message);

protected:

	// socket state message handler
	void emitMessage(socketstate state,std::string s){

		QString mess =  QString::fromStdString(s);

		switch(state){
			case socketstate::ONCLOSE:
			emit onClose(mess);
			break;
		case socketstate::ONERROR:
			emit onError(mess);
			break;
		case socketstate::ONMESSAGE:
			emit onMessage(mess);
			break;
		case socketstate::ONOPEN:
			emit onOpen(mess);
			break;
		}

	}

private:

	// WsClient implements web socket prootocol
	WsClient* zeClient;

	// start socket connection thread
	void run(){
		initSockets(zeClient);
	}

};

#endif // WEBSOCKETCLIENT_H
