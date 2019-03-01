//
//  Router.m
//  ViperTutorial
//
//  Created by Tom Belov on 25/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "Router.h"
#import "Typhoon/Typhoon.h"

@implementation Router

- (void)showCityFromViewController:(UIViewController *)viewController {
    UIStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Quarters" factory:AGAppDelegateMacros.storyboardFactory bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"agquarterslistviewcontroller"];
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)showPlacesFromViewController:(UIViewController *)viewController {
    UIStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Places" factory:AGAppDelegateMacros.storyboardFactory bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"agplacescategorieslist"];
    [viewController.navigationController pushViewController:vc animated:YES];
}

- (void)showReferenceBookFromViewController:(UIViewController *)viewController {
    UIStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"ReferenceBook" factory:AGAppDelegateMacros.storyboardFactory bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"agreferencebookcategoriesviewcontroller"];
    [viewController.navigationController pushViewController:vc animated:YES];
}

@end
