//
//  MyUINavigationController.m
//  ToDoManager
//
//  Created by Tom Belov on 21/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "MyUINavigationController.h"

@interface MyUINavigationController ()

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

@end

@implementation MyUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC {
    
    self.managedObjectContext = incomingMOC;
    
    id<DPHandlesMOC> child = (id<DPHandlesMOC>) self.viewControllers[0];
    
    [child receiveMOC:self.managedObjectContext];
}

@end
