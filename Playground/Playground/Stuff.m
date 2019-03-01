//
//  Stuff.m
//  Playground
//
//  Created by Tom Belov on 28/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "Stuff.h"

@implementation Stuff {
    int _number;
}

- (int)number {
    return self->_number;
}

- (void)setNumber:(int)num {
    self->_number = num;
}

@end
