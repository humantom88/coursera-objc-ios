//
//  ViewController.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 11/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChoreMO+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic) AppDelegate *appDelegate;

@end

@implementation ViewController

- (IBAction)choreTapped:(id)sender {
    ChoreMO *chore = [self.appDelegate createChoreMO];
    chore.chore_name = self.choreField.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
}


@end
