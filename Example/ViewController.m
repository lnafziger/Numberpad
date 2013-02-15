/******************************************************************************
 * v. 0.9    12 NOV 2012
 * Filename  ViewController.m
 * Project:  LNNumberpad
 * Purpose:  Simple UIViewController subclass to demo the LNNumberpad class
 * Author:   Louis Nafziger
 *
 * Copyright 2012 Louis Nafziger
 ******************************************************************************
 *
 * COPYRIGHT 2013 Louis Nafziger
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

#import "ViewController.h"

#import "LNNumberpad.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize myTextField;
@synthesize myTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
     * An example loading a custom xib.  
     * Normally you should not need to do this, but instead would either modify LNNumberpad.xib or 
     * change the default xib in the defaultLNNumberpad class method to your own xib.  
     * This however, is for demonstration purposes.
     */
    self.myTextField.inputView  = [[[NSBundle mainBundle] loadNibNamed:@"LNHexNumberpad" owner:self options:nil] objectAtIndex:0];
    
    // The "normal" numberpad
    self.myTextView.inputView   = [LNNumberpad defaultLNNumberpad];
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
