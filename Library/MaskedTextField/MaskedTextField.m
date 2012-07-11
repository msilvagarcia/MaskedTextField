//
//  MaskedTextField.m
//  RPS
//
//  Created by Marcos Garcia on 5/4/12.
//  Copyright (c) 2012 Coderockr. All rights reserved.
//

#import "MaskedTextField.h"

#import <UIKit/UITextInput.h>

@implementation MaskedTextField

@synthesize formatter = _formatter;
@synthesize textFieldShouldReturn;
@synthesize textFieldDelegate = _textFieldDelegate;

#pragma mark - Getters
- (MaskFormatter *) formatter
{
    return _formatter;
}

#pragma mark - Setters
- (void) setFormatter:(MaskFormatter *)formatter
{
    _formatter = formatter;
}

#pragma mark - Constructors
- (MaskedTextField *) initWithFormatter:(MaskFormatter *)formatter
{
    self = [super init];
    self.formatter = formatter;
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate methods
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [[NSMutableString alloc] initWithString:[textField text]];

    if (string != nil) {
        [text replaceCharactersInRange:range withString:string];
    }
    
    [self.formatter updateMaskForText:text];
    
    text = (NSMutableString *)[self.formatter unmaskedStringForMaskedString:text];

    if (text == nil) {
        text = [NSMutableString stringWithString:@""];
    }
    
    if ([textField conformsToProtocol:@protocol(UITextInput)]) {
        [textField setText:[self.formatter maskedStringForUnmaskedString:text]];
        
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSRange lastDigitPosition = [textField.text rangeOfCharacterFromSet:numbers
                                                                    options:NSBackwardsSearch];
        
        UITextPosition *textFieldSelectedTextRange = nil;
        
        UITextPosition *position = textField.beginningOfDocument;
        if (lastDigitPosition.location != NSNotFound) {
            textFieldSelectedTextRange = [textField positionFromPosition:position
                                                                  offset:lastDigitPosition.location + 1];
        } else {
            textFieldSelectedTextRange = [textField positionFromPosition:position
                                                                  offset:0];
        }
        
        [textField setSelectedTextRange:[textField textRangeFromPosition:textFieldSelectedTextRange toPosition:textFieldSelectedTextRange]];
    } else {
        [textField setText:[self.formatter maskedStringWithoutEmptyCharactersForUnmaskedString:text]];
    }
    
    return NO;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    static NSNotificationCenter *notificationCenter;
    if (notificationCenter == nil) {
        notificationCenter = [NSNotificationCenter defaultCenter];
        
        [notificationCenter addObserver:self
                               selector:@selector(textFieldShouldReturnResponse:)
                                   name:@"maskedTextFieldShouldReturnResponse"
                                 object:nil];
    }
    
    [notificationCenter postNotificationName:@"maskedTextFieldShouldReturn"
                                      object:textField];
    
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_textFieldDelegate textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void) textFieldShouldReturnResponse:(NSNotification *)notification
{
    self.textFieldShouldReturn = [(NSNumber *)[notification object] boolValue];
}

#pragma mark - ByPass UITextFieldDelegate Methods
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_textFieldDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_textFieldDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_textFieldDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_textFieldDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL) textFieldShouldClear:(UITextField *)textField
{
    if ([_textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        [_textFieldDelegate textFieldShouldClear:textField];
    }
    
    return YES;
}

@end
