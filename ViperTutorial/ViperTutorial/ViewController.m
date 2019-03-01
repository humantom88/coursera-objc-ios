//
//  ViewController.m
//  ViperTutorial
//
//  Created by Tom Belov on 25/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "Typhoon/TyphoonStoryboard.h"

const NSInteger MainMenuCellsCity = 0;
const NSInteger MainMenuCellsPlaces = 1;
const NSInteger MainMenuCellsReferenceBook = 2;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    cell.textLabel.text = [NSString stringWithFormat: @"%ld cell", indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    long index = indexPath.row;
    switch (index) {
        case MainMenuCellsCity: {
            UIStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Quarters" factory:AGAppDelegateMacros.storyboardFactory bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"agquarterslistviewcontroller"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case MainMenuCellsPlaces: {
            UIStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Places" factory:AGAppDelegateMacros.storyboardFactory bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"agplacescategorieslist"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case MainMenuCellsReferenceBook: {
            UIStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"ReferenceBook" factory:AGAppDelegateMacros.storyboardFactory bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"agreferencebookcategoriesviewcontroller"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
    }
}

@end
