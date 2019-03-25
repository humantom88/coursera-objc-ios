
//
//  DataStore.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "DataStore.h"

@interface DataStore ()
@end

@implementation DataStore

+ (CoreDataEngine *)defaultLocalDB {
    return CoreDataEngine.sharedInstance;
}

@end
