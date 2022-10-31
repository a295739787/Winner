//
//  ChangeAdressControllerCell.m
//  xkb
//
//  Created by YP on 2019/3/22.
//  Copyright © 2019年 刘文博. All rights reserved.
//

#import "ChangeAdressControllerCell.h"

@interface ChangeAdressControllerCell ()

@property (nonatomic,strong)UILabel *leftlabel;
@property (nonatomic,strong)UILabel *adressLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation ChangeAdressControllerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.leftlabel];
    [self.contentView addSubview:self.adressLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.nextImg];
    
    [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(96));
    }];
    
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftlabel.mas_right).offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(73));
        make.centerY.mas_equalTo(self.leftlabel);
        make.right.mas_equalTo(CGFloatBasedI375(-30));
    }];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftlabel.mas_right).offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(73));
        make.centerY.mas_equalTo(self.leftlabel);
        make.right.mas_equalTo(CGFloatBasedI375(-5));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(13));
        make.width.mas_equalTo(CGFloatBasedI375(13));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(1));
        make.bottom.mas_equalTo(0);
    }];
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    
    if (index == 0) {
        
        _textField.keyboardType =  0;
        _adressLabel.hidden = YES;
        _textField.hidden = NO;
        _nextImg.hidden = YES;
        
    }else if (index == 1){
        _adressLabel.hidden = YES;
        _textField.hidden = NO;
        _nextImg.hidden = YES;
        _textField.keyboardType =  UIKeyboardTypeNumberPad;
        
    }else if (index == 2){
        _adressLabel.hidden = NO;
        _textField.hidden = YES;
        _nextImg.hidden = NO;
        
    }else{
        _textField.keyboardType =  0;
        _adressLabel.hidden = YES;
        _textField.hidden = NO;
        _nextImg.hidden = YES;
    }
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftlabel.text = leftStr;
}
-(void)setRightStr:(NSString *)rightStr{
    
    if (_index == 2) {
        
        if ([rightStr length] > 0) {
            _adressLabel.text = rightStr;
            _adressLabel.textColor = [UIColor blackColor];
        }else{
            _adressLabel.text = @"请选择所在地区";
            _adressLabel.textColor = UIColorFromRGB(0xD1D1D1);
        }
    }else{
        
        if ([rightStr length] > 0) {
          _textField.text = rightStr;
        }else{
            if (_index == 0) {
                _textField.placeholder = @"请输入收货人";
            }else if (_index == 1){
                _textField.placeholder = @"请输入手机号码";
                
            }else if (_index == 3){
                _textField.placeholder = @"请输入详细地址";
            }
        }
    }
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    self.adressBlock(textField.text,_index);
}
#pragma mark--lazy
-(UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel = [[UILabel alloc]init];
        _leftlabel.backgroundColor = [UIColor whiteColor];
        _leftlabel.textAlignment = NSTextAlignmentLeft;
        _leftlabel.font = AdaptedFontSize(13);
        _leftlabel.textColor = UIColorFromRGB(0x000000);
    }
    return _leftlabel;
}
-(UILabel *)adressLabel{
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc]init];
        _adressLabel.backgroundColor = [UIColor whiteColor];
        _adressLabel.textAlignment = NSTextAlignmentLeft;
        _adressLabel.font = AdaptedFontSize(13);
        _adressLabel.textColor = UIColorFromRGB(0xD1D1D1);
    }
    return _adressLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.font = AdaptedFontSize(13);
        _textField.textColor = UIColorFromRGB(0x000000);
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.textAlignment = NSTextAlignmentLeft;
    }
    return _textField;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"更多"];
    }
    return _nextImg;
}

@end
