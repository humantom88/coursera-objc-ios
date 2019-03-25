//
//  HomeInteractor.m
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "HomeInteractor.h"
#import "DataStore.h"

@implementation HomeInteractor

- (void)deleteUser {
    [DataStore.defaultLocalDB deleteUser];
}

@end
