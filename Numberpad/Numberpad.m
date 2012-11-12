/******************************************************************************
 * v. 0.9    12 NOV 2012
 * Filename  Numberpad.m
 * Project:  NumberPad
 * Purpose:  Class to display a custom numberpad on an iPad and properly handle
 *           the text input.
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

#import "Numberpad.h"

#pragma mark - Private methods

@interface Numberpad ()

@property (nonatomic, weak) id<UITextInput> target;

@end

#pragma mark - Numberpad Implementation

@implementation Numberpad

@synthesize target;

#pragma mark - Singleton method

+ (Numberpad *)defaultNumberpad
{
    static Numberpad *defaultNumberpad = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        defaultNumberpad = [[Numberpad alloc] init];
    });
    return defaultNumberpad;
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Keep track of the textView/Field that we are editing
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidBegin:) 
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidBegin:) 
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidEnd:) 
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingDidEnd:) 
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UITextFieldTextDidBeginEditingNotification 
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UITextViewTextDidBeginEditingNotification 
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UITextFieldTextDidEndEditingNotification 
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UITextViewTextDidEndEditingNotification 
                                                  object:nil];
    self.target = nil;
    
    [super viewDidUnload];
}

#pragma mark - editingDidBegin/End

// Editing just began, store a reference to the object that just became the firstResponder
- (void)editingDidBegin:(NSNotification *)notification {
    if (![notification.object conformsToProtocol:@protocol(UITextInput)]) {
        self.target = nil;
        return;
    } 
    
    self.target = notification.object;
}

// Editing just ended.
- (void)editingDidEnd:(NSNotification *)notification {
    self.target = nil;
}

#pragma mark - Keypad IBAction's

// A number (0-9) was just pressed on the number pad
- (IBAction)numberpadNumberPressed:(UIButton *)sender {
    if (self.target == nil) {
        return;
    }
    
    NSString *numberPressed  = sender.titleLabel.text;
    if ([numberPressed length] == 0) {
        return;
    }
    
    UITextRange *selectedTextRange = self.target.selectedTextRange;
    if (selectedTextRange == nil) {
        return;
    }
    
    [self replaceTextOfTextInput:self.target inTextRange:selectedTextRange withString:numberPressed];
}

// The delete button was just pressed on the number pad
- (IBAction)numberpadDeletePressed:(UIButton *)sender {
    if (self.target == nil) {
        return;
    }
    
    UITextRange *selectedTextRange = self.target.selectedTextRange;
    if (selectedTextRange == nil) {
        return;
    }
    
    // Calculate the selected text to delete
    UITextPosition  *startPosition  = [self.target positionFromPosition:selectedTextRange.start offset:-1];
    if (startPosition == nil) {
        return;
    }
    UITextPosition  *endPosition    = selectedTextRange.end;
    if (endPosition == nil) {
        return;
    }
    UITextRange     *rangeToDelete  = [self.target textRangeFromPosition:startPosition
                                                              toPosition:endPosition];
    
    [self replaceTextOfTextInput:self.target inTextRange:rangeToDelete withString:@""];
}

// The clear button was just pressed on the number pad
- (IBAction)numberpadClearPressed:(UIButton *)sender {
    if (self.target == nil) {
        return;
    }
    
    UITextRange *allTextRange = [self.target textRangeFromPosition:self.target.beginningOfDocument
                                                        toPosition:self.target.endOfDocument];
    
    [self replaceTextOfTextInput:self.target inTextRange:allTextRange withString:@""];
}

// The done button was just pressed on the number pad
- (IBAction)numberpadDonePressed:(UIButton *)sender {
    if (self.target == nil) {
        return;
    }

    // Call the delegate methods and resign the first responder if appropriate
    if ([self.target isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)self.target;
        if ([textView.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
            if ([textView.delegate textViewShouldEndEditing:textView])
            {
                [textView resignFirstResponder];
            }
        }
    } else if ([self.target isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)self.target;
        if ([textField.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
            if ([textField.delegate textFieldShouldEndEditing:textField])
            {
                [textField resignFirstResponder];
            }
        }
    }
    
}

#pragma mark - replaceText

// Replace the text of the textInput in textRange with string if the delegate approves
- (void)replaceTextOfTextInput:(id <UITextInput>)textInput 
                   inTextRange:(UITextRange *)   textRange 
                    withString:(NSString *)      string {
    if (textInput == nil) {
        return;
    }
    if (textRange == nil) {
        return;
    }
    
    // Calculate the NSRange for the textInput text in the UITextRange textRange:
    int startPos                    = [textInput offsetFromPosition:textInput.beginningOfDocument 
                                                         toPosition:textRange.start];
    int length                      = [textInput offsetFromPosition:textRange.start
                                                         toPosition:textRange.end];
    NSRange selectedRange           = NSMakeRange(startPos, length);
    
    // Check our delegate methods to see if we should change the characters in selectedRange
    if ([textInput isKindOfClass:[UITextField class]]) 
    {
        UITextField *textField = (UITextField *)textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) 
        {
            if (![textField.delegate textField:textField
                 shouldChangeCharactersInRange:selectedRange
                             replacementString:string]) 
            {
                return;
            }
        }
    } else if ([textInput isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) 
        {
            if (![textView.delegate textView:textView 
                     shouldChangeTextInRange:selectedRange 
                             replacementText:string]) 
            {
                return;
            }
        }
    }
    
    // Make the replacement:
    [textInput replaceRange:textRange withText:string];
}

@end
