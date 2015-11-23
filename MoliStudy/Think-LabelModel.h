//
//  Think-LabelModel.h
//  
//
//  Created by 张鹏 on 15/8/14.
//
//

#import <Foundation/Foundation.h>

@interface Think_LabelModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger think_label_type_id;
@property (nonatomic, assign) NSInteger question_id;
@property (nonatomic, assign) NSInteger position_start;
@property (nonatomic, assign) NSInteger position_end;
@property (nonatomic, copy)  NSString *style;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, assign) BOOL is_study;
@property (nonatomic, copy) NSString *rank;

@end
