import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Complications;
import Toybox.ActivityMonitor;

class tempView extends WatchUi.WatchFace {

    var stepId;
    var stepComp;
    var curStep = 0;

    var hasComplications=true;

    var stepDisplay;
    var stepString = 0;     //The number of steps to be displayed

    function initialize() {
        WatchFace.initialize();

        //Check for complications

        stepId=new Id(Complications.COMPLICATION_TYPE_STEPS);
        if(stepId!=null) {
            stepComp = Complications.getComplication(stepId);
            Complications.registerComplicationChangeCallback(self.method(:onComplicationChanged));
                Complications.subscribeToUpdates(stepId);        
        }
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly

        
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;

        myForegroundColor = Properties.getValue("ForegroundColor");

        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Properties.getValue("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }

        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var view = View.findDrawableById("TimeLabel") as Text;
        var stepView = View.findDrawableById("StepLabel") as Text;

        view.setColor(myForegroundColor);
        view.setText(timeString);

        var curStepForm = Lang.format("$1$",[curStep]);

        stepView.setText(curStepForm);


        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }


    function onComplicationChanged(id as Complications.Id) as Void {

        if (id.equals(stepId)) {
            curStep = Complications.getComplication(id).value;
            System.println(curStep);
        } else {
        System.println("Bad input");
        }
    }
}

class tempViewDelegate extends WatchUi.WatchFaceDelegate
{
	var view;
	
	function initialize(v) {
		WatchFaceDelegate.initialize();
		view=v;	
	}

    function onPress(evt) {
        Complications.exitTo(view.stepId);
        return true;
    }
	


}
