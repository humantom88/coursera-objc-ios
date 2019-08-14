//
//  ToDoEntity+CoreDataProperties.h
//  ToDoManager
//
//  Created by Tom Belov on 22/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "ToDoEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

+ (NSFetchRequest<ToDoEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *toDoTitle;
@property (nullable, nonatomic, copy) NSString *toDoDetails;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;

@end

NS_ASSUME_NONNULL_END
