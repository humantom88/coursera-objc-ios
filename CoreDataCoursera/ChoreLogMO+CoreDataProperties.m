//
//  ChoreLogMO+CoreDataProperties.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 12.02.2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "ChoreLogMO+CoreDataProperties.h"

@implementation ChoreLogMO (CoreDataProperties)

+ (NSFetchRequest<ChoreLogMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
}

@dynamic when;
@dynamic chore_done;
@dynamic person_who_did_it;

@end
