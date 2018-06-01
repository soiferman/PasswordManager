//
//  DetailViewController.h
//  passwordManager
//
//  Created by Max Soiferman on 01.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface DetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *accountNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) AccountModel * accountModel;

- (IBAction)saveAccount:(id)sender;

@end
