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
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)signupTapped:(id)sender {
    NSDictionary* userInput = [[NSDictionary alloc]init];
    [userInput setValue:self.nameField.text forKey:@"name"];
    [userInput setValue:self.passwordField forKey:@"password"];

    UserModel* userModel = [[UserModel alloc] initWithDictionary:userInput];
    [self createUser:userModel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createUser:(UserModel*) userModel {
    BOOL success = [DataStore.defaultLocalDB createUser:userModel];
    if (success) {
        NSLog(@"User created: %@", userModel);
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
