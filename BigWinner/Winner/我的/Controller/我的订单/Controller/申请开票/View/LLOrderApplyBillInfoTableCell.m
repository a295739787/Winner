//
//  LLOrderApplyBillInfoTableCell.m
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import "LLOrderApplyBillInfoTableCell.h"

@interface LLOrderApplyBillInfoTableCell ()

@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *numberText;
@property (nonatomic,strong)UILabel *billMoneyLabel;
@property (nonatomic,strong)UILabel *moneyLabel;

@end

@implementation LLOrderApplyBillInfoTableCell

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
    
    [self.contentView addSubview:self.goodsImgView];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.numberText];
    [self.contentView addSubview:self.billMoneyLabel];
    [self.contentView addSubview:self.moneyLabel];
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImgView);
        make.left.mas_equalTo(self.goodsImgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.numberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLabel);
        make.left.mas_equalTo(self.numberLabel.mas_right).offset(0);
    }];
    
    [self.billMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodsImgView);
        make.left.mas_equalTo(self.goodsImgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.billMoneyLabel);
        make.left.mas_equalTo(self.billMoneyLabel.mas_right).offset(0);
    }];
}
-(void)setOrderNo:(NSString *)orderNo{
//    _numberText.text = orderNo;
}

-(void)setBillModel:(LLMeOrderListModel *)billModel{
    _billModel = billModel;
    LLMeOrderListModel *model = [_billModel.appOrderListGoodsVos firstObject];
    NSString *invoicePrice = _billModel.actualPrice;
    NSLog(@"----44444--------%@",invoicePrice);
    _moneyLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",invoicePrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[UIColorFromRGB(0xD40006), UIColorFromRGB(0xD40006)]];
    [self.goodsImgView  sd_setImageWithUrlString:FORMAT(@"%@",model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    _numberText.text = _billModel.orderNo;;

}

#pragma mark--lazy
-(UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc]init];
    }
    return _goodsImgView;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0x443415);
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _numberLabel.text = @"订单编号：";
    }
    return _numberLabel;
}
-(UILabel *)numberText{
    if (!_numberText) {
        _numberText = [[UILabel alloc]init];
        _numberText.textColor = UIColorFromRGB(0x443415);
        _numberText.textAlignment = NSTextAlignmentLeft;
        _numberText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _numberText.text = @"";
    }
    return _numberText;
}
-(UILabel *)billMoneyLabel{
    if (!_billMoneyLabel) {
        _billMoneyLabel = [[UILabel alloc]init];
        _billMoneyLabel.textColor = UIColorFromRGB(0x443415);
        _billMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _billMoneyLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _billMoneyLabel.text = @"开票金额：";
    }
    return _billMoneyLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = UIColorFromRGB(0x443415);
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _moneyLabel.text = @"大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒";
    }
    return _moneyLabel;
}

@end



@interface LLOrderApplyBillSelectTableCell ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIImageView *nextImgView;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIButton *setDefaultBtn;

@end

@implementation LLOrderApplyBillSelectTableCell

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
    
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.nextImgView];
    [self.contentView addSubview:self.setDefaultBtn];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(5));
    }];

    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-30));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.setDefaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(44));
        make.height.mas_equalTo(CGFloatBasedI375(24));
    }];
    
    _setDefaultBtn.hidden = YES;
    _rightLabel.hidden = YES;
    _nextImgView.hidden = YES;
    
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftLabel.text = leftStr;
}
-(void)setRightStr:(NSString *)rightStr{
    
    _rightStr = rightStr;
    
    if (_indexRow == 0) {
        _rightLabel.text = [rightStr intValue] == 1 ? @"增值税电子普通发票" :@"增值税专用发票";
    }else if (_indexRow == 1){
        _rightLabel.text = [rightStr intValue] == 1 ? @"个人/非企业单位" :@"企业单位";
    }else if (_indexRow == 2){
        _rightLabel.text = rightStr;
    }else{
        
        if ([rightStr intValue] == 0) {
            _setDefaultBtn.selected = NO;
            [_setDefaultBtn setImage:[UIImage imageNamed:@"button_close"] forState:UIControlStateNormal];
        }else{
            _setDefaultBtn.selected = YES;
            [_setDefaultBtn setImage:[UIImage imageNamed:@"button_open"] forState:UIControlStateNormal];
        }
    }
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    if (_indexRow == 3) {
        _setDefaultBtn.hidden = NO;
        
        _rightLabel.hidden = YES;
        _nextImgView.hidden = YES;
    }else{
        
        _setDefaultBtn.hidden = YES;
        
        _rightLabel.hidden = NO;
        _nextImgView.hidden = NO;
    }
}

