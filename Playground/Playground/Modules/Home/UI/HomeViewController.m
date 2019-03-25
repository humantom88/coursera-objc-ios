//
//  HomeViewController.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (IBAction)deleteTapped:(id)sender {
    [self.interactor deleteUser];
    [self.navigation dismissHomeViewController];
}
- (IBAction)logoutTapped:(id)sender {
    [self.navigation dismissHomeViewController];
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
