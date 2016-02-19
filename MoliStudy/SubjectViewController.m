//
//  SubjectViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 2/18/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "SubjectViewController.h"

@interface SubjectViewController ()
@property (weak, nonatomic) IBOutlet UITextView *mainView;
@property (weak, nonatomic) IBOutlet UIView *requestButton;

@property (nonatomic, strong) Subject *subject0;


@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView) name:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
    
    [NetworkManager getQuestion:@"3" viewID:@"101"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentNote:)];
    [self.requestButton addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)presentView{
    NSArray *array = [[SubjectDAO sharedManager] findAll];
    self.subject0 = array[0];
    
    //content
    NSString *str = @"";
    for (NSString *string in self.subject0.content){
        str = [str stringByAppendingString:string];
        str = [str stringByAppendingString:@" "];
    }
    
    str = [str stringByAppendingString:@"\n"];
    //answer
    for (int i = 0; i < self.subject0.answers.count; i++){
        switch (i) {
            case 0:
                str = [str stringByAppendingString:@"A "];
                break;
            case 1:
                str = [str stringByAppendingString:@"B "];
                break;
            case 2:
                str = [str stringByAppendingString:@"C "];
                break;
            case 3:
                str = [str stringByAppendingString:@"D "];
                break;
            case 4:
                str = [str stringByAppendingString:@"E "];
                break;
            case 5:
                str = [str stringByAppendingString:@"F "];
            default:
                break;
        }
        str = [str stringByAppendingString:self.subject0.answers[i]];
        str = [str stringByAppendingString:@"\n"];
        
    }
    
    self.mainView.text = str;
    self.mainView.font = [UIFont fontWithName:@"Arial" size:18.0];
    
    [self messageHighlight:self.mainView startPosition:self.subject0.content[1] endPosition:self.subject0.content[5]];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)messageHighlight:(UITextView *)textView startPosition:(NSString *)start endPosition:(NSString *)end{
    NSString *tempStr = textView.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [strAtt length])];
    
    //the range between start and end
    NSRange tempRange = [tempStr rangeOfString:start];
    NSRange tempRangeOne = [tempStr rangeOfString:end];
    //change character color
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(tempRange.location, tempRangeOne.location-(tempRange.location+1))];
    [strAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(tempRange.location, tempRangeOne.location-(tempRange.location+1))];
    
//    change font
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16] range:NSMakeRange(0, [strAtt length])];
    textView.attributedText = strAtt;
}

- (void)presentNote:(UITapGestureRecognizer *)recognizer{
//    if ([self.noteView isHidden]) {
//        self.noteView.hidden = false;
//    }else{
//        self.noteView.hidden = true;
//    }
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
