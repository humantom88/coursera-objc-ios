//
//  MyUIViewController.m
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "MyUIViewController.h"

@interface MyUIViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (weak, nonatomic) IBOutlet UITextView *detailsField;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ToDoEntity *localToDoEntity;

@property (assign, nonatomic) BOOL wasDeleted;

@end

@implementation MyUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.wasDeleted = NO;
    
    self.titleField.text = self.localToDoEntity.toDoTitle;
    self.detailsField.text = self.localToDoEntity.toDoDetails;
    
    NSDate *dueDate = self.localToDoEntity.toDoDueDate;
    if (dueDate != nil)
    {
        [self.dueDatePicker setDate:dueDate];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void) textViewDidEndEditing: (NSNotification *)notification
{
    if([notification object] == self)
    {
        self.localToDoEntity.toDoDetails = self.detailsField.text;
        [self saveMyToDoEntity];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    if (!self.wasDeleted)
    {
        [self saveEverything];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
}

- (IBAction)trashTapped:(id)sender
{
    self.wasDeleted = YES;
    
    [self.managedObjectContext deleteObject:self.localToDoEntity];
    [self saveMyToDoEntity];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC
{
    self.managedObjectContext = incomingMOC;
}

- (void) receiveToDoEntity:(id)incomingToDoEntity
{
    self.localToDoEntity = incomingToDoEntity;
}
- (IBAction)titleFieldEdited:(id)sender
{
    self.localToDoEntity.toDoTitle = self.titleField.text;
    [self saveMyToDoEntity];
}
- (IBAction)dueDateEdited:(id)sender
{
    self.localToDoEntity.toDoDueDate = self.dueDatePicker.date;
    [self saveMyToDoEntity];
}

- (void) saveMyToDoEntity
{
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if (!saveSuccess)
    {
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"My: Unable to save entity"
                                     userInfo:@{NSUnderlyingErrorKey:err}];
    }
}

- (void) saveEverything
{
    self.localToDoEntity.toDoDetails = self.detailsField.text;
    self.localToDoEntity.toDoDueDate = self.dueDatePicker.date;
    self.localToDoEntity.toDoTitle = self.titleField.text;
    
    [self saveMyToDoEntity];
}

@end
