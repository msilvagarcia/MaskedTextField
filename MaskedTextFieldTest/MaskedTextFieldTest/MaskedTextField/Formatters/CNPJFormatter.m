//
//  CNPJFormatter.m
//  MaskedTextFieldTest
//
//  Created by Marcos Garcia on 5/4/12.
//  Copyright (c) 2012 Coderockr. All rights reserved.
//

#import "CNPJFormatter.h"

@implementation CNPJFormatter

@synthesize mask = _mask;

#pragma mark - Getters
- (NSString *) mask
{
    if (_mask == nil) {
        _mask = @"__.___.___/____-__";
    }
    return _mask;
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
