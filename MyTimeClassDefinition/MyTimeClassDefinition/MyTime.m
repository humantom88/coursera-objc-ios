//
//  MyTime.m
//  MyTimeClassDefinition
//
//  Created by Tom Belov on 05/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyTime.h"

@implementation MyTime

- (long)approxSecondsSinceWhichYear:(long)whichYear {
    long allSec = 0;
    
    allSec = self.seconds;
    allSec += self.minutes * 60;
    allSec += self.hour * 3600;
    allSec += self.day * 24 * 3600;
    allSec += self.month * 30 * 24 * 3600;
    allSec += (self.year - whichYear) * 365 * 30 * 24 * 3600;
    
    return allSec;
}

- (long)secondsSinceMidnight{
    long x = self.seconds;
    
    x += self.minutes * 60;
    x += self.hour * 3600;
    
    return x;
}

- (long)approxSecondsSince1970 {
    return [self approxSecondsSinceWhichYear:(1970)];
}

- (int)addSomeParameters:(int)a secondParameter:(int)b thirdParameter:(int)c {
    int answer = self.hour;

    answer += a + b + c;

    return answer;
}

@end;
