//
//  DrawerViewController.h
//  Drawer
//
//  Created by 张鹏 on 15/3/23.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import "DrawerViewController.h"

@interface DrawerViewController () <UIGestureRecognizerDelegate>
{
    UIView *_baseView;    // 目前是_baseView
    UIView *_currentView; // 其实就是rootViewController.view
    UIPanGestureRecognizer *_panGestureRecognizer;
    
    CGPoint _startPanPoint;
    CGPoint _lastPanPoint;
    BOOL _panMovingRightOrLeft; // true是向右，false是像左
    
    UIButton *_coverButton;
    
    BOOL _isInit; // 是否初始化
    
}

@end


@implementation DrawerViewController

#pragma mark - 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // 子页面初始化
        _animationDuration = 0.5; // 动画持续时间按
        _showBoundsShadow = true; // 是否显示阴影
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_panGestureRecognizer setDelegate:self];
        
        _panMovingRightOrLeft = false;
        _lastPanPoint = CGPointZero;
        
        _coverButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        [_coverButton addTarget:self action:@selector(hideSideViewController:) forControlEvents:UIControlEventTouchUpInside];
        
        _isInit = true;
    }
    return self;
}

- (id)init
{
    return [self initWithNibName:nil bundle:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _baseView = self.view;
//    [_baseView setBackgroundColor:[UIColor colorWithRed:0.109 green:0.800 blue:0.282 alpha:1.000]];
    [_baseView setBackgroundColor:[UIColor whiteColor]];
    self.needSwipeShowMenu = true;
}

#pragma mark - 判断是否设置根视图控制器
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.rootViewController) {
        NSAssert(false, @"you must set rootViewController");
    }
    if (_isInit) {
        [self resetCurrentViewToRootViewController];
        _isInit = false;
    }
}


#pragma mark - 重写RootViewController的setter方法
- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (_rootViewController != rootViewController) {
        if (_rootViewController) {
            [_rootViewController removeFromParentViewController];
        }
        _rootViewController = rootViewController;
        if (_rootViewController) {
            [self addChildViewController:_rootViewController];
        }
        if (!_isInit) {
            [self resetCurrentViewToRootViewController];
        }
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if (_leftViewController != leftViewController) {
        if (_leftViewController) {
            [_leftViewController removeFromParentViewController];
        }
        _leftViewController = leftViewController;
        if (_leftViewController) {
            [self addChildViewController:_leftViewController];
        }
    }
}


- (void)setRightViewController:(UIViewController *)rightViewController
{
    if (_rightViewController != rightViewController) {
        if (_rightViewController) {
            [_rightViewController removeFromParentViewController];
        }
        _rightViewController = rightViewController;
        if (_rightViewController) {
            [self addChildViewController:_rightViewController];
        }
    }
}


- (void)setNeedSwipeShowMenu:(BOOL)needSwipeShowMenu
{
    _needSwipeShowMenu = needSwipeShowMenu;
    if (needSwipeShowMenu) {
        [_baseView addGestureRecognizer:_panGestureRecognizer];
    } else {
        [_baseView removeGestureRecognizer:_panGestureRecognizer];
    }
}


- (void)showShadow:(BOOL)show
{
    _currentView.layer.shadowOpacity = show ? .8f : .0f;
    
    if (show) {
        _currentView.layer.cornerRadius = 4.0f;
        _currentView.layer.shadowOffset = CGSizeZero;
        _currentView.layer.shadowRadius = 4.0f;
        _currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
}


- (void)resetCurrentViewToRootViewController
{
    if (_currentView != _rootViewController.view) {
        CGRect frame = CGRectZero;
        CGAffineTransform transform = CGAffineTransformIdentity;
        
        if (!_currentView) {
            frame = _baseView.bounds;
        } else {
            frame = _currentView.frame;
            transform = _currentView.transform;
        }
        
        [_currentView removeFromSuperview];
        _currentView = _rootViewController.view;
        [_baseView addSubview:_currentView];
        _currentView.transform = transform;
        _currentView.frame = frame;
        if (_leftViewController.view.superview || _rightViewController.view.superview) {
            [_currentView addSubview:_coverButton];
            [self showShadow:_showBoundsShadow];
        }
            
    }
}


- (void)willShowLeftViewController
{
    if (!_leftViewController || _leftViewController.view.superview) {
        return;
    }
    _leftViewController.view.frame = _baseView.bounds;
    [_baseView insertSubview:_leftViewController.view belowSubview:_currentView];
    if (_rightViewController && _rightViewController.view.superview) {
        [_rightViewController.view removeFromSuperview];
    }
}


- (void)willShowRightViewController
{
    if (!_rightViewController || _rightViewController.view.superview) {
        return;
    }
    _rightViewController.view.frame = _baseView.bounds;
    [_baseView insertSubview:_rightViewController.view belowSubview:_currentView];
    if (_leftViewController && _leftViewController.view.superview) {
        [_leftViewController.view removeFromSuperview];
    }
}

#pragma mark - 显示左抽屉方法
- (void)showLeftViewController:(BOOL)animated
{
    if (!_leftViewController) {
        return;
    }
    [self willShowLeftViewController];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_leftViewShowWidth - _currentView.frame.origin.x
                           ) / _leftViewShowWidth * _animationDuration;
    }
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:_leftViewShowWidth];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
    }];
}

#pragma mark - 显示右抽屉效果
- (void)showrightViewController:(BOOL)animated
{
    if (!_rightViewController) {
        return;
    }
    [self willShowRightViewController];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_rightViewShowWidth + _currentView.frame.origin.x) / _rightViewShowWidth * _animationDuration;
    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:-_rightViewShowWidth];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
    }];

}

