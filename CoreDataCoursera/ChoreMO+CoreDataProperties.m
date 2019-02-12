//
//  ChoreMO+CoreDataProperties.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 11/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "ChoreMO+CoreDataProperties.h"

@implementation ChoreMO (CoreDataProperties)

+ (NSFetchRequest<ChoreMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
}

@dynamic chore_name;
@dynamic chore_log;

@end
