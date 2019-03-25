//
//  SignupInteractorProtocol.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignupViewControllerProtocol.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SignupInteractorProtocol <NSObject>

@property (weak, nonatomic) UIViewController<SignupViewControllerProtocol>* view;
- (void)createUser:(UserModel *)userModel;

@end

NS_ASSUME_NONNULL_END
