//
//  AGMainMenuControllerViewOutput.h
//  ViperTutorial
//
//  Created by Tom Belov on 25/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AGMainMenuControllerViewOutput <NSObject>

@required
- (void)showMenuSectionWithType:(MainMenuSectionType)sectionType fromViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
