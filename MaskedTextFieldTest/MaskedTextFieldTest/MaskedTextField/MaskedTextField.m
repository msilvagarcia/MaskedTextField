//
//  MaskedTextField.m
//  RPS
//
//  Created by Elton Minetto on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaskedTextField.h"

@implementation MaskedTextField

@synthesize mask = _mask;
@synthesize formatter = _formatter;

#pragma mark - Getters
- (NSString *) mask
{
    return _mask;
}

- (NSFormatter *) formatter
{
    return _formatter;
}

#pragma mark - Setters
- (void) setMask:(NSString *)mask
{
    _mask = mask;
}

- (void) setFormatter:(NSFormatter *)formatter
{
    _formatter = formatter;
}

#pragma mark - Constructors
- (MaskedTextField *) initWithMask:(NSString *)mask
{
    self = [super init];
    self.mask = mask;
    self.formatter = [[NSNumberFormatter alloc] init];
    ((NSNumberFormatter *)self.formatter).positiveFormat = self.mask;
    return self;
}

- (MaskedTextField *) initWithFormatter:(NSFormatter *)formatter
{
    self = [super init];
    self.formatter = formatter;
    return self;
}

#pragma mark - UITextFieldDelegate methods
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text;
    [self.formatter getObjectValue:&text forString:[textField text] errorDescription:nil];
    NSLog(@"%@", text);
    if (text == nil) {
        text = @"";
    }
    
    text = [self.formatter stringForObjectValue:[text stringByAppendingString:string]];
    [textField setText:text];
    return NO;
}

@end
