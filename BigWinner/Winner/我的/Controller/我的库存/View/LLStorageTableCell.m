//
//  LLStorageTableCell.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLStorageTableCell.h"

@interface LLStorageTableCell ()

@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UILabel *goodsCountLabel;
@property (nonatomic,strong)UIButton *letBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLStorageTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.mainView];
    [self.mainView addSubview:self.goodsImgView];
    [self.mainView addSubview:self.goodsNameLabel];
    [self.mainView addSubview:self.goodsSpecLabel];
    [self.mainView addSubview:self.goodsCountLabel];
    [self.mainView addSubview:self.letBtn];
    [self.mainView addSubview:self.rightBtn];
    [self.mainView addSubview:self.line];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).offset(12);
    }];
    
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(9);

    }];
    
    [self.letBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-14));
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(80));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.letBtn.mas_left).offset(-10);
        make.bottom.mas_equalTo(CGFloatBasedI375(-14));
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(80));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.showLAndRSpec == YES) {
        
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView).offset(0);
        }];
    }
}
-(void)setIsHidden:(BOOL)isHidden{
    _letBtn.hidden = isHidden;
}

-(void)setListModel:(LLStorageListModel *)listModel{
    
    if (self.showOther == YES) {
        [_rightBtn setHidden:NO];
    }
    
    _listModel = listModel;
    
    NSString *coverImage = _listModel.coverImage;
    NSString *name = _listModel.name;
    NSString *specsValName = _listModel.specsValName;
    NSString *goodsNum = _listModel.goodsNum;
    
    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _goodsCountLabel.text = [NSString stringWithFormat:@"库存：%@",goodsNum];
}
-(void)setStockListModel:(LLappUserStockListVoModel *)stockListModel{
    _stockListModel = stockListModel;
    NSString *coverImage = _stockListModel.coverImage;
    NSString *name = _stockListModel.name;
    NSString *specsValName = _stockListModel.specsValName;
    NSString *goodsNum = _stockListModel.goodsNum;

    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _goodsCountLabel.text = [NSString stringWithFormat:@"库存：%@",goodsNum];
}


#pragma mark--letBtnClick
-(void)letBtnClick:(UIButton *)btn{

    int goodsNum = _listModel.goodsNum.intValue;
    
    if (goodsNum <= 0) {
        
        [MBProgressHUD showError:@"当前库存为0，无法提货"];
        
    }else{
        if (self.storageBtnBlock) {
            self.storageBtnBlock(_listModel.ID);
        }
    }
   
}
#pragma mark--letBtnClick
-(void)rightBtnClick:(UIButton *)btn{

    if (self.rightBtnBlock) {
        self.rightBtnBlock(_listModel);
    }
}
#pragma mark--lazy
-(UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 5.0f;
    }
    return _mainView;
}
-(UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc]init];
    }
    return _goodsImgView;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        _goodsNameLabel.textColor = UIColorFromRGB(0x443415);
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _goodsNameLabel.text = @"大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒";
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}
-(UILabel *)goodsSpecLabel{
    if (!_goodsSpecLabel) {
        _goodsSpecLabel = [[UILabel alloc]init];
        _goodsSpecLabel.textColor = UIColorFromRGB(0x999999);
        _goodsSpecLabel.textAlignment = NSTextAlignmentLeft;
        _goodsSpecLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsSpecLabel.text = @"1支装(500ML)";
    }
    return _goodsSpecLabel;
}
-(UILabel *)goodsCountLabel{
    if (!_goodsCountLabel) {
        _goodsCountLabel = [[UILabel alloc]init];
        _goodsCountLabel.textColor = UIColorFromRGB(0x999999);
        _goodsCountLabel.textAlignment = NSTextAlignmentLeft;
        _goodsCountLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _goodsCountLabel.text = @"库存: 1";
    }
    return _goodsCountLabel;
}
-(UIButton *)letBtn{
    if (!_letBtn) {
        _letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _letBtn.backgroundColor = [UIColor whiteColor];
        [_letBtn setTitle:@"去提货" forState:UIControlStateNormal];
        [_letBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _letBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_letBtn addTarget:self action:@selector(letBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _letBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _letBtn.clipsToBounds = YES;
        _letBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _letBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _letBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitle:@"查看明细" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _rightBtn.clipsToBounds = YES;
        _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _rightBtn.layer.borderWidth = CGFloatBasedI375(1);
        [_rightBtn setHidden:YES];
    }
    return _rightBtn;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

@end



@interface LLStorageAdressTableCell ()

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UIView *defaultView;
@property (nonatomic,strong)UILabel *defaultLabel;
@property (nonatomic,strong)UILabel *adressLabel;
@property (nonatomic,strong)UIImageView *nextImg;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *nextAdressImg;

@end

@implementation LLStorageAdressTableCell

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
    [self.contentView addSubview:self.defaultView];
    [self.defaultView addSubview:self.defaultLabel];
    [self.contentView addSubview:self.nextImg];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(16));
        make.top.mas_equalTo(CGFloatBasedI375(14));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(14));
        make.left.mas_equalTo(CGFloatBasedI375(81));
    }];
    
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(CGFloatBasedI375(0));
        make.left.mas_equalTo(CGFloatBasedI375(81));
        make.right.mas_equalTo(CGFloatBasedI375(-57));
        make.bottom.mas_equalTo(CGFloatBasedI375(-5));
    }];
    
    
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(12));
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(3));
        make.bottom.mas_equalTo(CGFloatBasedI375(-3));
        make.left.mas_equalTo(CGFloatBasedI375(5));
        make.right.mas_equalTo(CGFloatBasedI375(-5));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(5));
    }];
    
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.imgView];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.nextAdressImg];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.height.mas_equalTo(CGFloatBasedI375(80));
        make.top.bottom.mas_equalTo(0);
    }];
    
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
    
