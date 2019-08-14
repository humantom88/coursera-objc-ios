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
@property (weak, nonatomic) IBOutlet UIDatePicker *createdAtPicker;
@property (weak, nonatomic) IBOutlet UITextView *commentsField;

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
    self.commentsField.text = self.localToDoEntity.toDoDetails;
    
    NSDate *dueDate = self.localToDoEntity.lastUpdateDateTime;
    if (dueDate != nil)
    {
        [self.createdAtPicker setDate:dueDate];
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
        self.localToDoEntity.toDoDetails = self.commentsField.text;
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
	NSDate *newDate = [NSDate new];
	self.localToDoEntity.lastUpdateDateTime = newDate;
	self.createdAtPicker.date = newDate;
    [self saveMyToDoEntity];
}
- (IBAction)dueDateEdited:(id)sender
{
    self.localToDoEntity.lastUpdateDateTime = self.createdAtPicker.date;
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
    self.localToDoEntity.toDoDetails = self.commentsField.text;
    self.localToDoEntity.lastUpdateDateTime = self.createdAtPicker.date;
    self.localToDoEntity.toDoTitle = self.titleField.text;
    
    [self saveMyToDoEntity];
}

@end
