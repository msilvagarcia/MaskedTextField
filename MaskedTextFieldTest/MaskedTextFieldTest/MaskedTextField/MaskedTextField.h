//
//  MaskedTextField.h
//  RPS
//
//  Created by Marcos Garcia on 5/4/12.
//  Copyright (c) 2012 Coderockr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaskedTextField : NSObject  <UITextFieldDelegate>

@property (strong, nonatomic, readonly) NSFormatter *formatter;

- (MaskedTextField *) initWithFormatter:(NSFormatter *)formatter;
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
