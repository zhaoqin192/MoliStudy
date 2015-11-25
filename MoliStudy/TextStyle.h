//
//  TextStyle.h
//  MoliStudy1
//
//  Created by 王霄 on 15/10/28.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextStyle : NSObject

@property (nonatomic,copy) NSDictionary *foregroundColor;
@property (nonatomic,copy) NSDictionary *backgroundColor;
@property (nonatomic,copy) NSArray *priority;
@property (nonatomic,assign) int start;
@property (nonatomic,assign) int end;
@property (nonatomic,assign) NSUInteger order;
@property (nonatomic,copy) NSString *fore;
@property (nonatomic,copy) NSString *back;

- (NSComparisonResult)compare:(TextStyle*)style;

@end
