//
//  ViewController.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 15/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PickerViewHelper.h"

@interface ViewController ()

@property (nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *choreField;
@property (weak, nonatomic) IBOutlet UIPickerView *choreRoller;
@property (nonatomic) PickerViewHelper *choreRollerHelper;

@property (weak, nonatomic) IBOutlet UITextField *personField;
@property (weak, nonatomic) IBOutlet UIPickerView *personRoller;
@property (nonatomic) PickerViewHelper *personRollerHelper;

@property (weak, nonatomic) IBOutlet UILabel *persistedData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    self.choreRollerHelper = [[PickerViewHelper alloc] init];
    self.personRollerHelper = [[PickerViewHelper alloc] init];
    
    [self.choreRoller setDelegate:self.choreRollerHelper];
    [self.choreRoller setDataSource:self.choreRollerHelper];
    
    [self.personRoller setDelegate:self.personRollerHelper];
    [self.personRoller setDataSource:self.personRollerHelper];
    
    [self updateChoreRoller];
    [self updatePersonRoller];
    [self updateLogList];
}

- (IBAction)choreTapped:(id)sender {
    ChoreMO *choreMO = [self.appDelegate createChoreMO];
    choreMO.chore_name = self.choreField.text;
    [self.appDelegate saveContext];
    [self updateLogList];
    [self updateChoreRoller];
}

- (IBAction)personTapped:(id)sender {
    PersonMO *personMO = [self.appDelegate createPersonMO];
    personMO.person_name = self.personField.text;
    [self.appDelegate saveContext];
    [self updatePersonRoller];
}

- (IBAction)choreLogTapped:(id)sender {
    NSInteger choreRow = [self.choreRoller selectedRowInComponent:0];
    
    NSInteger personRow = [self.personRoller selectedRowInComponent:0];
    
    ChoreMO *choreMO = (ChoreMO *) [self.choreRollerHelper getItemFromArray:choreRow];
    PersonMO *personMO = (PersonMO *) [self.choreRollerHelper getItemFromArray:personRow];
    
    ChoreLogMO *choreLogMO = (ChoreLogMO *) [self.appDelegate createChoreMO];
    
    choreLogMO.chore_done = choreMO;
    choreLogMO.person_who_did_it = personMO;
    choreLogMO.when = [self.datePicker date];

    [self.appDelegate saveContext];
}

- (IBAction)deleteTapped:(id)sender {
    [self deleteChores];
    [self deletePersons];
    [self updatePersonRoller];
    [self updateChoreRoller];
}

- (void) deleteChores {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Chore objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreMO* c in results) {
        [moc deleteObject:c];
    }
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (void) deletePersons {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Chore objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (PersonMO* p in results) {
        [moc deleteObject:p];
    }
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (void) updateLogList {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Chore objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (ChoreLogMO* cl in results) {
        [buffer appendFormat:@"%@:%@-%@\n", cl.when, cl.person_who_did_it, cl.chore_done, nil];
    }
    
    self.persistedData.text = (NSString *)buffer;
}

- (void) updateChoreRoller {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Chore objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableArray *choreData = [NSMutableArray arrayWithArray:@[]];
    for(ChoreMO *c in results) {
        [choreData addObject:c];
    }
    
    [self.choreRollerHelper setArray:choreData];
    [self.choreRoller reloadAllComponents];
}

- (void) updatePersonRoller {
    NSManagedObjectContext *moc = [self.appDelegate.persistentContainer viewContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSError *error;
    NSArray *results = (NSArray *) [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Person objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableArray *personData = [NSMutableArray arrayWithArray:@[]];
    for(PersonMO *p in results) {
        [personData addObject:p];
    }
    [self.personRollerHelper setArray:personData];
    [self.personRoller reloadAllComponents];
}

@end
