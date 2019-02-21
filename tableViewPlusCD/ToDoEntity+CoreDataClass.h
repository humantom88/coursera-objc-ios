//
//  ToDoEntity+CoreDataClass.h
//  tableViewPlusCD
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity : NSManagedObject

- (void) setTitle:(ToDoEntity *)incoming;

@end

NS_ASSUME_NONNULL_END

#import "ToDoEntity+CoreDataProperties.h"
