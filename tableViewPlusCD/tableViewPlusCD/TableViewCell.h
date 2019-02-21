//
//  TableViewCell.h
//  tableViewPlusCD
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

- (void) setTitle:(ToDoEntity *)incoming;

@end

NS_ASSUME_NONNULL_END
