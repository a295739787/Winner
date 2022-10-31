//
//  LLMeAdressTableCell.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeAdressTableCell.h"

@interface LLMeAdressTableCell ()

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UIView *defaultView;
@property (nonatomic,strong)UILabel *defaultLabel;
@property (nonatomic,strong)UILabel *adressLabel;
@property (nonatomic,strong)UILabel *adressDetailLabel;
@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLMeAdressTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.adressLabel];
    [self.contentView addSubview:self.adressDetailLabel];
    [self.contentView addSubview:self.defaultLabel];
//    [self.defaultView addSubview:self.defaultLabel];
    [self.contentView addSubview:self.editBtn];
    [self.contentView addSubview:self.line];
    WS(weakself);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(16));
        make.top.mas_equalTo(CGFloatBasedI375(14));
        make.width.mas_equalTo(CGFloatBasedI375(60));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel);
        make.left.equalTo(weakself.nameLabel.mas_right).mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.equalTo(weakself.nameLabel.mas_right).mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-50));
    }];
    
    [self.adressDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.adressLabel.mas_bottom).offset(3);
        make.left.equalTo(weakself.nameLabel.mas_right).mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-50));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    
//    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(12));
//        make.left.mas_equalTo(CGFloatBasedI375(15));
//    }];
    
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(12));
        make.centerX.equalTo(weakself.nameLabel.mas_centerX);
        make.width.mas_equalTo(CGFloatBasedI375(30));
        make.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
#pragma mark--editBtnClick
-(void)editBtnClick:(UIButton *)btn{
    if (self.editBlock) {
        self.editBlock();
    }
}

-(void)setListModel:(AdressListModel *)listModel{
    
    _nameLabel.text = listModel.receiveName;
    _phoneLabel.text = [NSString setPhoneMidHid:listModel.receivePhone];
    _adressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",listModel.province,listModel.city,listModel.area,listModel.locations];
    _adressDetailLabel.text = listModel.address;
    if (listModel.isDefault == YES) {
        _defaultView.hidden = NO;
        _defaultLabel.hidden = NO;
    }else{
        _defaultView.hidden = YES;
        _defaultLabel.hidden = YES;
    }
    
}

#pragma mark--lazy
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0x443415);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _nameLabel.text = @"吴小姐";
        _nameLabel.numberOfLines = 2;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = UIColorFromRGB(0x443415);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _phoneLabel.text = @"185****6666";
    }
    return _phoneLabel;
}
-(UILabel *)adressLabel{
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc]init];
        _adressLabel.textColor = UIColorFromRGB(0x999999);
        _adressLabel.textAlignment = NSTextAlignmentLeft;
        _adressLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _adressLabel.text = @"广东省广州市天河区";
        _adressLabel.numberOfLines = 0;
    }
    return _adressLabel;
}
-(UILabel *)adressDetailLabel{
    if (!_adressDetailLabel) {
        _adressDetailLabel = [[UILabel alloc]init];
        _adressDetailLabel.textColor = UIColorFromRGB(0x999999);
        _adressDetailLabel.textAlignment = NSTextAlignmentLeft;
        _adressDetailLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _adressDetailLabel.text = @"林和西路159号中泰北塔1501室";
        _adressDetailLabel.numberOfLines = 0;
    }
    return _adressDetailLabel;
}
-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.backgroundColor = [UIColor clearColor];
        [_editBtn setImage:[UIImage imageNamed:@"bjdz"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
-(UIView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[UIView alloc]init];
        _defaultView.backgroundColor = [UIColor whiteColor];
        _defaultView.layer.cornerRadius = CGFloatBasedI375(3);
        _defaultView.clipsToBounds = YES;
        _defaultView.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _defaultView.layer.borderWidth = 1;
    }
    return _defaultView;
}
-(UILabel *)defaultLabel{
    if (!_defaultLabel) {
        _defaultLabel = [[UILabel alloc]init];
        _defaultLabel.textColor = UIColorFromRGB(0xD40006);
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _defaultLabel.text = @"默认";
        _defaultLabel.layer.cornerRadius = CGFloatBasedI375(3);
        _defaultLabel.clipsToBounds = YES;
        _defaultLabel.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _defaultLabel.layer.borderWidth = 1;
    }
    return _defaultLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}


@end


@interface LLMeAdressEditTableCell ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIImageView *nextImg;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIButton *selectBtn;

@end

@implementation LLMeAdressEditTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.selectBtn];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(5));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-30));
        make.centerY.mas_equalTo(self.contentView);
        make.left.equalTo(self.leftLabel.mas_right).mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(44));
        make.height.mas_equalTo(CGFloatBasedI375(24));
    }];
    
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftLabel.text = leftStr;
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _textField.placeholder = placeholderStr;
    _rightLabel.text = placeholderStr;
    _rightLabel.textColor = UIColorFromRGB(0xC8C8C8);
}
-(void)setIndex:(NSInteger)index{
    
    _index = index;
    
    if (index == 0 || index == 1 || index == 3) {
        _textField.hidden = NO;
        _rightLabel.hidden = YES;
        _nextImg.hidden = YES;
        _selectBtn.hidden = YES;
        
        if (index == 1) {
            _textField.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            _textField.keyboardType = UIKeyboardTypeDefault;
        }
        
    }else if(index == 1 || index == 2){
        _textField.hidden = YES;
        _rightLabel.hidden = NO;
        _nextImg.hidden = NO;
        _selectBtn.hidden = YES;
        if(index == 1){
            _nextImg.hidden = YES;
        }
    }else{
        _textField.hidden = YES;
        _rightLabel.hidden = YES;
        _nextImg.hidden = YES;
        _selectBtn.hidden = NO;
    }
    
    
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    
    if (self.textFieldBlock) {
        self.textFieldBlock(_index, textField.text);
    }
}
#pragma mark--selectBtnBlock
-(void)selectBtnBlock:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [_selectBtn setImage:[UIImage imageNamed:@"button_open"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"button_close"] forState:UIControlStateNormal];
    }
    if (self.defaultBlock) {
        self.defaultBlock(btn.selected);
    }
}
-(void)setContentStr:(NSString *)contentStr{
    
    if (_index == 4) {
        
        if ([contentStr intValue] == 0) {
            _selectBtn.selected = NO;
            [_selectBtn setImage:[UIImage imageNamed:@"button_close"] forState:UIControlStateNormal];
        }else{
            _selectBtn.selected = YES;
            [_selectBtn setImage:[UIImage imageNamed:@"button_open"] forState:UIControlStateNormal];
        }
        
    }else{
        if ([contentStr length] > 0) {
            if (_index == 0 || _index == 1 || _index == 3) {
                _textField.text = contentStr;
            }else{
                _rightLabel.text = contentStr;
                _rightLabel.textColor = UIColorFromRGB(0x443415);
            }
        }
    }
    
   
    
    
}

#pragma mark--lazy
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _leftLabel;
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
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x443415);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.numberOfLines = 2;
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
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.backgroundColor = [UIColor whiteColor];
        [_selectBtn addTarget:self action:@selector(selectBtnBlock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

@end
