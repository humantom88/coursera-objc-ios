//
//  MyUITableViewCell.m
//  ToDoManager
//
//  Created by Tom Belov on 22/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "MyUITableViewCell.h"

@implementation MyUITableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void) setInternalFields:(ToDoEntity *)incomingToDoEntity
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.toDoTitleLabel.text = incomingToDoEntity.toDoTitle;
    self.localToDoEntity = incomingToDoEntity;

    self.toDoDueDateLabel.text = [dateFormatter stringFromDate:incomingToDoEntity.toDoDueDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected
              animated:animated];
}

@end
