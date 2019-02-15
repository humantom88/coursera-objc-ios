//
//  AppDelegate.h
//  CoreDataCoursera
//
//  Created by Tom Belov on 15/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ChoreMO+CoreDataClass.h"
#import "ChoreLogMO+CoreDataClass.h"
#import "PersonMO+CoreDataClass.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (ChoreMO *) createChoreMO;
- (ChoreLogMO *) createChoreLogMO;
- (PersonMO *) createPersonMO;

@end