#pragma mark - 隐藏抽屉效果动画
- (void)hideSideViewController:(BOOL)animated{
    [self showShadow:false];
    NSTimeInterval animatedTime = 0.4;
    if (animated) {
        animatedTime = ABS(_currentView.frame.origin.x / (_currentView.frame.origin.x>0?_leftViewShowWidth:_rightViewShowWidth)) * _animationDuration;
    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:0];
    } completion:^(BOOL finished) {
        [_coverButton removeFromSuperview];
        [_leftViewController.view removeFromSuperview];
        [_rightViewController.view removeFromSuperview];
    }];
}
- (void)hideSideViewController{
    [self hideSideViewController:true];
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // Check for horizontal pan gesture
    if (gestureRecognizer == _panGestureRecognizer) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:_baseView];
        if ([panGesture velocityInView:_baseView].x < 600 && ABS(translation.x)/ABS(translation.y)>1) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)pan:(UIPanGestureRecognizer*)pan{
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _startPanPoint=_currentView.frame.origin;
        if (_currentView.frame.origin.x == 0) {
            [self showShadow:_showBoundsShadow];
        }
        CGPoint velocity = [pan velocityInView:_baseView];
        if(velocity.x > 0){
            if (_currentView.frame.origin.x >= 0 && _leftViewController && !_leftViewController.view.superview) {
                [self willShowLeftViewController];
            }
        }else if (velocity.x < 0) {
            if (_currentView.frame.origin.x <= 0 && _rightViewController && !_rightViewController.view.superview) {
                [self willShowRightViewController];
            }
        }
        return;
    }
    CGPoint currentPostion = [pan translationInView:_baseView];
    CGFloat xoffset = _startPanPoint.x + currentPostion.x;
    if (xoffset > 0) {//向右滑
        if (_leftViewController && _leftViewController.view.superview) {
            xoffset = xoffset > _leftViewShowWidth ? _leftViewShowWidth:xoffset;
        }else{
            xoffset = 0;
        }
    }else if(xoffset < 0){//向左滑
        if (_rightViewController && _rightViewController.view.superview) {
            xoffset = xoffset < -_rightViewShowWidth ? -_rightViewShowWidth:xoffset;
        }else{
            xoffset = 0;
        }
    }
    if (xoffset != _currentView.frame.origin.x) {
        [self layoutCurrentViewWithOffset:xoffset];
    }
    if (_panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_currentView.frame.origin.x == 0) {
            [self showShadow:false];
        }else{
            if (_panMovingRightOrLeft && _currentView.frame.origin.x > 20) {
                [self showLeftViewController:true];
            }else if(!_panMovingRightOrLeft && _currentView.frame.origin.x < -20){
                [self showrightViewController:true];
            }else{
                [self hideSideViewController];
            }
        }
        _lastPanPoint = CGPointZero;
    }else {
        CGPoint velocity = [pan velocityInView:_baseView];
        if (velocity.x > 0) {
            _panMovingRightOrLeft = true;
        }else if(velocity.x < 0){
            _panMovingRightOrLeft = false;
        }
    }
}

//重写此方法可以改变动画效果,PS._currentView就是RootViewController.view
- (void)layoutCurrentViewWithOffset:(CGFloat)xoffset{
    if (_showBoundsShadow) {
        _currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
    if (self.rootViewMoveBlock) {//如果有自定义动画，使用自定义的效果
        self.rootViewMoveBlock(_currentView,_baseView.bounds,xoffset);
        return;
    }
    
    // 平移的动画
     [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y, _baseView.frame.size.width, _baseView.frame.size.height)];
     return;
    
     
    /* 平移带缩放效果的动画
    static CGFloat h2w = 0;
    if (h2w==0) {
        h2w = _baseView.frame.size.height/_baseView.frame.size.width;
    }
    CGFloat scale = ABS(600 - ABS(xoffset)) / 600;
    scale = MAX(0.8, scale);
    _currentView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat totalWidth=_baseView.frame.size.width;
    CGFloat totalHeight=_baseView.frame.size.height;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        totalHeight=_baseView.frame.size.width;
        totalWidth=_baseView.frame.size.height;
    }
    
    if (xoffset>0) {//向右滑的
        [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
    }else{//向左滑的
        [_currentView setFrame:CGRectMake(_baseView.frame.size.width * (1 - scale) + xoffset, _baseView.bounds.origin.y + (totalHeight*(1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
    }
    */
//    // 平移的动画
//     [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y, _baseView.frame.size.width, _baseView.frame.size.height)];
//     return;
    
    
    //平移带缩放效果的动画
//    static CGFloat h2w = 0;
//    if (h2w==0) {
//        h2w = _baseView.frame.size.height/_baseView.frame.size.width;
//    }
//    CGFloat scale = ABS(600 - ABS(xoffset)) / 600;
//    scale = MAX(0.8, scale);
//    _currentView.transform = CGAffineTransformMakeScale(scale, scale);
//    
//    CGFloat totalWidth=_baseView.frame.size.width;
//    CGFloat totalHeight=_baseView.frame.size.height;
//    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
//        totalHeight=_baseView.frame.size.width;
//        totalWidth=_baseView.frame.size.height;
//    }
    
//    if (xoffset>0) {//向右滑的
//        [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
//    }else{//向左滑的
//        [_currentView setFrame:CGRectMake(_baseView.frame.size.width * (1 - scale) + xoffset, _baseView.bounds.origin.y + (totalHeight*(1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
//    }
    //
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
