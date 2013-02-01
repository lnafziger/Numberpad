/******************************************************************************
 * v. 0.9    12 NOV 2012
 * Filename  AppDelegate.h
 * Project:  LNNumberpad
 * Purpose:  Default Application Delegate
 * Author:   Louis Nafziger
 * 
 * Copyright 2012 Louis Nafziger
 ******************************************************************************
 *
 * This file is part of LNNumberpad.
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

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
