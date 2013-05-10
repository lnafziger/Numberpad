LNNumberpad v0.9.5
=========

iOS Custom Numberpad

LNNumberpad is a custom numeric keyboard for the iPad which works with both ```UITextField```'s and ```UITextView```'s requiring no changes other than adding an instance of the ```LNNumberpad``` class as the ```inputView``` of the text field/view.

While the example is a numeric keyboard, the class accepts any alpha-numeric character on a key. It may be used as a general-purpose keyboard if the necessary buttons are created, as shown in the LNHexNumberpad example.  

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

Screen Shots
============
![LNNumberpad Screen Shot](/Images/LNNumberpad Example 1.png)

![LNHexNumberpad Screen Shot](/Images/LNNumberpad Example 2.png)

TODO
====

* Make the button appearance more similar to the actual iOS keyboard (button size, background gradients, color, shadows, etc).  Contributions would be greatly appreciated as I have other projects that demand a higher priority than the visual aspects of this one.

Copying
=======

COPYRIGHT 2012-2013 Louis Nafziger

LNNumberpad is free software: you can redistribute it and/or modify
it under the terms of the The MIT License (MIT).

LNNumberpad is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
The MIT License for more details.

You should have received a copy of the The MIT License (MIT)
along with LNNumberpad.  If not, see <http://opensource.org/licenses/MIT>.
