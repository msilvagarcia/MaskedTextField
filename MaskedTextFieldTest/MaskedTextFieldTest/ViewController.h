//
//  ViewController.h
//  MaskedTextFieldTest
//
//  Created by Marcos Garcia on 5/4/12.
//  Copyright (c) 2012 Coderockr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaskedTextField.h"
#import "MaskFormatter.h"

@interface ViewController : UIViewController

@property (strong, nonatomic, readonly) IBOutlet UITextField *textField;
@property (strong, nonatomic, readonly) MaskedTextField *mask;

@end
