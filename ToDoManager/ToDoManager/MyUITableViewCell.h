//
//  MyUITableViewCell.h
//  ToDoManager
//
//  Created by Tom Belov on 22/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyUITableViewCell : UITableViewCell

@property (strong, nonatomic) ToDoEntity *localToDoEntity;

@property (weak, nonatomic) IBOutlet UILabel *toDoDueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoTitleLabel;

- (void) setInternalFields:(ToDoEntity *)incomingToDoEntity;

@end

NS_ASSUME_NONNULL_END
