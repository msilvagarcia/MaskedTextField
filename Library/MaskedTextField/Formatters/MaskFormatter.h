//
//  MaskFormatter.h
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskFormatter : NSFormatter

@property (strong, nonatomic, readonly) NSString *mask;

- (MaskFormatter *) initWithMask:(NSString *)mask;
- (NSString *) stringForObjectValue:(NSString *)cleanString;
- (BOOL) getObjectValue:(NSString **)cleanString forString:(NSString *)string errorDescription:(NSString **)error;

@end
