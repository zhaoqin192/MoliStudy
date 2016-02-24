//
//  NoteContentView.h
//  MoliStudy
//
//  Created by zhaoqin on 2/24/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteContentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *noteText;
@property (weak, nonatomic) IBOutlet UIView *arrowView;
@property BOOL shown;


- (void) initHelper;
- (void) show;
- (void) hide;
- (void) setData:(NSMutableDictionary *)data;

@end
