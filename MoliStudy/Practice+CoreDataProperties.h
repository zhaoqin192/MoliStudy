//
//  Practice+CoreDataProperties.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Practice.h"

NS_ASSUME_NONNULL_BEGIN

@interface Practice (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *finished;
@property (nullable, nonatomic, retain) NSString *itemID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *total;

@end

NS_ASSUME_NONNULL_END
