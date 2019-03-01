//
//  MyUIViewController.h
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesMOC.h"
#import "DPHandlesToDoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyUIViewController : UIViewController <DPHandlesMOC, DPHandlesToDoEntity>

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC;
- (void) receiveToDoEntity:(ToDoEntity *)incomingToDoEntity;

@end

NS_ASSUME_NONNULL_END
