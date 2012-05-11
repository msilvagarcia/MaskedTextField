//
//  CNPJFormatter.h
//  MaskedTextFieldTest
//
//  Created by Marcos Garcia on 5/4/12.
//  Copyright (c) 2012 Coderockr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNPJFormatter : NSFormatter

@property (strong, nonatomic, readonly) NSString *mask;

- (NSString *) stringForObjectValue:(NSString *)cleanString;
- (BOOL) getObjectValue:(NSString **)cleanString forString:(NSString *)string errorDescription:(NSString **)error;

@end
