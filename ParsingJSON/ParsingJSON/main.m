//
//  main.m
//  ParsingJSON
//
//  Created by Tom Belov on 08/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *rawDataString = @"{ \
            \"place\": [ \
                \"at home\",\
                \"at work\",\
                \"at park\"\
            ], \
            \"activity\": [ \
                \"watching youtube\",\
                \"writing code\"\
            ], \
            \"duration\": [ \
                1, \
                2, \
                3, \
                5 \
            ] \
        }";
        
        NSError *error = nil;
        NSData *rawData = [rawDataString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonData = [NSJSONSerialization
                                    JSONObjectWithData:rawData
                                    options:0
                                    error: &error];
        if (!error) {
            NSLog(@"%@", jsonData[@"place"][0]);
            NSLog(@"%@", jsonData[@"place"][1]);
            NSLog(@"%@", jsonData[@"duration"][1]);
        } else {
            NSLog(@"%@", error);
        }
        
        
    }
    return 0;
}
