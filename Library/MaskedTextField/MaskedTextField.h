//
//  MaskedTextField.h
//  RPS
//
//  Created by Marcos Garcia on 5/4/12.
//  Copyright (c) 2012 Coderockr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskFormatter.h"

@interface MaskedTextField : NSObject  <UITextFieldDelegate>

@property (strong, nonatomic, readonly) MaskFormatter *formatter;
@property BOOL textFieldShouldReturn;
@property (unsafe_unretained, nonatomic) id <UITextFieldDelegate> textFieldDelegate;

- (MaskedTextField *) initWithFormatter:(NSFormatter *)formatter;

@end
