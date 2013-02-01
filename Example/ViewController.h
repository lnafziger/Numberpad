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
 * COPYRIGHT 2013 Louis Nafziger
 *
 * NumberPad is free software: you can redistribute it and/or modify
 * it under the terms of the The MIT License (MIT).
 *
 * NumberPad is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * The MIT License for more details.
 *
 * You should have received a copy of the The MIT License (MIT)
 * along with NumberPad.  If not, see <http://opensource.org/licenses/MIT>.
 *
 *****************************************************************************/

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView  *myTextView;

@end
