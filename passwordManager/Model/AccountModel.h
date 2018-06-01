//
//  AccountModel.h
//  passwordManager
//
//  Created by Max Soiferman on 01.06.2018.
//  Copyright © 2018 Max Soiferman. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface AccountModel : NSManagedObject

@property (nonatomic, retain) NSString * accountName;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
