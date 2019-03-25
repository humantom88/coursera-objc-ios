//
//  User+CoreDataProperties.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"User"];
}

@dynamic name;
@dynamic password;

@end
