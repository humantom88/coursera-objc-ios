//
//  DataStore.h
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataStore : NSObject
+ (CoreDataEngine *)defaultLocalDB;
@end

NS_ASSUME_NONNULL_END
