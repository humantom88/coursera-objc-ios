//
//  HomeViewController.h
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeWireframe.h"
#import "HomeViewControllerProtocol.h"
#import "HomeInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <HomeViewControllerProtocol>

@property (strong, nonatomic) HomeInteractor *interactor;
@property (strong, nonatomic) HomeWireframe *navigation;

@end

NS_ASSUME_NONNULL_END
