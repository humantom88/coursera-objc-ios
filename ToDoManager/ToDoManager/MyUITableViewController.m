//
//  MyUITableViewController.m
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "MyUITableViewController.h"
#import "ToDoEntity+CoreDataClass.h"
#import "MyUITableViewCell.h"
#import "DPHandlesToDoEntity.h"

@interface MyUITableViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@end


@implementation MyUITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeNSFetchedResultsControllerDelegate];
}

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC
{
    self.managedObjectContext = incomingMOC;
}

- (void) initializeNSFetchedResultsControllerDelegate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    request.entity = [NSEntityDescription entityForName: @"ToDoEntity"
                                 inManagedObjectContext:self.managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    request.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"lastUpdateDateTime" ascending:NO]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                 managedObjectContext:self.managedObjectContext
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    self.resultsController.delegate = self;

    NSError *err;
    BOOL fetchSucceeded = [self.resultsController performFetch:&err];
    if (!fetchSucceeded)
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"Couldn't fetch"
                                     userInfo:nil];
    }
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsController.sections[section].numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoEntity *entity = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
    MyUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCellIdentifier"
                                                              forIndexPath:indexPath];
    
    [cell setInternalFields:entity];
    
    return cell;
}

- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
            MyUITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            ToDoEntity *entity = [controller objectAtIndexPath:indexPath];
            [cell setInternalFields:entity];
            break;
        }
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id<DPHandlesMOC, DPHandlesToDoEntity> child = (id<DPHandlesMOC, DPHandlesToDoEntity>)[segue destinationViewController];
    [child receiveMOC:self.managedObjectContext];
    
    ToDoEntity *entity;
    if ([sender isMemberOfClass:[UIBarButtonItem class]])
    {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity"
                                               inManagedObjectContext:self.managedObjectContext];
    } else
    {
        MyUITableViewCell *source = (MyUITableViewCell *)sender;
        entity = source.localToDoEntity;
    }
    
    [child receiveToDoEntity:entity];
}

@end
