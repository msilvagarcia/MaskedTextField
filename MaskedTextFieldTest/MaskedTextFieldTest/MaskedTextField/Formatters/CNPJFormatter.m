//
//  CNPJFormatter.m
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CNPJFormatter.h"

@implementation CNPJFormatter

@synthesize mask = _mask;

#pragma mark - Getters
- (NSString *) mask
{
    if (_mask == nil) {
        _mask = @"##.###.###/####-##";
    }
    return _mask;
}

#pragma mark - NSFormatter overwritten methods
- (NSString *) stringForObjectValue:(NSString *)cleanString
{
    unichar *stringCharacters = calloc(self.mask.length, sizeof(unichar));
    
    for (int i = 0; i < self.mask.length; i++) {
        @try {
            unichar maskCharacter = [self.mask characterAtIndex:i];
            unichar stringCharacter = [cleanString characterAtIndex:i];
            if (maskCharacter == '#' && isnumber(stringCharacter)) {
                stringCharacters[i] = stringCharacter;
            } else {
                stringCharacters[i] = maskCharacter;
            }
        }
        @catch (id exception) {
            stringCharacters[i] = [self.mask characterAtIndex:i];
        }
    }
    return [[NSString alloc] initWithCharacters:stringCharacters length:self.mask.length];
}

- (BOOL) getObjectValue:(NSString **)cleanString forString:(NSString *)string errorDescription:(NSString **)error
{
    unichar *stringCharacters = calloc(self.mask.length, sizeof(unichar));
    int jumpedOverCharacters = 0;
    
    for (int i = 0; i < self.mask.length; i++) {
        @try {
            unichar maskCharacter = [self.mask characterAtIndex:i];
            unichar stringCharacter = [string characterAtIndex:i];
            if (maskCharacter == '#' && stringCharacter != '#') {
                stringCharacters[i-jumpedOverCharacters] = stringCharacter;
            } else {
                jumpedOverCharacters++;
            }
        }
        @catch (NSException *exception) {
            stringCharacters[i-jumpedOverCharacters] = '\0';
            break;
        }
    }
    
    for (int i = 0; i < self.mask.length; i++) {
        NSLog(@"Posição %i = %i", i, stringCharacters[i]);
    }
    if (cleanString) {
        *cleanString = [[NSString alloc] initWithCharacters:stringCharacters
                                                     length:sizeof(stringCharacters)/sizeof(unichar)];
    }
    
    return YES;
}

@end
