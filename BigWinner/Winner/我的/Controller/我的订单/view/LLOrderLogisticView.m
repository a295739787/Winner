//
//  LLOrderLogisticView.m
//  Winner
//
//  Created by YP on 2022/1/26.
//

#import "LLOrderLogisticView.h"

@interface LLOrderLogisticView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UILabel *companyLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@end

@implementation LLOrderLogisticView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.bottom.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    [self.bottomView addSubview:self.stateLabel];
    [self.bottomView addSubview:self.companyLabel];
    [self.bottomView addSubview:self.numberLabel];
    [self.bottomView addSubview:self.timeLabel];
    
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(6));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.stateLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.companyLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.numberLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = UIColorFromRGB(0x443415);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _stateLabel.text = @"物流状态：已签收";
    }
    return _stateLabel;
}
-(UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc]init];
        _companyLabel.textColor = UIColorFromRGB(0x443415);
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _companyLabel.text = @"承运公司：中通快递";
    }
    return _companyLabel;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0x443415);
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _numberLabel.text = @"快递编号：ZT1856568566999";
    }
    return _numberLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = UIColorFromRGB(0x443415);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _timeLabel.text = @"发货时间：2020-09-19  12:10:07";
    }
    return _timeLabel;
}

@end
