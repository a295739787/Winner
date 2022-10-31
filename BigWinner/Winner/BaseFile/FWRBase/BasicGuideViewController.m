//
//  BasicGuideViewController.m
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import "BasicGuideViewController.h"
#import "LLTabbarViewController.h"

@interface BasicGuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_guidePageSL;//滚动视图
}


@end

@implementation BasicGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showGuidePage];
}

#pragma mark - 引导页
- (void)showGuidePage
{
    NSArray * guidePageArray = [NSArray arrayWithObjects:@"1",@"2",@"3",nil];
    _guidePageSL = [[UIScrollView alloc]init];
    _guidePageSL.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _guidePageSL.contentSize = CGSizeMake(SCREEN_WIDTH * (guidePageArray.count),SCREEN_HEIGHT);
    _guidePageSL.delegate = self;
    _guidePageSL.pagingEnabled = YES;
    _guidePageSL.bounces = NO;
    _guidePageSL.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < guidePageArray.count; i++)
    {
        UIImageView * imageGuidePage = [[UIImageView alloc]init];
        imageGuidePage.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageGuidePage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",guidePageArray[i]]];
        [_guidePageSL addSubview:imageGuidePage];
        if (i==2) {
            imageGuidePage.userInteractionEnabled = YES;
            UIButton * accessBtn = [UIButton buttonWithTitle:@"" atTitleSize:15 atTitleColor:White_Color atTarget:self atAction:@selector(clickAccess)];
            [accessBtn setBackgroundColor:[UIColor clearColor]];
            accessBtn.layer.cornerRadius = 5;
            accessBtn.layer.masksToBounds = YES;
            [imageGuidePage addSubview:accessBtn];
            
            [accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.offset(CGFloatBasedI375(0));
                make.centerX.equalTo(imageGuidePage.mas_centerX);
                make.width.offset(160);
                make.height.offset(88);
            }];
        }
    }
    [self.view addSubview:_guidePageSL];
    
}

- (void)clickAccess{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate loginMainVc];
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
