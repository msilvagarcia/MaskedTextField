//
//  MaskFormatter.h
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskFormatter : NSFormatter

@property (strong, nonatomic) NSArray *masks;
@property (strong, nonatomic) NSString *mask;

- (MaskFormatter *) initWithMaskList:(NSArray *)masks;
- (NSString *) stringForObjectValue:(NSString *)cleanString;
- (BOOL) getObjectValue:(NSString **)cleanString forString:(NSString *)string errorDescription:(NSString **)error;

- (void) updateMaskForText:(NSString *)text;

#pragma mark - Human readable methods
- (NSString *) unmaskedStringForMaskedString:(NSString *)maskedString;
- (NSString *) maskedStringForUnmaskedString:(NSString *)unmaskedString;
- (NSString *) maskedStringWithoutEmptyCharactersForUnmaskedString:(NSString *)unmaskedString;

@end
