//
//  LLMePromoteListTableCell.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLMePromoteListTableCell.h"

@interface LLMePromoteListTableCell ()

@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *totleLabel;
@property (nonatomic,strong)UILabel *bangtimeLabel;
@property (nonatomic,strong)UILabel *lastTimeLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UILabel *incomeLabel;
@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,strong)UIView *line;


@end

@implementation LLMePromoteListTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.headerImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.totleLabel];
    [self.contentView addSubview:self.bangtimeLabel];
    [self.contentView addSubview:self.lastTimeLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.incomeLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.bottomLine];
    
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(20));
        make.left.mas_equalTo(self.headerImgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(self.headerImgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImgView);
        make.top.mas_equalTo(self.headerImgView.mas_bottom).offset(CGFloatBasedI375(15));
    }];
    
    
    [self.totleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLabel);
        make.left.mas_equalTo(self.leftLabel.mas_right).offset(CGFloatBasedI375(4));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.bangtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(22));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.lastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bangtimeLabel.mas_bottom).offset(CGFloatBasedI375(8));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.incomeLabel);
        make.right.mas_equalTo(self.incomeLabel.mas_left).offset(CGFloatBasedI375(-5));
    }];

    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(CGFloatBasedI375(-13));
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}
-(void)setListModel:(PromoteUserListModel *)listModel{
    _listModel = listModel;
    [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@",_listModel.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    _nameLabel.text = _listModel.nickName;
    _phoneLabel.text = [NSString setPhoneMidHid:_listModel.account];
    
    CGFloat totalPrice = [_listModel.totalPrice floatValue];
    _totleLabel.text = [NSString stringWithFormat:@"¥%.2f",totalPrice];
    _bangtimeLabel.text = [NSString stringWithFormat:@"绑定时间:%@",_listModel.bindTime];
    _lastTimeLabel.text = [NSString stringWithFormat:@"最近下单:%@",_listModel.latelyTime];
    _incomeLabel.text = [NSString stringWithFormat:@"¥%.2f",_listModel.profitPrice.floatValue];
    self.lastTimeLabel.hidden = NO;
    if(_listModel.latelyTime.length <= 0){
        self.lastTimeLabel.hidden = YES;
    }
}

#pragma mark--lazy
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
        _headerImgView.layer.masksToBounds = YES;
        _headerImgView.layer.cornerRadius = CGFloatBasedI375(22);
    }
    return _headerImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0x443415);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _nameLabel.text = @"吴晓磊";
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _phoneLabel.text = @"137****4182";
    }
    return _phoneLabel;
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x666666);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _leftLabel.text = @"消费总额：";
    }
    return _leftLabel;
}
-(UILabel *)totleLabel{
    if (!_totleLabel) {
        _totleLabel = [[UILabel alloc]init];
        _totleLabel.textColor = UIColorFromRGB(0x443415);
        _totleLabel.textAlignment = NSTextAlignmentCenter;
        _totleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _totleLabel.text = @"1000.00";
    }
    return _totleLabel;
}
-(UILabel *)bangtimeLabel{
    if (!_bangtimeLabel) {
        _bangtimeLabel = [[UILabel alloc]init];
        _bangtimeLabel.textColor = UIColorFromRGB(0x999999);
        _bangtimeLabel.textAlignment = NSTextAlignmentRight;
        _bangtimeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _bangtimeLabel.text = @"绑定时间:2021-08-30";
    }
    return _bangtimeLabel;
}
-(UILabel *)lastTimeLabel{
    if (!_lastTimeLabel) {
        _lastTimeLabel = [[UILabel alloc]init];
        _lastTimeLabel.textColor = UIColorFromRGB(0x999999);
        _lastTimeLabel.textAlignment = NSTextAlignmentRight;
        _lastTimeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _lastTimeLabel.text = @"最近下单:2021-10-07";
    }
    return _lastTimeLabel;
}
-(UILabel *)incomeLabel{
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc]init];
        _incomeLabel.textColor = UIColorFromRGB(0xD40006);
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        _incomeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _incomeLabel.text = @"￥100.00";
    }
    return _incomeLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x666666);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _rightLabel.text = @"预计收益";
    }
    return _rightLabel;
}
-(UIView *)line{
    if (!_line) {
        _line  = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xE5E5E5);
    }
    return _line;
}
-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine  = [[UIView alloc]init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xF2F2F2);
    }
    return _bottomLine;
}


@end




@interface LLMePromoteDetailListTableCell ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;


@end

@implementation LLMePromoteDetailListTableCell

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
    [self.contentView addSubview:self.rightLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(13));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
    }];
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftLabel.text = leftStr;
}
-(void)setRightStr:(NSString *)rightStr{
    _rightLabel.text = rightStr;
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    if (_indexRow == 4) {
        _rightLabel.textColor = UIColorFromRGB(0x6EFA729);
    }else{
        _rightLabel.textColor = UIColorFromRGB(0x666666);
    }
}
#pragma mark--lazy
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x666666);
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x666666);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _rightLabel;
}

@end
