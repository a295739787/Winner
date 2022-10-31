//
//  LLIntroPointCell.m
//  Winner
//
//  Created by 廖利君 on 2022/3/6.
//

#import "LLIntroPointCell.h"
@interface LLIntroPointCell ()
@property (nonatomic,strong) UILabel *titlelable ;/** <#class#> **/
@property (nonatomic,assign) NSInteger *index ;/** <#class#> **/
@property (nonatomic,copy) NSString *str ;/** <#class#> **/
@property (nonatomic,strong) UIButton *maleBtn;/** <#class#> **/
@property (nonatomic,strong) UIButton *famaleBtn;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *seleArr;/** <#class#> **/

@property (nonatomic,strong) UIImageView *allowImage;/** <#class#> **/

@end
@implementation LLIntroPointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.titlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.allowImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.width.offset(CGFloatBasedI375(5.5));
        make.height.offset(CGFloatBasedI375(10));
    }];
    [self.maleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.width.offset(CGFloatBasedI375(60));
        make.height.offset(CGFloatBasedI375(30));
    }];
    [self.famaleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.maleBtn.mas_left).offset(-CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.width.offset(CGFloatBasedI375(60));
        make.height.offset(CGFloatBasedI375(30));
    }];
    [self.detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.allowImage.mas_left).offset(-CGFloatBasedI375(5));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.top.bottom.offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.titlelable.mas_right).offset(CGFloatBasedI375(5));

    }];
    [self.conTX mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.top.bottom.offset(CGFloatBasedI375(0));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.equalTo(weakself.titlelable.mas_right).offset(CGFloatBasedI375(5));

    }];
}
-(void)setBtnTags:(NSString *)btnTags{
    _btnTags = btnTags;
}
-(void)setStatus:(RoleStatus)status{
    _status = status;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    if(_model.status == 1 || _model.status == 2){
        self.conTX.enabled = NO;
        self.famaleBtn.userInteractionEnabled = NO;
        self.maleBtn.userInteractionEnabled = NO;
    }else{
        self.conTX.enabled = YES;
        self.famaleBtn.userInteractionEnabled = YES;
        self.maleBtn.userInteractionEnabled = YES;
    }
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath= indexPath;
}
-(void)setIndexs:(NSInteger)indexs{
    _indexs = indexs;
    self.conTX.hidden = YES;
    self.detailsLabel.hidden = YES;
    self.allowImage.hidden = YES;
    self.famaleBtn.hidden = YES;
    self.maleBtn.hidden = YES;
    self.conTX.keyboardType = UIKeyboardTypeDefault;
    if(_status == RoleStatusPeisong){
        if(_indexs == 0){
            self.titlelable.text = @"姓名";
            self.conTX.hidden = NO;
            self.conTX.placeholder = @"请输入真实姓名";
        }else if (_indexs == 1){
            self.titlelable.text = @"性别";
            self.famaleBtn.hidden = NO;
            self.maleBtn.hidden = NO;
            NSInteger tags = [_btnTags integerValue];
            for(UIButton *btn in self.seleArr){
                btn.selected = NO;
                if(btn.tag == tags){
                    btn.selected = YES;
                }
            }
        }else if (_indexs == 2){
            self.titlelable.text = @"联系电话";
            self.conTX.hidden = NO;
            self.conTX.keyboardType = UIKeyboardTypePhonePad;
            self.conTX.placeholder =  @"请输入联系电话";
        }else if (_indexs == 3){
            self.titlelable.text = @"身份证号";
            self.conTX.hidden = NO;
            self.conTX.placeholder =  @"请输入身份证号";
            self.conTX.keyboardType = UIKeyboardTypeASCIICapable;
        }else if (_indexs == 4){
            self.titlelable.text = @"所在地区";
            self.detailsLabel.hidden = NO;
            self.detailsLabel.text = @"选择所在地区";
            self.allowImage.hidden = NO;
        }else if (_indexs == 5){
            self.titlelable.text = @"所在位置";
            self.detailsLabel.hidden = NO;
            self.detailsLabel.text = @"选择所在位置";
            self.allowImage.hidden = NO;
        }
    }else{
    if(_indexs == 0){
        self.titlelable.text = @"店铺名称";
        self.conTX.hidden = NO;
        self.conTX.placeholder = @"请输入店铺名称";
    }else if (_indexs == 1){
        self.titlelable.text = @"联系电话";
        self.conTX.hidden = NO;
        self.conTX.placeholder = @"请输入联系电话";
        self.conTX.keyboardType = UIKeyboardTypePhonePad;
    }else if (_indexs == 2){
        self.titlelable.text = @"所在地区";
        self.detailsLabel.hidden = NO;
        self.detailsLabel.text = @"选择所在地区";
        self.allowImage.hidden = YES;
    }else if (_indexs == 3){
        self.titlelable.text = @"所在位置";
        self.detailsLabel.hidden = NO;
        self.detailsLabel.text = @"选择所在位置";
        self.allowImage.hidden = NO;
    }
    }
}

