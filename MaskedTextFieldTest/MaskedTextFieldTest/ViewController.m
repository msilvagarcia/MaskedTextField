//
//  ViewController.m
//  MaskedTextFieldTest
//
//  Created by Elton Minetto on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textField = _textField;
@synthesize mask = _mask;

- (UITextField *) textField
{
    return _textField;
}

- (MaskedTextField *) mask
{
    if (_mask == nil) {
        MaskFormatter *cnpjFormatter = [[MaskFormatter alloc] initWithMask:@"__.___.___/____-__"];
        _mask = [[MaskedTextField alloc] initWithFormatter:cnpjFormatter];
    }
    return _mask;
}

- (void) setTextField:(UITextField *)textField
{
    _textField = textField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textField setDelegate:self.mask];
    [self.textField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
