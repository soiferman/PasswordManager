//
//  DetailViewController.m
//  passwordManager
//
//  Created by Max Soiferman on 01.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation DetailViewController

@synthesize accountModel = _accountModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountNameTextField.text = self.accountModel.accountName;
    self.usernameTextField.text = self.accountModel.username;
    self.passwordTextField.text = self.accountModel.password;
    
    // hide keyboard when touch outside
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveAccount:(id)sender {
    
    self.accountModel.accountName = self.accountNameTextField.text;
    self.accountModel.username = self.usernameTextField.text;
    self.accountModel.password = self.passwordTextField.text;
    
    [self.managedObjectContext save:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
