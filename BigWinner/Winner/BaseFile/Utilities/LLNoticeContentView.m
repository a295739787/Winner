//
//  SFNoCententView.m
//  SocialFinance
//
//  Created by 杨波 on 2018/7/9.
//  Copyright © 2018年 ebenny. All rights reserved.
//

#import "LLNoticeContentView.h"
@interface LLNoticeContentView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel *bottomLabel;

@end

@implementation LLNoticeContentView

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
            self.backgroundColor = [UIColor clearColor];
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];
    
    //------- 图片 -------//
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    //------- 内容描述 -------//
    self.topLabel = [[UILabel alloc]init];
    [self addSubview:self.topLabel];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.font = [UIFont systemFontOfSize:15];
    self.topLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
    //------- 提示点击重新加载 -------//
    self.bottomLabel = [[UILabel alloc]init];
    [self addSubview:self.bottomLabel];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.font = [UIFont systemFontOfSize:15];
    self.bottomLabel.textColor = [UIColor colorWithHexString:@"484848"];
    
    //------- 建立约束 -------//
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_greaterThanOrEqualTo(0);
        make.centerY.mas_offset(-100).priority(MASLayoutPriorityDefaultLow);
//        make.size.mas_equalTo(CGSizeMake(CGFloatBasedI375(214), CGFloatBasedI375(160)));
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
        make.left.mas_offset(80);
        make.right.mas_offset(-80);
        make.height.mas_equalTo(40);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom).mas_offset(5);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    
}

#pragma mark - 根据传入的值创建相应的UI
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    
}
-(void)setNoticeName:(NSString *)noticeName{
    _noticeName = noticeName;
    
}
/** 根据传入的值创建相应的UI */
- (void)setType:(NSInteger)type{
    switch (type) {
            
        case 0: // 没网
        {
            [self setImage:_imageName topLabelText:@"貌似没有网络" bottomLabelText:@""];
        }
            break;
            
        case 1:
        {
            [self setImage:_imageName topLabelText:_noticeName bottomLabelText:@""];
        }
            break;
        case 2:
        {
            [self setImage:_imageName topLabelText:_noticeName bottomLabelText:@""];
        }
            break;
        case 3:
        {
            [self setImage:_imageName topLabelText:_noticeName bottomLabelText:@""];
        }
            break;
        case 4:
        {
            [self setImage:_imageName topLabelText:_noticeName bottomLabelText:@""];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置图片和文字
/** 设置图片和文字 */
- (void)setImage:(NSString *)imageName topLabelText:(NSString *)topLabelText bottomLabelText:(NSString *)bottomLabelText{
    self.imageView.image =[UIImage imageNamed:imageName];
    self.topLabel.text = self.noticeName;
    self.topLabel.numberOfLines = 2;
    self.bottomLabel.text = bottomLabelText;
}


@end
