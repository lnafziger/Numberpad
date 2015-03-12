/******************************************************************************
 * v. 0.9.5  09 MAY 2013
 * Filename  ViewController.h
 * Project:  LNNumberpad
 * Purpose:  Simple UIViewController subclass to demo the LNNumberpad class
 * Author:   Louis Nafziger
 *
 * Copyright 2012-2013 Louis Nafziger
 ******************************************************************************
 *
 * This file is part of LNNumberpad.
 *
 * COPYRIGHT 2012 - 2013 Louis Nafziger
 *
 * LNNumberpad is free software: you can redistribute it and/or modify
 * it under the terms of the The MIT License (MIT).
 *
 * LNNumberpad is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * The MIT License for more details.
 *
 * You should have received a copy of the The MIT License (MIT)
 * along with LNNumberpad.  If not, see <http://opensource.org/licenses/MIT>.
 *
 *****************************************************************************/

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView  *myTextView;
@property (weak, nonatomic) IBOutlet UITextField *myOtherTextField;

@end