-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
    }
    return _titlelable;
}
-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.detailsLabel];

    }
    return _detailsLabel;
}
-(UIImageView *)allowImage{
    if (!_allowImage) {
        _allowImage = [[UIImageView alloc]init];
        _allowImage.userInteractionEnabled = YES;
        _allowImage.image =[UIImage imageNamed:allowimageGray];
        [self.contentView addSubview:self.allowImage];
    }
    return _allowImage;
}
-(UITextField *)conTX{
    if(!_conTX){
        _conTX = [[UITextField alloc]init];
        _conTX.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _conTX.textAlignment = NSTextAlignmentRight;
        _conTX.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.conTX];
        _conTX.placeholder = @"输入备注信息";
        [_conTX addTarget:self action:@selector(textfiledChange) forControlEvents:UIControlEventEditingChanged];

    }
    return _conTX;
}
-(UIButton *)famaleBtn{
    if(!_famaleBtn){
        _famaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_famaleBtn setTitle:@"男" forState:UIControlStateNormal];
        [_famaleBtn setImage:[UIImage imageNamed:@"xz_gray"] forState:UIControlStateNormal];
        [_famaleBtn setImage:[UIImage imageNamed:@"xz_red"] forState:UIControlStateSelected];
        [_famaleBtn setTitleColor:[UIColor colorWithHexString:@"#212121"] forState:UIControlStateNormal];
        _famaleBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _famaleBtn.tag = 1;
        [self.seleArr addObject:_famaleBtn];
        [_famaleBtn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.famaleBtn];
        _famaleBtn.hidden = YES;
        [_famaleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:-20];
    }
    return _famaleBtn;
}
-(UIButton *)maleBtn{
    if(!_maleBtn){
        _maleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_maleBtn setTitle:@"女" forState:UIControlStateNormal];
        [_maleBtn setImage:[UIImage imageNamed:@"xz_gray"] forState:UIControlStateNormal];
        [_maleBtn setImage:[UIImage imageNamed:@"xz_red"] forState:UIControlStateSelected];
        [_maleBtn setTitleColor:[UIColor colorWithHexString:@"#212121"] forState:UIControlStateNormal];
        _maleBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_maleBtn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.maleBtn];
        _maleBtn.hidden = YES;
        _maleBtn.tag = 0;
        [self.seleArr addObject:_maleBtn];
        [_maleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:-20];
    }
    return _maleBtn;
}
-(void)clickTap:(UIButton *)sender{
    for(UIButton *btn in self.seleArr){
        btn.selected = NO;
    }
    sender.selected = YES;
    if(self.getblock){
        self.getblock(sender.tag, sender.titleLabel.text);
    }
}
- (void)textfiledChange {
    
    if ([self.delegate respondsToSelector:@selector(getCellData:indexs:)]) {
        [self.delegate getCellData:self.conTX.text indexs:_indexPath];
    }

}
-(NSMutableArray *)seleArr{
    if(!_seleArr){
        _seleArr = [NSMutableArray array];
    }
    return _seleArr;
}
@end
