//
//  MaskFormatter.m
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaskFormatter.h"

@implementation MaskFormatter

@synthesize mask = _mask;

#pragma mark - Constructors
- (MaskFormatter *) initWithMask:(NSString *)mask
{
    self = [super init];
    self.mask = mask;
    return self;
}

#pragma mark - Getters
- (NSString *) mask
{
    if (_mask == nil) {
        @throw ([NSException exceptionWithName:@"UndefinedMaskException"
                                        reason:@"Mask is undefined"
                                      userInfo:nil]);
    }
    return _mask;
}

#pragma mark - Setters
- (void) setMask:(NSString *) mask
{
    _mask = mask;
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
    if (cleanString) {
        *cleanString = [rawString stringByReplacingOccurrencesOfString:@"_"
                                                            withString:@""];
        *cleanString = [*cleanString stringByReplacingOccurrencesOfString:@"."
                                                               withString:@""];
        *cleanString = [*cleanString stringByReplacingOccurrencesOfString:@"/"
                                                               withString:@""];
        *cleanString = [*cleanString stringByReplacingOccurrencesOfString:@"-"
                                                               withString:@""];
    }
    
    return YES;
}

@end
