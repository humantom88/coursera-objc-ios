//
//  LoginViewController.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "LoginViewController.h"
#import "DataStore.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (IBAction)loginTapped:(id)sender
{
    NSDictionary* userInput = @{
        @"name": self.emailField.text,
        @"password": self.passwordField.text                            
    };
    UserModel* userModel = [[UserModel alloc] initWithDictionary:userInput];
    [self login:userModel];
}

- (IBAction)dismissTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) login:(UserModel*)userModel
{
    if ([DataStore.defaultLocalDB login:userModel]) {
        NSLog(@"User successfully logged in");
        UIViewController* homeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeViewController animated:YES completion:nil];
    } else {
        NSLog(@"User not logged in");
    }
}

@end
