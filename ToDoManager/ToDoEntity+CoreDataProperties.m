//
//  ToDoEntity+CoreDataProperties.m
//  ToDoManager
//
//  Created by Tom Belov on 22/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "ToDoEntity+CoreDataProperties.h"

@implementation ToDoEntity (CoreDataProperties)

+ (NSFetchRequest<ToDoEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ToDoEntity"];
}

@dynamic toDoTitle;
@dynamic toDoDetails;
@dynamic toDoDueDate;

@end
