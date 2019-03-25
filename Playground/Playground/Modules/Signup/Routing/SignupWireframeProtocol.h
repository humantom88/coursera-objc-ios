//
//  SignupWireframeProtocol.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SignupWireframeProtocol <NSObject>
- (void) dismissSignupViewController;
- (void) presentHomeScreen;
@end

NS_ASSUME_NONNULL_END
