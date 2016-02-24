//
//  NoteContentView.m
//  MoliStudy
//
//  Created by zhaoqin on 2/24/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "NoteContentView.h"

@implementation NoteContentView

- (void) initHelper{
    UITapGestureRecognizer *arrowTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backtrack)];
    [self.arrowView addGestureRecognizer:arrowTap];
}

- (void) show{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.shown = YES;
}

- (void) hide{
    self.shown = NO;
    [self removeFromSuperview];
}

- (void) toggle{
    if(self.shown){
        [self hide];
    }else{
        [self show];
    }
}

- (void) setData:(NSMutableDictionary *)data{
    self.content.text = [data objectForKey:@"noteText"];
    self.noteText.text = [data objectForKey:@"content"];
}

- (void) backtrack{
    [self hide];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTECONTENTVIEWDISAPPEAR" object:nil];
}

@end
