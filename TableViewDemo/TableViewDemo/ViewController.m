//
//  ViewController.m
//  TableViewDemo
//
//  Created by Tom Belov on 20/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "MyCellTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *ourStrings;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
- (IBAction)addButtonTapped:(id)sender {
    [self.tableView beginUpdates];
    
    [self.ourStrings addObject:self.textField.text];
    
    NSInteger newRow = [self.ourStrings count] - 1;
    NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[newIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];

    // If no animation: [self.tableView reloadData];
    
}
- (IBAction)sortButtonTapped:(id)sender {
    for (long i = [self.ourStrings count] - 2; i >= 0; i--) {
        for (long j = i; j < [self.ourStrings count] - 1; j++) {
            if ([self.ourStrings[j] compare:self.ourStrings[j+1]] > 0) {
                // swap our elements
                [self.tableView beginUpdates];
                [self.ourStrings exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:j inSection:0];
                NSIndexPath *secondIndex = [NSIndexPath indexPathForRow:j+1 inSection:0];
                
                [self.tableView moveRowAtIndexPath:firstIndex toIndexPath:secondIndex];
                [self.tableView endUpdates];
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ourStrings = [NSMutableArray arrayWithArray:@[@"The first row",
                                                @"The second row"
                                                ]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ourStrings.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCellTableViewCell *cell = (MyCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OurCell" forIndexPath:indexPath];
//    cell.ourCellLabel.text = [NSString stringWithFormat:@"Row number: %d", (int)indexPath.row];
    cell.ourCellLabel.text = self.ourStrings[indexPath.row];

    return cell;
}


@end
