//
//  ViewController.m
//  PushyApp
//
//  Created by Tom Belov on 08/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void) requestPermissionToNotify;
- (void) createNotification:(int)secondsInTheFuture;
@end

@implementation ViewController
- (IBAction)scheduleButtonClicked:(id)sender {
    [self requestPermissionToNotify];
    [self createNotification:15];
}

- (void) createNotification:(int)secondsInTheFuture {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:secondsInTheFuture];
    notification.timeZone = nil;
    
    notification.alertTitle = @"Alert title";
    notification.alertBody = @"Alert Body";
    notification.alertAction = @"Okay";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 4123;
    
    notification.category = @"MAIN_CATEGORY";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void) requestPermissionToNotify {
    UIMutableUserNotificationAction *floatAction = [[UIMutableUserNotificationAction alloc] init];
    floatAction.identifier = @"FLOAT_ACTION";
    floatAction.title = @"Float";
    floatAction.activationMode = UIUserNotificationActivationModeBackground;
    floatAction.destructive = YES;
    floatAction.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *stingAction = [[UIMutableUserNotificationAction alloc] init];
    stingAction.identifier = @"STING_ACTION";
    stingAction.title = @"Sting";
    stingAction.activationMode = UIUserNotificationActivationModeForeground;
    stingAction.destructive = NO;
    stingAction.authenticationRequired = NO;
    
    UIMutableUserNotificationCategory *responseCategory = [[UIMutableUserNotificationCategory alloc] init];
    responseCategory.identifier = @"MAIN_CATEGORY";
    [responseCategory setActions:@[floatAction, stingAction] forContext:UIUserNotificationActionContextDefault];
    
    NSSet *categories = [NSSet setWithObjects:responseCategory, nil];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
