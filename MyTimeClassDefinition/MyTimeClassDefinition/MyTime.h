//
//  MyTime.h
//  MyTimeClassDefinition
//
//  Created by Tom Belov on 05/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#ifndef MyTime_h
#define MyTime_h

@interface MyTime : NSObject

@property (nonatomic) int year;
@property (nonatomic) int month;
@property (nonatomic) int day;
@property (nonatomic) int hour;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;

- (long)approxSecondsSinceWhichYear:(long)whichYear;
- (long)approxSecondsSince1970;
- (long)secondsSinceMidnight;
- (int)addSomeParameters:(int)a secondParameter:(int)b thirdParameter:(int)c;

@end

#endif /* MyTime_h */
