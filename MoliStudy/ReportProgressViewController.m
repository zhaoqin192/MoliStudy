//
//  ReportProgressViewController.m
//  
//
//  Created by 张鹏 on 15/10/9.
//
//

#import "ReportProgressViewController.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressLabel.h"
#import "MDRadialProgressTheme.h"

@interface ReportProgressViewController ()

@end

@implementation ReportProgressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
    
    [self addViews];
    
}

- (void)addViews
{
    
        CGFloat radialX = 29;
        CGFloat radialY = 30;
        CGFloat radialWidth = 60;
        CGFloat radialHeight = 60;
    
        for (NSInteger i = 0; i < _socreArray.count; i++) {
    
            MDRadialProgressView *radialView = [[MDRadialProgressView alloc] init];
            radialView.progressTotal = 100;
            radialView.progressCounter = [_socreArray[i] intValue];
            radialView.theme.thickness = 15;
            radialView.theme.incompletedColor = [UIColor colorWithHexString:@"ADD8E6" alpha:1.0];
            radialView.theme.completedColor = [UIColor yellowColor];
            radialView.theme.sliceDividerHidden = YES;
            radialView.label.hidden = YES;
    
            CGFloat bX=i%4* (radialWidth+radialX)+radialX;
            CGFloat bY=i/4* (radialHeight+radialY)+80/667. *ScreenHeight;
    
            radialView.frame = CGRectMake(bX, bY, radialWidth, radialHeight);
            
            [self.view addSubview:radialView];
            
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.frame = CGRectMake(bX + 20, bY + 20/667. *ScreenHeight, 30/375. *ScreenWidth, 20/667. *ScreenHeight);
            [self setLabel:nameLabel];
            nameLabel.text = _nameArray[i];
            
            
            UILabel *scoreLabel = [[UILabel alloc] init];
            scoreLabel.frame = CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), CGRectGetWidth(nameLabel.frame), 10/667. *ScreenHeight);
            
            if ([NSString stringWithFormat:@"%@", _socreArray[i]].length > 4 ) {
                
            scoreLabel.text = [[NSString stringWithFormat:@"%@", _socreArray[i]] substringWithRange:NSMakeRange(0, 4)];
                
            } else{
            
            scoreLabel.text = [NSString stringWithFormat:@"%@", _socreArray[i]];
                
            }
            
            [self setLabel:scoreLabel];
        }
    
}

- (UILabel *)setLabel:(UILabel *)label {
    
    label.textColor =[UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:8];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    return label;
    
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
