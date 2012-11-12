/******************************************************************************
 * v. 0.9    12 NOV 2012
 * Filename  ViewController.h
 * Project:  NumberPad
 * Purpose:  Simple UIViewController subclass to demo the Numberpad class
 * Author:   Louis Nafziger
 *
 * Copyright 2012 Louis Nafziger
 ******************************************************************************
 *
 * This file is part of NumberPad.
 *
 * NumberPad is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * NumberPad is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU LesserGeneral Public License
 * along with NumberPad.  If not, see <http://www.gnu.org/licenses/>. *
 *
 *****************************************************************************/

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView  *myTextView;

@end
