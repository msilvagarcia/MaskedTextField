//
//  ViewController.h
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaskedTextField.h"
#import "CNPJFormatter.h"

@interface ViewController : UIViewController

@property (strong, nonatomic, readonly) IBOutlet UITextField *textField;
@property (strong, nonatomic, readonly) MaskedTextField *mask;

@end
