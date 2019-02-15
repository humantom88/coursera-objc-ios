//
//  PickerViewHelperViewController.h
//  CoreDataCoursera
//
//  Created by Tom Belov on 15/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickerViewHelper : UIViewController <UIPickerViewDataSource, UIPickerViewDataSource>

- (void) setArray:(NSMutableArray *)array;
- (void) addItemToArray:(NSObject *)thing;
- (NSObject *) getItemFromArray:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
