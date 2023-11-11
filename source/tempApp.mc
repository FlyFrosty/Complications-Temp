import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Complications;
import Toybox.System;


    var mComplication = Complications.getComplication(
        new Complications.Id(Complications.COMPLICATION_TYPE_STEPS));
    var myBackgroundColor = 0x000000;
    var myForegroundColor = 0xFFFFFF;

class tempApp extends Application.AppBase {


    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {

        // Liking and subscribing
        Complications.subscribeToUpdates(mComplication);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
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

    function onPress(clickEvent as ClickEvent) as Boolean {

        // returns the complicationId within the boundingBoxes

        if (mComplication != null) {
            System.println( "We found a complication! let's launch it ..." );
            Complications.exitTo(mComplication);
            return(true);
        } else {
            System.println( "No complication found" );
            return(false);
        }
    }
}