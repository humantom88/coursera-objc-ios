//
//  PGDApplicationAssembly.h
//  Playground
//
//  Created by Tom Belov on 16/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@class AppDelegate;
@class RootWireframe;

NS_ASSUME_NONNULL_BEGIN

@interface PGDApplicationAssembly : NSObject

- (AppDelegate *)appDelegate;

- (RootWireframe *)rootWireframe;


@end

NS_ASSUME_NONNULL_END
