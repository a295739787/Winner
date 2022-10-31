//
//  LLWalletListTableCell.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLWalletListTableCell.h"

@interface LLWalletListTableCell ()

@property (nonatomic,strong)UILabel *typeNameLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLWalletListTableCell

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
    [self.contentView addSubview:self.typeNameLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.line];
    
    [self.typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.typeNameLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(self.typeNameLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(-15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setMode:(NSInteger)mode{
    _mode = mode;
}
-(void)setListModel:(LLWalletListModel *)listModel{
    _listModel = listModel;
    _typeLabel.text = _listModel.orderNo;
    
    CGFloat priceStr = [_listModel.price floatValue];
    
    if(_mode == 1){//获取
        _priceLabel.text = FORMAT(@"+%.2f",priceStr) ;
    }else{
        _priceLabel.text = FORMAT(@"-%.2f",priceStr) ;
    }

    _timeLabel.text = _listModel.createTime;
    //交易类型（1惊喜红包奖励、2推广佣金、3回购商品、4配送任务库存金额反还、5配送任务佣金奖励、6提现、7配送任务超时罚款、8零售商品/购物车商品支付、9红包购买商品抵扣、10惊喜红包支付、11品鉴商品购买、12品鉴商品加价、13配送库存采购支付、14扫码开盖/幸运红包、15配送超时消费红包、16排行包消费红包）
    if ([_listModel.type intValue] == 1) {
        _typeNameLabel.text = @"惊喜红包奖励";
    }else if ([_listModel.type intValue] == 2){
        _typeNameLabel.text = @"推广佣金";
    }else if ([_listModel.type intValue] == 3){
        _typeNameLabel.text = @"回购商品";
    }else if ([_listModel.type intValue] == 4){
        _typeNameLabel.text = @"配送任务库存金额反还";
    }else if ([_listModel.type intValue] == 5){
        _typeNameLabel.text = @"配送任务佣金奖励";
    }else if ([_listModel.type intValue] == 6){
        _typeNameLabel.text = @"提现";
    }else if ([_listModel.type intValue] == 7){
        _typeNameLabel.text = @"配送任务超时罚款";
    }else if ([_listModel.type intValue] == 8){
        _typeNameLabel.text = @"零售商品/购物车商品支付";
    }else if ([_listModel.type intValue] == 9){
        _typeNameLabel.text = @"红包购买商品抵扣";
    }else if ([_listModel.type intValue] == 10){
        _typeNameLabel.text = @"惊喜红包支付";
    }else if ([_listModel.type intValue] == 11){
        _typeNameLabel.text = @"品鉴商品购买";
    }else if ([_listModel.type intValue] == 12){
        _typeNameLabel.text = @"品鉴商品加价";
    }else if ([_listModel.type intValue] == 13){
        _typeNameLabel.text = @"配送库存采购支付";
    }else if ([_listModel.type intValue] == 14){
        _typeNameLabel.text = @"瓶盖扫码消费红包";
    }else if ([_listModel.type intValue] == 15){
        _typeNameLabel.text = @"配送超时消费红包";
    }else if ([_listModel.type intValue] == 16){
        _typeNameLabel.text = @"排行榜消费红包";
    }
}

#pragma mark--lazy
-(UILabel *)typeNameLabel{
    if (!_typeNameLabel) {
        _typeNameLabel = [[UILabel alloc]init];
        _typeNameLabel.textColor = UIColorFromRGB(0x443415);
        _typeNameLabel.textAlignment = NSTextAlignmentLeft;
        _typeNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _typeNameLabel.text = @"惊喜红包奖励";
    }
    return _typeNameLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.textColor = UIColorFromRGB(0x999999);
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _typeLabel.text = @"20210445616464645";
    }
    return _typeLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0xD40006);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _priceLabel.text = @"0.00";
    }
    return _priceLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _timeLabel.text = @"2021-10-22 19:26:57";
    }
    return _timeLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

@end




@interface LLWalletAddBankCardTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@end

@implementation LLWalletAddBankCardTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.imgView];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.nextImg];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
//        make.width.height.mas_equalTo(CGFloatBasedI375(24));
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
-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    _personalModel = personalModel;
    
    if ([_personalModel.isBank integerValue] == 1) {
        self.nextImg.hidden = YES;
        if(_personalModel.bankCardNum.length >= 19){
            NSString *numberString = [_personalModel.bankCardNum stringByReplacingCharactersInRange:NSMakeRange(4, 11) withString:@" **** **** **** "];
//            self.titleLabel.text = numberString;
            self.titleLabel.text = FORMAT(@"%@(%@)", _personalModel.bankName,numberString);

        }else{
            self.titleLabel.text = FORMAT(@"%@(%@)", _personalModel.bankName,_personalModel.bankCardNum);
        }
        _imgView.image = [UIImage imageNamed:@"icon_card"];
    }else{
        self.nextImg.hidden = NO;
        _titleLabel.text = @"添加银行卡";
        _imgView.image = [UIImage imageNamed:@"upload_yhk"];
    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
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
