import QtQuick 2.0

import "../_Parts"
import "../_Parts/Base"

LayoutBase {

    width: 800
    height: 480

    focus: true

    BackGround {
        id: backGround
        objectName: "BackGround"
    }

    ButtonBase {
        id: coreServiceAccessButton
        objectName: "CoreServiceAccessButton"
        x: 650
        y: 40
        caption: "Core"
        onReleased: {
            console.log("--- fCore::getCurrentTime() Call Start ---");

            currentTime.caption = _fCore.getCurrentTime();

            console.log("--- fCore::getCurrentTime() Call End   ---");
        }
    }

    ButtonBase {
        id: nonCoreServiceAccessButton
        objectName: "NonCoreServiceAccessButton"
        x: 650
        y: 213
        caption: "NonCore"
        onReleased: {
            console.log("--- fNonCore::getCount() Call Start ---");

            counter.caption = _fNonCore.getCount();

            console.log("--- fNonCore::getCount() Call End   ---");
        }
    }

    ButtonBase {
        id: toState1_Button
        objectName: "ToState1_Button"
        x: 692
        y: 432
        caption: "Next"
        onReleased: {
            builtin.produceInternalEvent("toState1");
        }
    }

    TextBase {
        id: currentTimeLabel
        objectName: "CurrentTimeLabel"
        x: 50
        y: 40
        width: 300
        height: 40
        caption: "CacheCurrentTime"
    }

    TextBase {
        id: currentTimeColonLabel
        objectName: "CurrentTimeColonLabel"
        x: 350
        y: 40
        width: 50
        height: 40
        caption: "："
    }

    TextBase {
        id: currentTime
        objectName: "CurrentTime"
        x: 400
        y: 40
        width: 200
        height: 40
        caption: "--:--:--"
    }

    TextBase {
        id: notifyCurrentTimeLabel
        objectName: "NotifyCurrentTimeLabel"
        x: 50
        y: 100
        width: 300
        height: 40
        caption: "NotifyCurrentTime"
    }

    TextBase {
        id: notifyCurrentTimeColonLabel
        objectName: "NotifyCurrentTimeColonLabel"
        x: 350
        y: 100
        width: 50
        height: 40
        caption: "："
    }

    TextBase {
        id: notifyCurrentTime
        objectName: "NotifyCurrentTime"
        x: 400
        y: 100
        width: 200
        height: 40
        caption: "--:--:--"
    }

    TextBase {
        id: notifyCycleFromCore
        objectName: "NotifyCycleFromCore"
        x: 650
        y: 100
        width: 100
        height: 40
        caption: "---"
    }

    TextBase {
        id: counter
        objectName: "Counter"
        x: 500
        y: 213
        width: 100
        height: 40
        caption: "---"
    }

    TextBase {
        id: notifyCycleFromNonCore
        objectName: "NotifyCycleFromNonCore"
        x: 650
        y: 273
        width: 100
        height: 40
        caption: "---"
    }

    //*************************************************************************
    // Core Service イベントハンドラ
    //*************************************************************************

    /**
     * notifyCurrentTime イベントハンドラ
     */
    function _Core__notifyCurrentTime(argument) {
        console.log("EventName : _Core__notifyCurrentTime, Argument : " + argument);
        notifyCurrentTime.caption = argument;
    }

    /**
     * notifyCurrentTime イベントハンドラ
     */
    function _Core__notifyCycle(argument) {
        console.log("EventName : _Core__notifyCycle, Argument : " + argument);
        notifyCycleFromCore.caption = argument;
    }

    //*************************************************************************
    // NonCore Service イベントハンドラ
    //*************************************************************************

    /**
     * notifyCurrentTime イベントハンドラ
     */
    function _NonCore__notifyCycle(argument) {
        console.log("EventName : _NonCore__notifyCycle, Argument : " + argument);
        notifyCycleFromNonCore.caption = argument;
    }
}
