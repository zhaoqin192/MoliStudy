//
//  ReportModel.h
//  
//
//  Created by 张鹏 on 15/10/9.
//
//

#import <Foundation/Foundation.h>

@interface ReportModel : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat per;
@property (nonatomic, assign) NSInteger score;

@end
