//
//  SignupInteractor.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupInteractorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignupInteractor : NSObject <SignupInteractorProtocol>

@property (nonatomic, weak) UIViewController<SignupViewControllerProtocol>* view;

@end

NS_ASSUME_NONNULL_END
