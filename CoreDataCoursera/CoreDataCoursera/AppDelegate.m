//
//  AppDelegate.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 11/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "AppDelegate.h"
#import "ChoreMO+CoreDataClass.h"
#import "PersonMO+CoreDataClass.h"
#import "ChoreLogMO+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.persistentContainer managedObjectModel];
    [self.persistentContainer viewContext];
    
    return YES;
}

#pragma mark - My Managed Object Code

- (ChoreMO *) createChoreMO {
    NSManagedObjectContext *moc = [self.persistentContainer viewContext];
    ChoreMO *choreMO = [NSEntityDescription insertNewObjectForEntityForName:@"Chore" inManagedObjectContext:moc];
    return choreMO;
};

- (PersonMO *) createPersonMO {
    NSManagedObjectContext *moc = [self.persistentContainer viewContext];
    PersonMO *personMO = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc];
    return personMO;
};

- (ChoreLogMO *) createChoreLogMO {
    NSManagedObjectContext *moc = [self.persistentContainer viewContext];
    ChoreLogMO *choreLogMO = [NSEntityDescription insertNewObjectForEntityForName:@"ChoreLog" inManagedObjectContext:moc];
    return choreLogMO;
};

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataCoursera"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