//    _nameLabel.hidden = YES;
//    _phoneLabel.hidden = YES;
//    _defaultView.hidden = YES;
//    _defaultLabel.hidden = YES;
//    _adressLabel.hidden = YES;
//    _defaultView.hidden = YES;
//    _defaultLabel.hidden = YES;
//    _bottomView.hidden = YES;
//    _imgView.hidden = YES;
//    _titleLabel.hidden = YES;
//    _nextAdressImg.hidden = YES;
}


-(void)setModel:(LLGoodModel *)model{
    _model = model;
    if(_model){
        self.nameLabel.text = _model.receiveName;
        self.phoneLabel.text = [NSString setPhoneMidHid: _model.receivePhone];
        self.adressLabel.text = FORMAT(@"%@%@%@%@",_model.province,_model.city,_model.area,_model.address);
        
        _bottomView.hidden = YES;
        _imgView.hidden = YES;
        _titleLabel.hidden = YES;
        _nextAdressImg.hidden = YES;

        _nameLabel.hidden = NO;
        _phoneLabel.hidden = NO;
        _adressLabel.hidden = NO;
        self.adressLabel.hidden  =NO;

        NSString *isDefault = _model.isDefault;

        if ([isDefault intValue] == 0) {
            _defaultView.hidden = YES;
            _defaultLabel.hidden = YES;
        }else{
            _defaultView.hidden = NO;
            _defaultLabel.hidden = NO;
        }
    }else{
        _nameLabel.hidden = YES;
        _phoneLabel.hidden = YES;
        _defaultView.hidden = YES;
        _defaultLabel.hidden = YES;
        _adressLabel.hidden = YES;


        _bottomView.hidden = NO;
        _imgView.hidden = NO;
        _titleLabel.hidden = NO;
        _nextAdressImg.hidden = NO;
    }
    
}

#pragma mark--lazy
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0x443415);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = UIColorFromRGB(0x443415);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _phoneLabel;
}
-(UILabel *)adressLabel{
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc]init];
        _adressLabel.textColor = UIColorFromRGB(0x443415);
        _adressLabel.textAlignment = NSTextAlignmentLeft;
        _adressLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _adressLabel.numberOfLines = 0;
    }
    return _adressLabel;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
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
    }
    return _defaultLabel;
}


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
        _titleLabel.text = @"添加收货地址";
    }
    return _titleLabel;
}
-(UIImageView *)nextAdressImg{
    if (!_nextAdressImg) {
        _nextAdressImg = [[UIImageView alloc]init];
        _nextAdressImg.backgroundColor = [UIColor whiteColor];
        _nextAdressImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextAdressImg;
}


@end
