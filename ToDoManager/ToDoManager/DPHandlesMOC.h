//
//  DPHandlesMOC.h
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DPHandlesMOC <NSObject>

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end

NS_ASSUME_NONNULL_END
