/******************************************************************************
 * v. 0.9.1  15 NOV 2012
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

#import "Numberpad.h"

#pragma mark - Private methods

@interface Numberpad ()

@property (nonatomic, weak) id<UITextInput> targetTextInput;

@end

#pragma mark - Numberpad Implementation

@implementation Numberpad

@synthesize targetTextInput;

#pragma mark - Shared Numberpad method

+ (Numberpad *)defaultNumberpad {
    static Numberpad *defaultNumberpad = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        defaultNumberpad = [[[NSBundle mainBundle] loadNibNamed:@"Numberpad" owner:self options:nil] objectAtIndex:0];
    });
    
    return defaultNumberpad;
}

#pragma mark - view lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addObservers];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObservers];
    }
    return self;
}

- (void)addObservers {
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

- (void)dealloc {
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
    self.targetTextInput = nil;
}

#pragma mark - editingDidBegin/End

// Editing just began, store a reference to the object that just became the firstResponder
- (void)editingDidBegin:(NSNotification *)notification {
    if (![notification.object conformsToProtocol:@protocol(UITextInput)]) {
        self.targetTextInput = nil;
        return;
    }
    
    self.targetTextInput = notification.object;
}

// Editing just ended.
- (void)editingDidEnd:(NSNotification *)notification {
    self.targetTextInput = nil;
}

#pragma mark - Keypad IBAction's

// A number (0-9) was just pressed on the number pad
// Note that this would work just as well with letters or any other character and is not limited to numbers.
- (IBAction)numberpadNumberPressed:(UIButton *)sender {
    if (!self.targetTextInput) {
        return;
    }
    
    NSString *numberPressed  = sender.titleLabel.text;
    if ([numberPressed length] == 0) {
        return;
    }
    
    UITextRange *selectedTextRange = self.targetTextInput.selectedTextRange;
    if (!selectedTextRange) {
        return;
    }
    
    [self textInput:self.targetTextInput replaceTextAtTextRange:selectedTextRange withString:numberPressed];
}

// The delete button was just pressed on the number pad
- (IBAction)numberpadDeletePressed:(UIButton *)sender {
    if (!self.targetTextInput) {
        return;
    }
    
    UITextRange *selectedTextRange = self.targetTextInput.selectedTextRange;
    if (!selectedTextRange) {
        return;
    }
    
    // Calculate the selected text to delete
    UITextPosition  *startPosition  = [self.targetTextInput positionFromPosition:selectedTextRange.start offset:-1];
    if (!startPosition) {
        return;
    }
    UITextPosition  *endPosition    = selectedTextRange.end;
    if (!endPosition) {
        return;
    }
    UITextRange     *rangeToDelete  = [self.targetTextInput textRangeFromPosition:startPosition
                                                                       toPosition:endPosition];
    
    [self textInput:self.targetTextInput replaceTextAtTextRange:rangeToDelete withString:@""];
}

// The clear button was just pressed on the number pad
- (IBAction)numberpadClearPressed:(UIButton *)sender {
    if (!self.targetTextInput) {
        return;
    }
    
    UITextRange *allTextRange = [self.targetTextInput textRangeFromPosition:self.targetTextInput.beginningOfDocument
                                                                 toPosition:self.targetTextInput.endOfDocument];
    
    [self textInput:self.targetTextInput replaceTextAtTextRange:allTextRange withString:@""];
}

// The done button was just pressed on the number pad
- (IBAction)numberpadDonePressed:(UIButton *)sender {
    if (!self.targetTextInput) {
        return;
    }
    
    // Call the delegate methods and resign the first responder if appropriate
    if ([self.targetTextInput isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)self.targetTextInput;
        if ([textView.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
            if ([textView.delegate textViewShouldEndEditing:textView]) {
                [textView resignFirstResponder];
            }
        }
    } else if ([self.targetTextInput isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)self.targetTextInput;
        if ([textField.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
            if ([textField.delegate textFieldShouldEndEditing:textField]) {
                [textField resignFirstResponder];
            }
        }
    }
}

#pragma mark - text replacement routines

// Check delegate methods to see if we should change the characters in range
- (BOOL)textInput:(id <UITextInput>)textInput shouldChangeCharactersInRange:(NSRange)range withString:(NSString *)string
{
    if (!textInput) {
        return NO;
    }
    
    if ([textInput isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            if (![textField.delegate textField:textField
                 shouldChangeCharactersInRange:range
                             replacementString:string]) {
                return NO;
            }
        }
    } else if ([textInput isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            if (![textView.delegate textView:textView
                     shouldChangeTextInRange:range
                             replacementText:string]) {
                return NO;
            }
        }
    }
    return YES;
}

// Replace the text of the textInput in textRange with string if the delegate approves
- (void)textInput:(id <UITextInput>)textInput replaceTextAtTextRange:(UITextRange *)textRange withString:(NSString *)string {
    if (!textInput) {
        return;
    }
    if (!textRange) {
        return;
    }
    
    // Calculate the NSRange for the textInput text in the UITextRange textRange:
    int startPos                    = [textInput offsetFromPosition:textInput.beginningOfDocument
                                                         toPosition:textRange.start];
    int length                      = [textInput offsetFromPosition:textRange.start
                                                         toPosition:textRange.end];
    NSRange selectedRange           = NSMakeRange(startPos, length);
    
    if ([self textInput:textInput shouldChangeCharactersInRange:selectedRange withString:string]) {
        // Make the replacement:
        [textInput replaceRange:textRange withText:string];
    }
}

@end
