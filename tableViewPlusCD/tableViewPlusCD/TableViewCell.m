//
//  TableViewCell.m
//  tableViewPlusCD
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "TableViewCell.h"
#import "ToDoEntity+CoreDataClass.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
    // Configure the view for the selected state
- (void) setTitle:(ToDoEntity *)incoming {
    self.cellTitle.text = incoming.title;
    
}

@end
