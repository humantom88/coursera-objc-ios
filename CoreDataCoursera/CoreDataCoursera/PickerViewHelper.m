//
//  PickerViewHelperViewController.m
//  CoreDataCoursera
//
//  Created by Tom Belov on 15/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "PickerViewHelper.h"

@interface PickerViewHelper ()

@property (nonatomic) NSMutableArray* pickerData;

@end

@implementation PickerViewHelper

- (id) init {
    if([super init] == nil) {
        return nil;
    };
    
    self.pickerData = [NSMutableArray arrayWithArray:@[]];
    
    return self;
}

- (void) setArray:(NSArray *)incoming {
    self.pickerData = [NSMutableArray arrayWithArray:incoming];
}

- (void) addItemToArray:(NSObject *)thing {
    [self.pickerData addObject:thing];
}

- (NSObject *) getItemFromArray:(NSUInteger)index {
    return [self.pickerData objectAtIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.pickerData objectAtIndex:row] description];
}

@end
