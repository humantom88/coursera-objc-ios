//
//  UserModel.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (UserModel*)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    if (self) {
        self.name = [dict valueForKey:@"name"];
        self.password = [dict valueForKey:@"password"];
    }
    
    return self;
}


@end
