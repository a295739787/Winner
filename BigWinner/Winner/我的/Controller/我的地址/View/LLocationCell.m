//
//  LLocationCell.m
//  LLPensionProject
//
//  Created by lijun L on 2019/9/9.
//  Copyright © 2019年 lijun L. All rights reserved.
//

#import "LLocationCell.h"

@implementation LLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = White_Color;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(15));
        make.right.offset(CGFloatBasedI375(-15));

    }];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.bottom.offset(CGFloatBasedI375(-5));
        make.height.offset(CGFloatBasedI375(15));
        make.right.offset(CGFloatBasedI375(-15));
    }];
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.mas_centerY);
        make.right.offset(CGFloatBasedI375(-15));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(1));
    }];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.right.offset(CGFloatBasedI375(-10));
    }];
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview: self.titleLabel];
        _titleLabel.text = @"金豪商务大厦";
    }
    return _titleLabel;
}
-(UILabel *)midLabel{
    if(!_midLabel){
        _midLabel = [[UILabel alloc]init];;
        _midLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _midLabel.textAlignment = NSTextAlignmentLeft;
        _midLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview: self.midLabel];
    }
    return _midLabel;
}
-(UILabel *)subLabel{
    if(!_subLabel){
        _subLabel = [[UILabel alloc]init];;
        _subLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _subLabel.textAlignment = NSTextAlignmentLeft;
        _subLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview: self.subLabel];
        _subLabel.text = @"广东省广州市天河区棠安路";
    }
    return _subLabel;
}
-(UIImageView *)selectImageView{
    if(!_selectImageView){
        _selectImageView = [[UIImageView alloc]init];
        _selectImageView.image = [UIImage imageNamed:@"conergou"];
        [self addSubview: self.selectImageView];

    }
    return _selectImageView;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
