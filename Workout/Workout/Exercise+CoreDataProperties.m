//
//  Exercise+CoreDataProperties.m
//  Workout
//
//  Created by Tom Belov on 07/05/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "Exercise+CoreDataProperties.h"

@implementation Exercise (CoreDataProperties)

+ (NSFetchRequest<Exercise *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
}

@dynamic name;
@dynamic times;
@dynamic repeats;
@dynamic weight;
@dynamic when;

@end
