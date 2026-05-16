Step 1: go to settings and search build number. Click on the build number few times and enable developer options.

Step 2 : In developer options find and enable usb debugging.

Step 3: Open your laptop or pc and download Android developer tools from web (this is Google's legit software so no worries)

Step 4: extract the zip that you downloaded and open the sub folder inside the extracted folder then click search and type cmd.

Step 5: Now connect your mobile to pc and click share files and also allow it to usb debug if it asks)

Step 6: type " adb devices" and see if your device shows up. It'll be a string of numbers and alphabets.

Step 7: type the following commands one after other without the "" ofcourse.

" adb shell settings put secure assistant_screen_type 0 "

" adb shell settings put secure assistant_screen_type_left_enable 0 "

To replace Google discover with oneplus shelf use :

adb shell settings put secure assistant_screen_type 1 adb shell settings put secure assistant_screen_type_left_enable 1

Now you can turn off developer options,usb debugging. 

-----------END-----------------------------------

-This does not void any warranty.

As long as you: Don't root your device, Don't unlock the bootloader, and Don't flash unofficial firmware, your warranty remains fully valid.

-google lens and translate and circle to search will all work the same as usual.

-This method removes Google discover and also the left side empty page.

-This will work even after you restart your device. Not yet tested if this works after an update.

-You can also replace it with shelf there is a code for that. I'll drop it down if someone need it.

I did this in oneplus 13s and in Oxygen Os 16. If you are using maybe previous build the package name might vary

For that you can type : " adb shell pm list packages | grep launcher " this will show all the packages and you can find anything similar to what I said in step 7.

Link for Android SDK file:

https://developer.android.com/tools/releases/platform-tools. ( This is official tool by Google for Android customisation)