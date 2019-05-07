//
//  ViewController.m
//  Workout
//
//  Created by Tom Belov on 07/05/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *exerciseTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatsTextField;
@property (weak, nonatomic) IBOutlet UITextField *timesTextFIeld;
@property (weak, nonatomic) IBOutlet UIDatePicker *whenDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *exercisesLogLabel;

@end

@implementation ViewController

- (IBAction)addTapped:(id)sender {
    Exercise *exercise = [self.appDelegate createExercise];

    exercise.name = self.exerciseTextField.text;
    exercise.when = self.whenDatePicker.date;
    exercise.weight = [[NSDecimalNumber alloc]initWithString:self.weightTextField.text];
    exercise.repeats = [self.repeatsTextField.text intValue];
    exercise.times = [self.timesTextFIeld.text intValue];

    [self.appDelegate saveContext];
    [self updateLogList];
}

- (void) updateLogList {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Exercise objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (Exercise *exercise in results) {
        [buffer appendFormat:@"%@:%@-%@-%lld-%lld\n", exercise.when, exercise.name, exercise.weight, exercise.repeats, exercise.times, nil];
    }
    
    self.exercisesLogLabel.text = (NSString *)buffer;
}

- (void) deleteAllExercises {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Chore objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (Exercise* ex in results) {
        [moc deleteObject:ex];
    }
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    [self updateLogList];
}


@end
