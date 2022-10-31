//
//  LLPersonalTableCell.m
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import "LLPersonalTableCell.h"

@interface LLPersonalTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contextLabel;
@property (nonatomic,strong)UIImageView *nextImg;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLPersonalTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contextLabel];
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.line];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(10));
            
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setTextStr:(NSString *)textStr{
    _titleLabel.text = textStr;
}
-(void)setContextStr:(NSString *)contextStr{
    _contextStr = contextStr;
    _contextLabel.text = contextStr;
    if ([contextStr isEqualToString:@"未实名"]) {
        _contextLabel.textColor = UIColorFromRGB(0xD40006);
    }
}
-(void)setIndex:(NSInteger)index{
    if (index == 1) {
        _nextImg.hidden = YES;
    }else{
        if (index == 2) {
            if ([_contextStr isEqualToString:@"未实名"]) {
                _nextImg.hidden = NO;
            }else{
                _nextImg.hidden = YES;
            }
        }else{
            _nextImg.hidden = NO;
        }
    }
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
-(UILabel *)contextLabel{
    if (!_contextLabel) {
        _contextLabel = [[UILabel alloc]init];
        _contextLabel.textColor = UIColorFromRGB(0x666666);
        _contextLabel.textAlignment = NSTextAlignmentCenter;
        _contextLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _contextLabel;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

@end


@interface LLPersonalBankTableCell ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation LLPersonalBankTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nextImg];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(CGFloatBasedI375(24));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgView);
        make.left.mas_equalTo(self.imgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
}
#pragma mark--lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.image = [UIImage imageNamed:@"upload_yhk"];
    }
    return _imgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"添加银行卡";
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



@interface LLCertificationTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;

@end

@implementation LLCertificationTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
}
-(void)setTextStr:(NSString *)textStr{
    _titleLabel.text = textStr;
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _textField.placeholder = placeholderStr;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
}

#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    
    if (self.centificationBlock) {
        self.centificationBlock(_index, textField.text);
    }
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end



@interface LLAddBankCardTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *codeBtn;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation LLAddBankCardTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.codeBtn];
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.rightLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-25));
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-118));
        make.width.mas_equalTo(CGFloatBasedI375(90));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
//    -(void)jk_startTime:(NSInteger )timeout waitTittle:(NSString *)waitTittle;
}
-(void)setTextStr:(NSString *)textStr{
    _titleLabel.text = textStr;
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _textField.placeholder = placeholderStr;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (index == 0) {
        _textField.keyboardType = UIKeyboardTypeDefault;
    }else if(index == 1){
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
    }else{
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (index == 5) {
        self.codeBtn.hidden = NO;
    }else{
        self.codeBtn.hidden = YES;
    }
    
    if (_index == 2) {
        _textField.hidden = YES;
        _rightLabel.hidden = NO;
        _nextImg.hidden = NO;
    }else{
        _textField.hidden = NO;
        _rightLabel.hidden = YES;
        _nextImg.hidden = YES;
    }
}
-(void)textFieldChange:(UITextField *)textField{

    if (self.bankCardBlock) {
        self.bankCardBlock(_index, textField.text);
    }
}
#pragma mark--codeBtnClick
-(void)codeBtnClick:(UIButton *)btn{
    if (self.sendCodeBtnBlock) {
        self.sendCodeBtnBlock(btn);
    }
}
-(void)setBankName:(NSString *)bankName{
    _bankName = bankName;
    
    if ([_bankName length] <= 0) {
        _rightLabel.text = @"请选择银行卡";
        _rightLabel.textColor = UIColorFromRGB(0xC5C5C5);
    }else{
        _rightLabel.text = _bankName;
        _rightLabel.textColor =  UIColorFromRGB(0x443415);
    }
}
#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(UIButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.backgroundColor = [UIColor whiteColor];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        [_codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _codeBtn.clipsToBounds = YES;
        _codeBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _codeBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _codeBtn;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0xC5C5C5);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = @"请选择银行卡名称";
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _rightLabel;
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


@interface LLMeBankCardTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *imgView;
@property (nonatomic,strong)UIImageView *bankImg;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *numberLabel;

@end

@implementation LLMeBankCardTableCell

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
    [self.contentView addSubview:self.imgView];
    [self.imgView addSubview:self.bankImg];
    [self.imgView addSubview:self.nameLabel];
    [self.imgView addSubview:self.numberLabel];
    
    [self.titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.bankImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgView);
        make.left.mas_equalTo(CGFloatBasedI375(20));
        make.width.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    
    [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(75));
        make.top.mas_equalTo(self.bankImg);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(75));
        make.bottom.mas_equalTo(self.bankImg);
    }];
    
}
-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    
    _nameLabel.text = personalModel.bankName;
    _numberLabel.text = personalModel.bankCardNum;
    if(personalModel.bankCardNum.length >= 19){
        NSString *numberString = [personalModel.bankCardNum stringByReplacingCharactersInRange:NSMakeRange(4, 11) withString:@" **** **** **** "];
        _numberLabel.text = numberString;
        
    }

}

#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _titleLabel.text = @"我的银行卡";
    }
    return _titleLabel;
}
-(UIView *)imgView{
    if (!_imgView) {
        _imgView = [[UIView alloc]init];
        _imgView.backgroundColor = UIColorFromRGB(0xDE464A);
        _imgView.layer.cornerRadius = CGFloatBasedI375(5);
        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}
-(UIImageView *)bankImg{
    if (!_bankImg) {
        _bankImg = [[UIImageView alloc]init];
        _bankImg.image = [UIImage imageNamed:@"icon_bank"];
    }
    return _bankImg;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
    }
    return _nameLabel;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
    }
    return _numberLabel;
}


@end
