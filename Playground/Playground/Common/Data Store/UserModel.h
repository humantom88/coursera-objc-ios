//
//  UserModel.h
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* password;

- (UserModel*)initWithDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
