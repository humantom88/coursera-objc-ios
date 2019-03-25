//
//  HomeWireframeProtocol.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeWireframeProtocol <NSObject>
- (void) presentHomeViewController;
- (void) dismissHomeViewController;
@end

NS_ASSUME_NONNULL_END
