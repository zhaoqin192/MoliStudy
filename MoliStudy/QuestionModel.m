//
//  QuestionModel.m
//  
//
//  Created by 张鹏 on 15/7/15.
//
//

#import "QuestionModel.h"

@implementation QuestionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqual: @"id"]) {
        self.Id = value;
    }
}

+ (QuestionModel *)shareQuestionModel
{
    static QuestionModel *model = nil;
    
    if (!model) {
        
        model = [[QuestionModel alloc] init];;
        
    }
    
    return model;
}

@end
