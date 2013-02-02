LNNumberpad v0.9.4
=========

iOS Custom Numberpad

LNNumberpad is a custom numeric keyboard for the iPad which works with both ```UITextField```'s and ```UITextView```'s requiring no changes other than adding an instance of the ```LNNumberpad``` class as the ```inputView``` of the text field/view.

I have used it extensively in several projects that are currently in use, but please let me know if you have any problems or would like to contribute to this project.

Thank you.
 
Usage
=====

Include the following three files from the LNNumberpad directory in your project:
* LNNumberpad.h
* LNNumberpad.m
* LNNumberpad.xib

In the class where you want to use the LNNumberpad, include the LNNumberpad.h file.

You must have a reference to the text field/view that you want to use the LNNumberpad with, and then you simply assign the ```LNNumberpad``` singleton to the view's ```inputView```.  (Note that the following example has changed as of v0.9.3 so that ".view" is no longer allowed/required.):

``` objective-c
self.myTextField.inputView  = [LNNumberpad defaultLNNumberpad];
```

A complete example project is included in the Example directory.

Screen Shot
===========
![LNNumberpad Screen Shot](/Images/LNNumberpad Example 1.png)


Copying
=======

COPYRIGHT 2013 Louis Nafziger

LNNumberpad is free software: you can redistribute it and/or modify
it under the terms of the The MIT License (MIT).

LNNumberpad is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
The MIT License for more details.

You should have received a copy of the The MIT License (MIT)
along with LNNumberpad.  If not, see <http://opensource.org/licenses/MIT>.
