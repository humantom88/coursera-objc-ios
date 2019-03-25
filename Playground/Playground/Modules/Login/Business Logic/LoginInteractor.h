//
//  LoginInteractor.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginInteractorProtocol.h"
#import "LoginViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginInteractor : NSObject <LoginInteractorProtocol>
@property (weak, nonatomic) UIViewController<LoginViewControllerProtocol>* viewController;
@end

NS_ASSUME_NONNULL_END
