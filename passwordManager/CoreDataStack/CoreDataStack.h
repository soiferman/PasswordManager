//
//  CoreDataStack.h
//  passwordManager
//
//  Created by Stanly Shiyanovskiy on 01.06.18.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AccountModel.h"

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (void) saveContext;
- (NSURL*)applicationDocumentsDirectory;

+ (CoreDataStack*)sharedManager;

@end
