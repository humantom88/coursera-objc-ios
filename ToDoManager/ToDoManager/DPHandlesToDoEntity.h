//
//  DPHandlesToDoEntity.h
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoEntity+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DPHandlesToDoEntity <NSObject>

- (void) receiveToDoEntity:(ToDoEntity *)incomingToDoEntity;

@end

NS_ASSUME_NONNULL_END
