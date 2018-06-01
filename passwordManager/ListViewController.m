//
//  ListViewController.m
//  passwordManager
//
//  Created by Max Soiferman on 01.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import "ListViewController.h"
#import "AccountModel.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "CoreDataStack.h"

@interface ListViewController ()

@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

static NSString *identifier = @"Cell";

@implementation ListViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    NSFetchRequest *fetchRequst = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    self.lists = [self.managedObjectContext executeFetchRequest:fetchRequst error:nil];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

- (NSManagedObjectContext *)managedObjectContext {
    //return [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
    return [[CoreDataStack sharedManager] managedObjectContext];
}

#pragma mark - TableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    AccountModel * model = [self.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = model.accountName;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.managedObjectContext deleteObject:[self.lists objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        
        NSFetchRequest *fetchRequst = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
        self.lists = [self.managedObjectContext executeFetchRequest:fetchRequst error:nil];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.accountModel = [self.lists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}


#pragma mark - Actions

- (IBAction)addAccount:(id)sender {
    
    AccountModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    
    model.accountName = @"New User";
    model.username = @"";
    model.password = @"";
    
    //[self.managedObjectContext save:nil];
    [[CoreDataStack sharedManager] saveContext];
    self.lists = [self.lists arrayByAddingObject:model];
    
    [self.tableView reloadData];
    
}

@end
