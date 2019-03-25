//
//  SignupViewController.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "SignupViewController.h"
#import "UserModel.h"
#import "DataStore.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (void) createUser:(UserModel*) userModel;
@end

@implementation SignupViewController
- (IBAction)dismissTapped:(id)sender {
    [self.navigation dismissSignupViewController];
}
- (IBAction)signupTapped:(id)sender {
    NSDictionary* userInput = @{@"name": self.nameField.text, @"password": self.passwordField.text};
    UserModel* userModel = [[UserModel alloc] initWithDictionary:userInput];
    [self.interactor createUser:userModel];
}

- (void)createUser:(UserModel*) userModel {
    BOOL success = [DataStore.defaultLocalDB createUser:userModel];
    
    [self userCreationLog:success];
}

- (void)userCreationLog:(BOOL)isSuccessfullyCreated
{
    if (isSuccessfullyCreated) {
        NSLog(@"User successfully created");
        [self.navigation presentHomeScreen];
    } else {
        NSLog(@"User has not been created.");
    };
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
