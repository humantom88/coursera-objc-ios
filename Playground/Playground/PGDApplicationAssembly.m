//
//  PGDApplicationAssembly.m
//  Playground
//
//  Created by Tom Belov on 16/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "PGDApplicationAssembly.h"
#import "AppDelegate.h"
#import "RootWireframe.h"

@implementation PGDApplicationAssembly

- (AppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:@selector(rootWireframe) with:[self rootWireframe]];
            }];
}

- (RootWireframe *)rootViewController
{
    return [TyphoonDefinition withClass:[RootWireframe class] configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(init:assembly:) parameters:^(TyphoonMethod *initializer)
                 {
                     [initializer injectParameterWith:[self weatherReportController]];
                     [initializer injectParameterWith:self];
                 }];
                definition.scope = TyphoonScopeSingleton;
            }];
}

@end
