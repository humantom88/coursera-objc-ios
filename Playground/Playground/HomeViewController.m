//
//  HomeViewController.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "HomeViewController.h"
#import "DataStore.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
- (IBAction)deleteTapped:(id)sender {
    [DataStore.defaultLocalDB deleteUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logoutTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
