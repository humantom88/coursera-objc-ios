//
//  PersonMO+CoreDataProperties.h
//  CoreDataCoursera
//
//  Created by Tom Belov on 12.02.2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//
//

#import "PersonMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonMO (CoreDataProperties)

+ (NSFetchRequest<PersonMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *person_name;
@property (nullable, nonatomic, retain) NSSet<ChoreLogMO *> *chore_log;

@end

@interface PersonMO (CoreDataGeneratedAccessors)

- (void)addChore_logObject:(ChoreLogMO *)value;
- (void)removeChore_logObject:(ChoreLogMO *)value;
- (void)addChore_log:(NSSet<ChoreLogMO *> *)values;
- (void)removeChore_log:(NSSet<ChoreLogMO *> *)values;

@end

NS_ASSUME_NONNULL_END