#pragma mark--setDefaultBtnClick
-(void)setDefaultBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (self.LLOrderBillSelelctBtnBlock) {
        self.LLOrderBillSelelctBtnBlock(btn.selected);
    }
}

#pragma mark--lazy
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _leftLabel.text = @"";
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x443415);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _rightLabel.text = @"";
    }
    return _rightLabel;
}
-(UIImageView *)nextImgView{
    if (!_nextImgView) {
        _nextImgView = [[UIImageView alloc]init];
        _nextImgView.backgroundColor = [UIColor whiteColor];
        _nextImgView.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImgView;
}
-(UIButton *)setDefaultBtn{
    if (!_setDefaultBtn) {
        _setDefaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setDefaultBtn.backgroundColor = [UIColor whiteColor];
        _setDefaultBtn.selected = NO;
        [_setDefaultBtn setImage:[UIImage imageNamed:@"button_close"] forState:UIControlStateNormal];
        [_setDefaultBtn addTarget:self action:@selector(setDefaultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setDefaultBtn;
}


@end


@interface LLOrderApplyBillInfoStatusTableCell ()

@property (nonatomic,strong)UIImageView *topImgView;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *noteLabel;


@end

@implementation LLOrderApplyBillInfoStatusTableCell

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
    
    [self.contentView addSubview:self.topImgView];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.noteLabel];
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(CGFloatBasedI375(40));
        make.width.mas_equalTo(CGFloatBasedI375(71));
        make.height.mas_equalTo(CGFloatBasedI375(63));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.topImgView.mas_bottom).offset(CGFloatBasedI375(20));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
}
-(void)setBillModel:(LLOrderApplyBillModel *)billModel{
    
    if ([billModel.invoiceStatus intValue] == 2) {
        //开票中
        _topImgView.image = [UIImage imageNamed:@"kpz"];
        _statusLabel.text = @"开票中";
        _noteLabel.text = @"财务正在审核中，请耐心等待";
    }else if([billModel.invoiceStatus intValue] == 3){
        //已开票
        _topImgView.image = [UIImage imageNamed:@"zfcg"];
        _statusLabel.text = @"开票成功";
        _noteLabel.text = @"请到接收邮箱中查看发票";
    }else{
        _topImgView.image = [UIImage imageNamed:@""];
        _statusLabel.text = @"";
        _noteLabel.text = @"";
    }
}

#pragma mark---alzy
-(UIImageView *)topImgView{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc]init];
        _topImgView.backgroundColor = [UIColor whiteColor];
    }
    return _topImgView;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.textColor = UIColorFromRGB(0x443415);
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(18)];
        _statusLabel.text = @"";
    }
    return _statusLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x999999);
        _noteLabel.textAlignment = NSTextAlignmentRight;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _noteLabel.text = @"";
    }
    return _noteLabel;
}

@end



@interface LLOrderApplyBillListTableCell ()

@property (nonatomic,strong)UILabel *leftlabel;
@property (nonatomic,strong)UILabel *rightLabel;


@end

@implementation LLOrderApplyBillListTableCell

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
    
    [self.contentView addSubview:self.leftlabel];
    [self.contentView addSubview:self.rightLabel];
    
    [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftlabel.text = leftStr;
}
-(void)setRightStr:(NSString *)rightStr{
    _rightLabel.text = rightStr;
}

-(UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel = [[UILabel alloc]init];
        _leftlabel.textColor = UIColorFromRGB(0x443415);
        _leftlabel.textAlignment = NSTextAlignmentLeft;
        _leftlabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _leftlabel.text = @"";
    }
    return _leftlabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x443415);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _rightLabel.text = @"";
    }
    return _rightLabel;
}


@end
