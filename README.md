Numberpad
=========

iOS Custom Numberpad v0.9.0

Numberpad is a custom numeric keyboard for the iPad which works with both ```UITextField```'s and ```UITextView```'s requiring no changes other than adding an instance of the ```Numberpad``` class as the ```inputView``` of the text field/view.

This is the first public release, and while I have used it extensively in several projects that are currently in use, please let me know if you have any problems or would like to contribute to this project.

Thank you.
 
Usage
=====

Include the following three files from the Numberpad directory in your project:
* Numberpad.h
* Numberpad.m
* Numberpad.xib

In the class where you want to use the numberpad, include the Numberpad.h file.

You must have a reference to the text field/view that you want to use the numberpad with, and then you simply assign the ```Numberpad``` singleton to the view's ```inputView```:

``` objective-c
self.myTextField.inputView  = [Numberpad defaultNumberpad].view;
```

A complete example project is included in the Example directory.

COPYING
=======

COPYRIGHT 2012 Louis Nafziger

NumberPad is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

NumberPad is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU LesserGeneral Public License
along with NumberPad.  If not, see <http://www.gnu.org/licenses/>.
