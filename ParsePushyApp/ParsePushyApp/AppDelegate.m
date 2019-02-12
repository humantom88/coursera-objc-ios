//
//  AppDelegate.m
//  ParsePushyApp
//
//  Created by Tom Belov on 11/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// !!! THIS EXAMPLE DOESNT WORK ON SIMULATOR, ONLY ON REAL DEVICE !!!

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *remoteNotification = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (remoteNotification) {
        NSString *remoteMessage = remoteNotification[@"aps"][@"alert"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Received on launch" message:remoteMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:alertAction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [application.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        });
    }
    
    
    [Parse setApplicationId:@"GetFromParseSite" clientKey:@"GetFromParseSite"];
    
    UIUserNotificationType *userNotificationTypes = (UIUserNotificationTypeAlert |UIUserNotificationTypeBadge |UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    return YES;
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)remoteNotification {
    NSString *remoteMessage = remoteNotification[@"aps"][@"alert"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Received while running" message:remoteMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:alertAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    // Doesn't work
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
