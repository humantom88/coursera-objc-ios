//
//  User.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "UserModel.h"

@interface UserModel ()
@property (nonatomic, strong) NSDictionary* inputDictionary;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@end

@implementation UserModel

@synthesize name = _name;
- (NSString *) name {
    return [self.inputDictionary valueForKey:@"name"];
}
- (void)setname:(NSString *)newName {
    if ([_name isEqualToString:newName]) return;
    _name = newName;
    [self.inputDictionary setValue:newName forKey:@"name"];
}

@synthesize password = _password;
- (NSString *) password {
    return [self.inputDictionary valueForKey:@"password"];
}
- (void)setPassword:(NSString *)newPassword {
    if ([_password isEqualToString:newPassword]) return;
    _password = newPassword;
    [self.inputDictionary setValue:newPassword forKey:@"password"];
}

- (UserModel*)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.inputDictionary = dictionary;
    }
    return self;
}
    
@end
