//
//  QuestionModel.h
//  
//
//  Created by 张鹏 on 15/7/15.
//
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject
//整体
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, strong) NSMutableArray *name;
@property (nonatomic, assign) NSInteger *difficulty;
@property (nonatomic, copy) NSString *correct_answer;
@property (nonatomic, strong) NSMutableArray *answers;
@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, assign) NSInteger question_mode;
@property (nonatomic, assign) NSInteger sub_course_id;
@property (nonatomic, copy) NSString *chapter_id;
@property (nonatomic, assign) NSInteger question_total_id;
@property (nonatomic, strong) NSMutableArray *knowledge_id;
@property (nonatomic, strong) NSMutableArray *think_label_id;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *modified;
@property (nonatomic, copy) NSString *is_del;
@property (nonatomic, copy) NSString *instructions;
@property (nonatomic, assign) NSInteger question_type;
@property (nonatomic, strong) NSMutableArray *know_info;
@property (nonatomic, strong) NSMutableArray *think_labels;


+(QuestionModel *)shareQuestionModel;
@end
