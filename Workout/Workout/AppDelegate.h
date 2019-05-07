//
//  AppDelegate.h
//  Workout
//
//  Created by Tom Belov on 07/05/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Exercise+CoreDataClass.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (Exercise *)createExercise;
- (void)saveContext;


@end

