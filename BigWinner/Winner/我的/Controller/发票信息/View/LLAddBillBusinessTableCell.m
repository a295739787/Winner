//
//  LLAddBillBusinessTableCell.m
//  Winner
//
//  Created by YP on 2022/3/23.
//

#import "LLAddBillBusinessTableCell.h"

@interface LLAddBillBusinessTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation LLAddBillBusinessTableCell

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
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.textField];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.nextImg.mas_left).offset(CGFloatBasedI375(-10));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
}
-(void)setLeftStr:(NSString *)leftStr{
    _titleLabel.text = leftStr;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
}
-(void)setType:(NSInteger)type{
    _type = type;
    if (_type == 1) {
       _contentLabel.text = @"增值税电子普通发票";
    }else{
        _contentLabel.text = @"增值税专用发票";
    }
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    if (_indexRow == 0 ) {
        _textField.hidden = YES;
        _contentLabel.hidden = NO;
        _nextImg.hidden = NO;
        

        
    }else{
        _textField.hidden = NO;
        _contentLabel.hidden = YES;
        _nextImg.hidden = YES;
    }
    
    if (indexRow == 3) {
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    if (self.LLAddBillBusinessBlock) {
        self.LLAddBillBusinessBlock(_indexRow, textField.text);
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

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColorFromRGB(0x443415);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
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



@interface LLAddBillSpecialAdressTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation LLAddBillSpecialAdressTableCell

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
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.textField];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.nextImg.mas_left).offset(CGFloatBasedI375(-10));
        make.left.mas_equalTo(CGFloatBasedI375(100));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
}
-(void)setLeftStr:(NSString *)leftStr{
    _titleLabel.text = leftStr;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
    if (_indexRow == 7) {
        _contentLabel.text = placeholder;
        _contentLabel.textColor = UIColorFromRGB(0x999999);
    }
}
-(void)setContent:(NSString *)content{
    _content = content;
}
-(void)setType:(NSInteger)type{
    _type = type;
    if (_indexRow == 0) {
        _contentLabel.text =@"增值税专用发票";
    }
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    if (_indexRow == 0 || _indexRow == 7) {
        _textField.hidden = YES;
        _contentLabel.hidden = NO;
        _nextImg.hidden = NO;
        
    }else{
        _textField.hidden = NO;
        _contentLabel.hidden = YES;
        _nextImg.hidden = YES;
    }
    
    if (indexRow == 5) {
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
}
-(void)setAdressStr:(NSString *)adressStr{
    
    if (_indexRow == 7) {
        _contentLabel.text = adressStr;
    }
    
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    if (self.LLAddBillBusinessBlock) {
        self.LLAddBillBusinessBlock(_indexRow, textField.text);
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

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColorFromRGB(0x443415);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
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

