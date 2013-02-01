/******************************************************************************
 * v. 0.9    12 NOV 2012
 * Filename  ViewController.m
 * Project:  NumberPad
 * Purpose:  Simple UIViewController subclass to demo the Numberpad class
 * Author:   Louis Nafziger
 *
 * Copyright 2012 Louis Nafziger
 ******************************************************************************
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

#import "ViewController.h"

#import "Numberpad.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize myTextField;
@synthesize myTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.myTextField.inputView  = [Numberpad defaultNumberpad].view;
    self.myTextView.inputView   = [Numberpad defaultNumberpad].view;
}

- (void)viewDidUnload
{
    myTextField = nil;
    myTextView  = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

@end
