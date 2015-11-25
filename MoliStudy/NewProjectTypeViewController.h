//
//  NewProjectTypeViewController.h
//  Coding_iOS
//
//  Created by isaced on 15/3/30.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NewProjectType) {
    NewProjectTypeSchool = 1,
    NewProjectTypeAim = 2,
    NewProjectTypeTime = 3
};

@class NewProjectTypeViewController;

@protocol NewProjectTypeDelegate <NSObject>

// 选中回调
-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC
        didSelectSchool:(NSString*)school;
-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC
      didSelectAim:(NSString*)aim;
-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC
      didSelectTime:(NSString*)time;

@end

@interface NewProjectTypeViewController : UITableViewController

@property (nonatomic, assign) id<NewProjectTypeDelegate> delegate;

// 项目类型
@property (nonatomic, assign) NewProjectType projectType;

@end
