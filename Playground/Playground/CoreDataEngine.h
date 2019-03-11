//
//  CoreDataEngine.h
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataEngine : NSObject
- (BOOL) createUser:(UserModel*)userModel;
- (BOOL) checkAvailability;
- (BOOL) login:(UserModel*)userModel;
- (void) deleteUser;
- (void) saveContext;
+ (CoreDataEngine*) sharedInstance;
@end

NS_ASSUME_NONNULL_END
