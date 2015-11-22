//
//  Record+CoreDataProperties.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Record.h"

NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *accuracy;
@property (nullable, nonatomic, retain) NSNumber *complete;
@property (nullable, nonatomic, retain) NSNumber *forecast;

@end

NS_ASSUME_NONNULL_END
