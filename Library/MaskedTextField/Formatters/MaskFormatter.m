//
//  MaskFormatter.m
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaskFormatter.h"

@implementation MaskFormatter

@synthesize masks = _masks;
@synthesize mask = _mask;

#pragma mark - Constructors
- (MaskFormatter *) initWithMaskList:(NSArray *)masks
{
    self = [super init];
    if (self) {
        self.masks = masks;
    }
    return self;
}

#pragma mark - Getters
- (NSArray *) masks
{
    if (_masks == nil) {
        @throw ([NSException exceptionWithName:@"UndefinedMaskException"
                                        reason:@"Mask is undefined"
                                      userInfo:nil]);
    }
    return _masks;
}

#pragma mark - Setters
- (void) setMasks:(NSArray *)masks
{
    _masks = masks;
    self.mask = [_masks objectAtIndex:0];
}

- (void) updateMaskForText:(NSString *)text
{
    text = [text stringByReplacingOccurrencesOfString:@"_" withString:@""];
    for (NSString *mask in _masks) {
        if (mask.length >= text.length) {
            self.mask = mask;
            break;
        }
    }
}

#pragma mark - NSFormatter overwritten methods
- (NSString *) stringForObjectValue:(NSString *)cleanString
{
    unichar *stringCharacters = calloc(self.mask.length, sizeof(unichar));
    int jumpedOverCharacters = 0;
    
    for (int i = 0; i < self.mask.length; i++) {
        @try {
            unichar maskCharacter = [self.mask characterAtIndex:i];
            unichar stringCharacter = [cleanString characterAtIndex:i-jumpedOverCharacters];
            if (maskCharacter == '_' && isnumber(stringCharacter)) {
                stringCharacters[i] = stringCharacter;
            } else {
                jumpedOverCharacters++;
                stringCharacters[i] = maskCharacter;
            }
        }
        @catch (id exception) {
            stringCharacters[i] = [self.mask characterAtIndex:i];
        }
    }
    return [[NSString alloc] initWithCharacters:stringCharacters length:self.mask.length];
}

- (BOOL) getObjectValue:(NSString **)cleanString forString:(NSString *)rawString errorDescription:(NSString **)error
{
    NSError *regexError = nil;
    NSRegularExpression *documentRegex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:&regexError];

    if (regexError != nil) {
        *error = regexError.localizedDescription;
        return NO;
    }
    
    *cleanString = [documentRegex stringByReplacingMatchesInString:rawString options:0 range:NSMakeRange(0, rawString.length) withTemplate:@""];

    return YES;
}

#pragma mark - Human readable methods
- (NSString *) unmaskedStringForMaskedString:(NSString *)maskedString
{
    NSString *unmaskedString = nil;
    NSString *error = nil;
    
    [self getObjectValue:&unmaskedString forString:maskedString errorDescription:&error];
    if (error != nil) {
        NSLog(@"Error: %@", error);
    }
    
    return unmaskedString;
}

- (NSString *) maskedStringForUnmaskedString:(NSString *)unmaskedString
{
    return [self stringForObjectValue:unmaskedString];
}

- (NSString *) maskedStringWithoutEmptyCharactersForUnmaskedString:(NSString *)unmaskedString
{
    NSMutableString *maskedString = [NSMutableString stringWithString:[self stringForObjectValue:unmaskedString]];
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange exclusionRange = [maskedString rangeOfCharacterFromSet:numbers
                                                           options:NSBackwardsSearch];
    if (exclusionRange.location == NSNotFound) {
        return @"";
    }
    
    exclusionRange.location++;
    exclusionRange.length = maskedString.length - exclusionRange.location;
  
    [maskedString replaceCharactersInRange:exclusionRange withString:@""];

    return maskedString;
}

@end
