//
//  main.m
//  MyTimeClassDefinition
//
//  Created by Tom Belov on 05/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyTime.h"

int main(int argc, const char * argv[]) {
    MyTime *time = [MyTime alloc];
    
    time.hour = 10;
    
    int answer;
    
    answer = [time addSomeParameters:1
                     secondParameter:2
                      thirdParameter:3];
    printf("The answer is equal to %d\n", answer);
    
    return 0;
}
