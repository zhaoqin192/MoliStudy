//
//  Report+CoreDataProperties.h
//  MoliStudy
//
//  Created by zhaoqin on 11/23/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Report.h"

NS_ASSUME_NONNULL_BEGIN

@interface Report (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *knowledgeID;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSNumber *variety;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
