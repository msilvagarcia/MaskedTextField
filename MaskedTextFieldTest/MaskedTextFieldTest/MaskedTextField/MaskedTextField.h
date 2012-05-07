//
//  MaskedTextField.h
//  RPS
//
//  Created by Elton Minetto on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskedTextField : NSObject  <UITextFieldDelegate>

@property (strong, nonatomic, readonly) NSString *mask;
@property (strong, nonatomic, readonly) NSFormatter *formatter;

- (MaskedTextField *) initWithMask:(NSString *)mask;
- (MaskedTextField *) initWithFormatter:(NSFormatter *)formatter;
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
