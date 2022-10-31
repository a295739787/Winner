//
//  LLPersonalHeaderView.m
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import "LLPersonalHeaderView.h"

@interface LLPersonalHeaderView ()

@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UIImageView *noteImgView;

@end

@implementation LLPersonalHeaderView

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
    
    self.backgroundColor = UIColorFromRGB(0xF0EFED);
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    [self.bottomView addSubview:self.headerImgView];
    [self.bottomView  addSubview:self.noteImgView];
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.centerX.mas_equalTo(self.bottomView);
        make.width.height.mas_equalTo(CGFloatBasedI375(60));
    }];
    
    [self.noteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.headerImgView);
        make.width.height.mas_equalTo(CGFloatBasedI375(16));
    }];
    
}

-(void)setHeaderImgStr:(NSString *)headerImgStr{
    [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@",headerImgStr) placeholderImage:[UIImage imageNamed:morentouxiang]];
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
        _headerImgView.backgroundColor = [UIColor whiteColor];
        _headerImgView.layer.cornerRadius = CGFloatBasedI375(30);
        _headerImgView.clipsToBounds = YES;
        _headerImgView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        [_headerImgView addGestureRecognizer:tap];
      
    }
    return _headerImgView;
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    
}
-(UIImageView *)noteImgView{
    if (!_noteImgView) {
        _noteImgView = [[UIImageView alloc]init];
        _noteImgView.backgroundColor = [UIColor clearColor];
        _noteImgView.image = [UIImage imageNamed:@"bj"];
        _noteImgView.userInteractionEnabled = YES;
    }
    return _noteImgView;
}


@end
