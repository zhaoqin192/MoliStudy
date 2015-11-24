//
//  PracticeBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "PracticeBL.h"
#import "DAOContext.h"

@implementation PracticeBL

- (void) addPractice:(Practice *)model{
    PracticeDao* dao = [PracticeDao sharedManager];
    [dao add:model];
}

- (NSMutableArray*) findAll{
    PracticeDao* dao = [PracticeDao sharedManager];
    return [dao findAll];
}

- (void) updatePracticeList:(NSArray *)array{
    NSManagedObjectContext *appContext = [DAOContext getInstance].appContext;
    PracticeDao *dao = [PracticeDao sharedManager];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Practice" inManagedObjectContext:appContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSInteger count = [array count];
    for(int i = 0; i < count; i++){
        NSDictionary *dictionary = array[i];
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"itemID = %@", [dictionary objectForKey:@"id"]];
        [request setPredicate:filter];
        NSError *error = nil;
        NSArray *requestArray = [appContext executeFetchRequest:request error:&error];
        if([requestArray count] == 0){
            Practice *practice = [NSEntityDescription insertNewObjectForEntityForName:@"Practice" inManagedObjectContext:appContext];
            practice.itemID = [array[i] objectForKey:@"id"];
            practice.name = [array[i] objectForKey:@"name"];
            practice.finished = [NSNumber numberWithInt:[[array[i] objectForKey:@"question_studied"] intValue]];
            practice.total = [NSNumber numberWithInt:[[array[i] objectForKey:@"question_count"] intValue]];
            [dao add:practice];
        }else{
            Practice *practice = requestArray[0];
            [dao modifiy:practice];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_TRAIN_SUCCESS" object:nil];
}

@end
