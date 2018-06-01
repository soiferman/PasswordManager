//
//  DetailViewController.m
//  passwordManager
//
//  Created by Max Soiferman on 01.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation DetailViewController

@synthesize accountModel = _accountModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountNameTextField.text = self.accountModel.accountName;
    self.usernameTextField.text = self.accountModel.username;
    self.passwordTextField.text = self.accountModel.password;
    
    self.accountNameTextField.delegate = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    CGSize hideShowSize = [@"SHOWX" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    UIButton *hideShow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, hideShowSize.width, self.passwordTextField.frame.size.height)];
    [hideShow setImage:[UIImage imageNamed:@"iconEyesOpen"] forState:UIControlStateNormal];
    self.passwordTextField.rightView = hideShow;
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    [hideShow addTarget:self action:@selector(hideShow:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)hideShow:(id)sender
{
    UIButton *hideShow = (UIButton *)self.passwordTextField.rightView;
    if (!self.passwordTextField.secureTextEntry)
    {
        self.passwordTextField.secureTextEntry = YES;
        [hideShow setImage:[UIImage imageNamed:@"iconEyesOpen"] forState:UIControlStateNormal];
        
    }
    else
    {
        self.passwordTextField.secureTextEntry = NO;
        [hideShow setImage:[UIImage imageNamed:@"iconEyesClose"] forState:UIControlStateNormal];
    }
    [self.passwordTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)saveAccount:(id)sender {
    
    self.accountModel.accountName = self.accountNameTextField.text;
    self.accountModel.username = self.usernameTextField.text;
    self.accountModel.password = self.passwordTextField.text;
    
    [self.managedObjectContext save:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - UITextFieldDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.accountNameTextField]) {
        [self.usernameTextField becomeFirstResponder];
    }  else if ([textField isEqual:self.usernameTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else if ([textField isEqual:self.passwordTextField]) {
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

@end
