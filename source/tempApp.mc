import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

import Toybox.Complications;


    var myBackgroundColor = 0x000000;
    var myForegroundColor = 0xFFFFFF;

    var view=null;

class tempApp extends Application.AppBase {


    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        view = new tempView();
        return [ new tempView() ] as Array<Views or InputDelegates>;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        myBackgroundColor = Properties.getValue("BackgroundColor");

        WatchUi.requestUpdate();
    }

    function getApp() as tempApp {
        return Application.getApp() as tempApp;
    }


}