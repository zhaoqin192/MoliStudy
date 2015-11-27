//
//  SubjectBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/24/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "SubjectBL.h"
#import "Subject.h"
#import "ThinkLabel.h"
#import "Note.h"
#import "UtilityBL.h"
#import "ModelManager.h"

@implementation SubjectBL

- (void)addArray:(NSArray *)response{
    ModelManager *manager = [ModelManager getInstance];
    [manager.subjectArray removeAllObjects];

    for(NSDictionary *array in response){
        //get Subject
        Subject *subject = [[Subject alloc] init];
        [subject initData];
        NSArray *modelarr = [array objectForKey:@"modelarr"];
        NSArray *names = [modelarr[0] objectForKey:@"name"];
        
        subject.questionID = [modelarr[0] objectForKey:@"question_total_id"];
        
        for(NSString *name in names){
            [subject.content addObject:[UtilityBL removeHTMLTag:name]];
        }
        
        //get Answers
        NSArray *answers = [modelarr[0] objectForKey:@"answers"];
        for(NSArray *answer in answers){
            NSString *detail = [[NSString alloc] init];
            for(NSString *answerDetail in answer){
                detail = [[detail stringByAppendingString:answerDetail] stringByAppendingString:@" "];
            }
            [subject.answers addObject:detail];
        }
        subject.correctAnswer = [modelarr[0] objectForKey:@"correct_answer"];
        NSArray *thinkLabelsIDs = [modelarr[0] objectForKey:@"think_label_id"];
        for(NSString *thinkLabelID in thinkLabelsIDs){
            [subject.thinkLabelID addObject:thinkLabelID];
        }
        //get ThinkLabel
        NSArray *thinkLabels = [modelarr[0] objectForKey:@"think_labels"];
        NSArray *thinkLists = [array objectForKey:@"thinklabellist"];
        NSArray *thinkList = [thinkLists objectAtIndex:0];
        
        for(int i = 0; i < [thinkLabels count]; i++){
            BOOL flag = NO;
            NSArray *thinkLabel = thinkLabels[i];
            ThinkLabel *label = [[ThinkLabel alloc] init];
            [label initData];
            for(NSDictionary *noteDictionary in thinkLabel){
                if([[noteDictionary objectForKey:@"think_label_type_id"] intValue] == 0){
                    flag = YES;
                    break;
                }
                Note *note = [[Note alloc] init];
                note.positionStart = [noteDictionary objectForKey:@"position_start"];
                note.positionEnd = [noteDictionary objectForKey:@"position_end"];
                note.style = [noteDictionary objectForKey:@"style"];
                note.noteContent = [UtilityBL removeHTMLTag:[noteDictionary objectForKey:@"note"]];
                [[label noteArray] addObject:note];
            }
            if(!flag && [thinkList isKindOfClass:[NSArray class]]){
                NSDictionary *think = thinkList[i];
                label.name = [think objectForKey:@"name"];
                [subject.thinkLabel addObject:label];
            }
        }
        [manager.subjectArray addObject:subject];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];

    }
}

- (void)addArrayByID:(NSArray *)response{
    ModelManager *manager = [ModelManager getInstance];
    [manager.subjectArray removeAllObjects];
    
    for(NSDictionary *array in response){
        //get Subject
        Subject *subject = [[Subject alloc] init];
        [subject initData];
        NSArray *modelarr = [array objectForKey:@"modelarr"];
        NSLog(@"modellarr---%@", modelarr[0]);
        NSArray *names = [modelarr[0] objectForKey:@"name"];
        
        subject.questionID = [modelarr[0] objectForKey:@"question_total_id"];
        
        for(NSString *name in names){
            [subject.content addObject:[UtilityBL removeHTMLTag:name]];
        }
        
        //get Answers
        NSArray *answers = [modelarr[0] objectForKey:@"answers"];
        for(NSArray *answer in answers){
            NSString *detail = [[NSString alloc] init];
            for(NSString *answerDetail in answer){
                detail = [[detail stringByAppendingString:answerDetail] stringByAppendingString:@" "];
            }
            [subject.answers addObject:detail];
        }
        subject.correctAnswer = [modelarr[0] objectForKey:@"correct_answer"];
        NSArray *thinkLabelsIDs = [modelarr[0] objectForKey:@"think_label_id"];
        for(NSString *thinkLabelID in thinkLabelsIDs){
            [subject.thinkLabelID addObject:thinkLabelID];
        }
        //get ThinkLabel
        NSArray *thinkLabels = [modelarr[0] objectForKey:@"think_labels"];
        NSArray *thinkLists = [array objectForKey:@"thinklabellist"];
        NSArray *thinkList = [thinkLists objectAtIndex:0];
        
        for(int i = 0; i < [thinkLabels count]; i++){
            BOOL flag = NO;
            NSArray *thinkLabel = thinkLabels[i];
            ThinkLabel *label = [[ThinkLabel alloc] init];
            [label initData];
            for(NSDictionary *noteDictionary in thinkLabel){
                if([[noteDictionary objectForKey:@"think_label_type_id"] intValue] == 0){
                    flag = YES;
                    break;
                }
                Note *note = [[Note alloc] init];
                note.positionStart = [noteDictionary objectForKey:@"position_start"];
                note.positionEnd = [noteDictionary objectForKey:@"position_end"];
                note.style = [noteDictionary objectForKey:@"style"];
                note.noteContent = [UtilityBL removeHTMLTag:[noteDictionary objectForKey:@"note"]];
                [[label noteArray] addObject:note];
            }
            if(!flag && [thinkList isKindOfClass:[NSArray class]]){
                NSDictionary *think = thinkList[i];
                label.name = [think objectForKey:@"name"];
                [subject.thinkLabel addObject:label];
            }
        }
        [manager.subjectArray addObject:subject];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
        
    }

}

@end
