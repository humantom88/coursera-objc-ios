//
//  Exercise+CoreDataProperties.h
//  Workout
//
//  Created by Tom Belov on 07/05/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "Exercise+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Exercise (CoreDataProperties)

+ (NSFetchRequest<Exercise *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t times;
@property (nonatomic) int64_t repeats;
@property (nullable, nonatomic, copy) NSDecimalNumber *weight;
@property (nullable, nonatomic, copy) NSDate *when;

@end

NS_ASSUME_NONNULL_END
