//
//  LLAboutMeView.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "LLAboutMeView.h"

@interface LLAboutMeView ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation LLAboutMeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(CGFloatBasedI375(40));
//        make.height.mas_equalTo(CGFloatBasedI375(85));
//        make.width.mas_equalTo(CGFloatBasedI375(70));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(CGFloatBasedI375(20));
    }];
}
#pragma mark--lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.image = [UIImage imageNamed:@"syt_logo"];
    }
    return _imgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titleLabel.text = @"";
    }
    return _titleLabel;
}


@end
