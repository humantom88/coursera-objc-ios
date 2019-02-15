//
//  PersonMO+CoreDataProperties.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 15/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "PersonMO+CoreDataProperties.h"

@implementation PersonMO (CoreDataProperties)

+ (NSFetchRequest<PersonMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Person"];
}

@dynamic person_name;
@dynamic chore_log;

@end
