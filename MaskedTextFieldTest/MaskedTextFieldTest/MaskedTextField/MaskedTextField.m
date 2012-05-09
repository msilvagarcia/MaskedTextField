//
//  MaskedTextField.m
//  RPS
//
//  Created by Elton Minetto on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaskedTextField.h"

@implementation MaskedTextField

@synthesize formatter = _formatter;

#pragma mark - Getters
- (NSFormatter *) formatter
{
    return _formatter;
}

#pragma mark - Setters
- (void) setFormatter:(NSFormatter *)formatter
{
    _formatter = formatter;
}

#pragma mark - Constructors
- (MaskedTextField *) initWithFormatter:(NSFormatter *)formatter
{
    self = [super init];
    self.formatter = formatter;
    return self;
}

#pragma mark - UITextFieldDelegate methods
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [[NSMutableString alloc] initWithString:[textField text]];

    if (string != nil) {
        [text replaceCharactersInRange:range
                            withString:string];
    }
    
    [self.formatter getObjectValue:&text
                         forString:text
                  errorDescription:nil];

    if (text == nil) {
        text = [NSMutableString stringWithString:@""];
    }
    
    NSString *newText = [self.formatter stringForObjectValue:text];
    [textField setText:newText];
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange lastDigitPosition = [textField.text rangeOfCharacterFromSet:numbers
                                                                options:NSBackwardsSearch];
    
    UITextPosition *textFieldSelectedTextRange;
    
    if (lastDigitPosition.location != NSNotFound) {
        textFieldSelectedTextRange = [textField positionFromPosition:textField.beginningOfDocument offset:lastDigitPosition.location + 1];
    } else {
        textFieldSelectedTextRange = [textField positionFromPosition:textField.beginningOfDocument offset:0];
    }
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:textFieldSelectedTextRange toPosition:textFieldSelectedTextRange]];
    
    return NO;
}

@end
