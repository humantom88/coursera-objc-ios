//
//  ViewController.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 12.02.2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *choreLogLabel;
@property (weak, nonatomic) IBOutlet UITextField *choreText;

@property (nonatomic) AppDelegate *appDelegate;

- (void) updateLogList;

@end

@implementation ViewController

- (IBAction)addChoreTapped:(id)sender {
    ChoreMO *c = [self.appDelegate createChoreMO];
    c.chore_name = self.choreText.text;
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)updateLogList {
    NSManagedObjectContext *moc = self.appDelegate.persistentContainer.newBackgroundContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (ChoreMO *c in results) {
        [buffer appendFormat:@"\n%@",c.chore_name,nil];
    }
    
    self.choreLogLabel.text = buffer;
}


@end
