//
//  CoreDataManager.h
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
+ (CoreDataManager*) sharedInstance;
- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
