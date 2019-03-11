//
//  CoreDataEngine.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "CoreDataEngine.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "User+CoreDataClass.h"

@interface CoreDataEngine ()
@property (nonatomic, strong) NSManagedObjectContext* moc;
@end

@implementation CoreDataEngine

+ (CoreDataEngine*) sharedInstance {
    static CoreDataEngine* sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moc = CoreDataManager.sharedInstance.persistentContainer.viewContext;
    }
    return self;
}

- (BOOL) createUser:(UserModel*)userModel {
    User *user = (User *) [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_moc];
    
    [user setValue:userModel.name forKey:@"name"];
    [user setValue:userModel.password forKey:@"password"];
    
    NSError* error;
    
    [_moc save:&error];
    
    if (error) {
        NSLog(@"Error: %@, %@", error, error.userInfo);
        return NO;
    }
    
    return YES;
}

- (BOOL) checkAvailability {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_moc];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    
    NSError *error;
    NSArray* result = [_moc executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error: unable to checkAvailability. %@, %@", error, error.userInfo);
        return NO;
    }
    
    return result != nil && result.count != 0;
}

- (BOOL) login:(UserModel*)userModel {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_moc];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K==%@", @"name", userModel.name];
    fetchRequest.entity = entityDescription;
    
    NSError *error;
    NSArray* result = [_moc executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error: unable to login. %@, %@", error, error.userInfo);
        return NO;
    }
    
    return result != nil && result.count != 0;
}

- (void) deleteUser {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_moc];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    
    NSError *error;
    NSArray* result = [_moc executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error: unable to login. %@, %@", error, error.userInfo);
        return;
    }
    
    if (result.count == 0) {
        NSLog(@"There's no user to logout");
        return;
    }
    
    NSManagedObject* mo = [result firstObject];
    [_moc deleteObject:mo];
    [_moc save:&error];

    if (error) {
        NSLog(@"Error: unable to delete user");
        return;
    }
    
    NSLog(@"User deleted");
    
    return;
}

- (void) saveContext {
    [CoreDataManager.sharedInstance saveContext];
}

@end
