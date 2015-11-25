//
//  DrawerViewController.h
//  Drawer
//
//  Created by 张鹏 on 15/3/23.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 声明bloc
typedef void(^RootViewMoveBlock) (UIView *rootView, CGRect orginFrame, CGFloat xOffset);

@interface DrawerViewController : UIViewController

@property (assign, nonatomic) BOOL needSwipeShowMenu;

@property (retain, nonatomic) UIViewController *rootViewController;
@property (retain, nonatomic) UIViewController *leftViewController NS_AVAILABLE_IOS(5_0);
@property (retain, nonatomic) UIViewController *rightViewController NS_AVAILABLE_IOS(5_0);

@property (assign, nonatomic) CGFloat leftViewShowWidth; // 左边栏展示宽度大小
@property (assign, nonatomic) CGFloat rightViewShowWidth; // 右边栏展示宽度大小

@property (assign, nonatomic) NSTimeInterval animationDuration; // 动画时长
@property (assign, nonatomic) BOOL showBoundsShadow; // 是否显示边框阴影

@property (copy, nonatomic) RootViewMoveBlock rootViewMoveBlock; // 可在此block中重做动画效果

- (void)setRootViewMoveBlock:(RootViewMoveBlock)rootViewMoveBlock;

- (void)showLeftViewController:(BOOL)animated; // 展示左边框
- (void)showrightViewController:(BOOL)animated; // 展示右边框
- (void)hideSideViewController:(BOOL)animated; // 恢复正常位置
@end
