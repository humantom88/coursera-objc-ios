//
//  LoginInteractorProtocol.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoginInteractorProtocol <NSObject>
@property (weak, nonatomic) UIViewController<LoginViewControllerProtocol>* viewController;
@end

NS_ASSUME_NONNULL_END
