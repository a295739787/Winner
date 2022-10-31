//
//  LLMeDeliverOrderFooterView.m
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import "LLMeDeliverOrderFooterView.h"

@interface LLMeDeliverOrderFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *leftlabel;
@property (nonatomic,strong)UILabel *stateLabel;

@end

@implementation LLMeDeliverOrderFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createrUI];
    }
    return self;
}
#pragma mark--createrUI
-(void)createrUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.leftlabel];
    [self.bottomView addSubview:self.stateLabel];
    
    [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(CGFloatBasedI375(17));
    }];
    
//    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.bottomView);
//        make.left.mas_equalTo(self.leftlabel.mas_right).offset(0);
//    }];
}

-(void)setModel:(LLMeOrderListModel *)model{
    _model = model;
    if(_model.isTimeout){
        self.leftlabel.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"当日%@分送达,",_model.completeTime),FORMAT(@"超时%@分钟",_model.timeoutTime)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(14)], [UIFont systemFontOfSize:CGFloatBasedI375(14)]] colors:@[ UIColorFromRGB(0x443415), Main_Color]];
    }else{
        _leftlabel.text = FORMAT(@"当日%@分送达，准时送达",_model.completeTime);
    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(44))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
-(UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel = [[UILabel alloc]init];
        _leftlabel.textColor = UIColorFromRGB(0x443415);
        _leftlabel.textAlignment = NSTextAlignmentCenter;
        _leftlabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];

    }
    return _leftlabel;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = UIColorFromRGB(0x443415);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _stateLabel.text = @"准时送达";
    }
    return _stateLabel;
}

@end


@interface LLMeDeliverOrderHeaderView ()


@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIImageView *noteImgView;
@property (nonatomic,strong)UIView *line;


@end

@implementation LLMeDeliverOrderHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createrUI];
    }
    return self;
}
#pragma mark--createrUI
-(void)createrUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    
    [self.bottomView addSubview:self.numberLabel];
    [self.bottomView addSubview:self.priceLabel];
    [self.bottomView addSubview:self.noteImgView];
    [self.bottomView addSubview:self.line];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.noteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.right.mas_equalTo(self.priceLabel.mas_left).offset(-4);
        make.width.height.mas_equalTo(CGFloatBasedI375(14));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setModel:(LLMeOrderListModel *)model{
    _model = model;
    
    _numberLabel.text = _model.stayTaskTime;
    NSLog(@"judgeTaskPrice == %@",_model.judgeTaskPrice);
    self.priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.judgeTaskPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];

}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), CGFloatBasedI375(10), SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(44))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0x443415);
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
  
    }
    return _numberLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0xD40006);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
 
    }
    return _priceLabel;
}
-(UIImageView *)noteImgView{
    if (!_noteImgView) {
        _noteImgView = [[UIImageView alloc]init];
        _noteImgView.backgroundColor = [UIColor whiteColor];
        _noteImgView.image = [UIImage imageNamed:@"yj"];
    }
    return _noteImgView;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}


@end
