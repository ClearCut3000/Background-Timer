# Background-Timer
Background timer is a start/stop timer that keeps counting even when the app is closed or put into the background. 

After pressing the start button, the countdown starts using the scheduledTimer() function. 
If the user collapses the application without pressing the stop button, the timer, saving the current time value in UserDefaults, after restoring the application will calculate the difference in the time interval, update the label and continue counting.

![Screenshot001](https://github.com/ClearCut3000/Background-Timer/blob/main/Screenshots/scr001.png?raw=true)
![Screenshot002](https://github.com/ClearCut3000/Background-Timer/blob/main/Screenshots/scr002.png?raw=true)
![Screenshot003](https://github.com/ClearCut3000/Background-Timer/blob/main/Screenshots/scr003.png?raw=true)
![Screenshot004](https://github.com/ClearCut3000/Background-Timer/blob/main/Screenshots/scr004.png?raw=true)
