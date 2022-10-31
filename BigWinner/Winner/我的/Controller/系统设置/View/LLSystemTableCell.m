//
//  LLSystemTableCell.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLSystemTableCell.h"

@interface LLSystemTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation LLSystemTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nextImg];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(5));
    }];
    
}
-(void)setTextStr:(NSString *)textStr{
    _titleLabel.text = textStr;
}
#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
}


@end






@interface LLFeedbackSuccessTableCell ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIButton *closeBtn;

@end

@implementation LLFeedbackSuccessTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.noteLabel];
    [self.contentView addSubview:self.closeBtn];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(40));
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(70));
        make.height.mas_equalTo(CGFloatBasedI375(63));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(CGFloatBasedI375(20));
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noteLabel.mas_bottom).offset(CGFloatBasedI375(20));
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];

}
#pragma mark--closeBtnClick
-(void)closeBtnClick:(UIButton *)btn{
    if (self.LLFeedBackcancleBtnBlock) {
        self.LLFeedBackcancleBtnBlock();
    }
}
#pragma mark--lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.image = [UIImage imageNamed:@"zfcg"];
    }
    return _imgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(18)];
        _titleLabel.text = @"感谢您的反馈";
    }
    return _titleLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x999999);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _noteLabel.text = @"我们一直在努力为您带来更好的体验";
    }
    return _noteLabel;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.backgroundColor = [UIColor whiteColor];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _closeBtn.layer.borderWidth = 1;
        _closeBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _closeBtn.clipsToBounds = YES;
    }
    return _closeBtn;
}

@end
