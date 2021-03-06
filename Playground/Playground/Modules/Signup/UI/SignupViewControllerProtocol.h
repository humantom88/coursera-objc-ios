//
//  SignupViewControllerProtocol.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SignupViewControllerProtocol <NSObject>

- (void)userCreationLog:(BOOL)isSuccessfullyCreated;

@end

NS_ASSUME_NONNULL_END
