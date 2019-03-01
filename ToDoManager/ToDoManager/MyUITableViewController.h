//
//  MyUITableViewController.h
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesMOC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyUITableViewController : UITableViewController <DPHandlesMOC>

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end

NS_ASSUME_NONNULL_END
