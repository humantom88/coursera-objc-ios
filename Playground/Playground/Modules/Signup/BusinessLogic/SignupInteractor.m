//
//  SignupInteractor.m
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "SignupInteractor.h"
#import "DataStore.h"

@implementation SignupInteractor

- (void)createUser:(nonnull UserModel *)userModel {
    [self.view userCreationLog:[DataStore.defaultLocalDB createUser:userModel]];
}

@end
