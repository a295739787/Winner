//
//  LLMeTopView.m
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import "LLMeTopView.h"
#import "LLNewsViewController.h"
@interface LLMeTopView ()

@property (nonatomic,strong)UIImageView *bgImgView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UIButton *rightBtn;

@end

@implementation LLMeTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.bgImgView];
    [self addSubview:self.textLabel];
    [self addSubview:self.rightBtn];
    [self addSubview:self.redLabel];

    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(CGFloatBasedI375(35));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-18));
        make.height.width.mas_equalTo(CGFloatBasedI375(21));
    }];
    [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rightBtn.mas_top).offset(10);
        make.left.equalTo(self.rightBtn.mas_right).offset(-7);
        make.height.mas_equalTo(CGFloatBasedI375(13));
        make.width.mas_equalTo(CGFloatBasedI375(20));
    }];
}

#pragma mark--lazy
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.backgroundColor = [UIColor whiteColor];
        _bgImgView.image = [UIImage imageNamed:@"Personal_bg"];
    }
    return _bgImgView;
}
-(UILabel *)redLabel{
    if (!_redLabel) {
        _redLabel = [[UILabel alloc]init];
        _redLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _redLabel.textAlignment = NSTextAlignmentCenter;
        _redLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(11)];
        _redLabel.layer.masksToBounds = YES;
        _redLabel.layer.cornerRadius = CGFloatBasedI375(13)/2;
        _redLabel.backgroundColor = Red_Color;
        self.redLabel.hidden = YES;
    }
    return _redLabel;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(18)];
        _textLabel.text = @"我的";
    }
    return _textLabel;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn setImage:[UIImage imageNamed:@"notice_white"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(tapActionnoteImgView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(void)tapActionnoteImgView{
    LLNewsViewController *vc = [[LLNewsViewController alloc]init];
    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}
@end


@interface LLMeHeaderView ()

@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIButton *personalBtn;
@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *noteImgView;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UIView *changeView;
@property (nonatomic,strong)UIImageView *changeImgView;
@property (nonatomic,strong) LLGoodCarNoticeView *noticeView;/** <#class#> **/
///推广点编号
@property (nonatomic ,strong) UILabel *shopNumberLabel;
@end

@implementation LLMeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(CGFloatBasedI375(-30));
        make.width.mas_equalTo(CGFloatBasedI375(120));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    
    [self addSubview:self.personalBtn];
    
    [self.personalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
    [self.personalBtn addSubview:self.headerImgView];
    [self.personalBtn addSubview:self.nameLabel];
    [self.personalBtn addSubview:self.noteImgView];
    [self.personalBtn addSubview:self.numberLabel];
    
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(20));
        make.top.mas_equalTo(CGFloatBasedI375(25));
        make.height.width.mas_equalTo(CGFloatBasedI375(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImgView.mas_top).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(self.headerImgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.noteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(CGFloatBasedI375(2));
        make.width.mas_equalTo(CGFloatBasedI375(66));
        make.height.mas_equalTo(CGFloatBasedI375(22));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
    [self.changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.headerImgView);
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(28));

    }];
    
    [self.shopNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.changeView.mas_bottom).offset(4);
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(10));

    }];
    
    [self.changeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.centerY.mas_equalTo(self.changeView);
        make.width.mas_equalTo(CGFloatBasedI375(13));
        make.height.mas_equalTo(CGFloatBasedI375(13));

    }];
    [self.changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.changeImgView.mas_right).offset(CGFloatBasedI375(2));
        make.centerY.mas_equalTo(self.changeView);


    }];
    self.personalBtn.hidden = YES;
    self.changeView.hidden = YES;
    if([UserModel sharedUserInfo].token > 0){
        self.personalBtn.hidden = NO;
        self.loginBtn.hidden = YES;
    }else{
        self.personalBtn.hidden = YES;
        self.loginBtn.hidden = NO;
    }
}
-(void)reloadInfo{
    if ([UserModel sharedUserInfo].token.length > 0) {
        _loginBtn.hidden = YES;
        _personalBtn.hidden = NO;
//        self.changeView.hidden = NO;
        _nameLabel.text = [UserModel sharedUserInfo].nickName;
        if ([UserModel sharedUserInfo].account) {
            _numberLabel.text = [NSString setPhoneMidHid:[UserModel sharedUserInfo].account];
        }
        [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@",[UserModel sharedUserInfo].headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
        
        if(_isPeisong){//配送员/推广员
            self.changeView.hidden = NO;
            self.changeLabel.text = @"普通用户";
     
            if([UserModel sharedUserInfo].isShop){
                self.noteImgView.image = [UIImage imageNamed:@"label_tgd"];
            }else if([UserModel sharedUserInfo].isClerk){
                self.noteImgView.image = [UIImage imageNamed:@"label_psy"];
            }
        }else{
            self.noteImgView.image = [UIImage imageNamed:@"label_ptyh"];
            if([UserModel sharedUserInfo].isShop){
                self.changeLabel.text = @"推广点";
                self.changeView.hidden = NO;
            }else if([UserModel sharedUserInfo].isClerk){
                self.changeView.hidden = NO;
                self.changeLabel.text = @"配送员";
            }else{
                self.changeView.hidden = YES;
            }
        }
        
    }else{
        _loginBtn.hidden = NO;
        _personalBtn.hidden = YES;

    }
}
#pragma mark--loginBtnClick
-(void)loginBtnClick:(UIButton *)btn{
    
    if (self.loginBtnBlock) {
        self.loginBtnBlock();
    }
}
#pragma mark--personalBtnClick
-(void)personalBtnClick:(UIButton *)btn{
    if (self.personalBtnBlock) {
        self.personalBtnBlock();
    }
}
-(void)setIsPeisong:(BOOL)isPeisong{
    _isPeisong = isPeisong;
}
-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    _personalModel = personalModel;
    
    if (_personalBtn && [UserModel sharedUserInfo].token >0) {
        
        _loginBtn.hidden = YES;
        _personalBtn.hidden = NO;
        
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (dele.status == RoleStatusTuiguang) {
            
            _nameLabel.text = _personalModel.shopName;
            _numberLabel.text = _personalModel.shopNo;
            [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@%@",API_IMAGEHOST,_personalModel.shopPhoto) placeholderImage:[UIImage imageNamed:morentouxiang]];
            
        }else{
          
            _nameLabel.text = _personalModel.nickName;
            if (_personalModel.account) {
                _numberLabel.text = [NSString setPhoneMidHid:_personalModel.account];
            }
            [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@",_personalModel.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
        }
        
        _shopNumberLabel.text = _personalModel.shopNo;
        
        if(_isPeisong){//配送员/推广员
            self.changeView.hidden = NO;
            self.changeLabel.text = @"普通用户";
     
            if(_personalModel.isShop){
                self.noteImgView.image = [UIImage imageNamed:@"label_tgd"];
            }else if(_personalModel.isClerk){
                self.noteImgView.image = [UIImage imageNamed:@"label_psy"];
            }
        }else{
            self.noteImgView.image = [UIImage imageNamed:@"label_ptyh"];
            if(_personalModel.isShop){
                self.changeLabel.text = @"推广点";
                self.changeView.hidden = NO;
                self.shopNumberLabel.hidden = NO;
            }else if(_personalModel.isClerk){
                self.changeView.hidden = NO;
                self.changeLabel.text = @"配送员";
            }else{
                self.changeView.hidden = YES;
            }
        }
        
    }else{
        _loginBtn.hidden = NO;
        _personalBtn.hidden = YES;
    }
    
//    if(_personalModel.userIdentity.integerValue == 1){
//    if(_isPeisong){
//        
//    }else{
//        
//    }
//    }else{
//        self.changeView.hidden = YES;
//    }
 
}


#pragma mark--lazy
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = [UIColor clearColor];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _loginBtn.layer.borderWidth = 1;
        _loginBtn.hidden = YES;
        _loginBtn.layer.cornerRadius = CGFloatBasedI375(20);
        _loginBtn.clipsToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- (UIView *)changeView{
    if(!_changeView){
        _changeView = [[UIView alloc]init];
        _changeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        [self addSubview:_changeView];
        _changeView.layer.borderColor = [UIColor whiteColor].CGColor;
        _changeView.layer.borderWidth = 1;
        _changeView.layer.cornerRadius = CGFloatBasedI375(14);
        _changeView.clipsToBounds = YES;
        _changeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_changeView addGestureRecognizer:tap];
       
    }
    return _changeView;;
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    if(self.tapBlock){
        self.tapBlock();
    }
}
- (UILabel *)shopNumberLabel{
    
    if (!_shopNumberLabel) {
        
        _shopNumberLabel = [[UILabel alloc]init];
        _shopNumberLabel.textColor = [UIColor HexString:@"#FFFFFF"];
        _shopNumberLabel.textAlignment = NSTextAlignmentCenter;
        _shopNumberLabel.font = [UIFont systemFontOfSize:10];
        _shopNumberLabel.text = @"黔999999";
        _shopNumberLabel.hidden = YES;
        [self addSubview:_shopNumberLabel];
    }
    return  _shopNumberLabel;
}
-(UILabel *)changeLabel{
    if (!_changeLabel) {
        _changeLabel = [[UILabel alloc]init];
        _changeLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _changeLabel.textAlignment = NSTextAlignmentCenter;
        _changeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _changeLabel.text = @"推广点";
        [self.changeView addSubview:_changeLabel];
    }
    return _changeLabel;
}
-(UIImageView *)changeImgView{
    if (!_changeImgView) {
        _changeImgView = [[UIImageView alloc]init];
        _changeImgView.image = [UIImage imageNamed:@"switch"];
        [self.changeView addSubview:_changeImgView];
    }
    return _changeImgView;
}
-(UIButton *)personalBtn{
    if (!_personalBtn) {
        _personalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _personalBtn.backgroundColor = [UIColor clearColor];
        [_personalBtn addTarget:self action:@selector(personalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _personalBtn;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
        _headerImgView.backgroundColor = [UIColor whiteColor];
        _headerImgView.layer.cornerRadius = CGFloatBasedI375(30);
        _headerImgView.clipsToBounds = YES;
        _headerImgView.layer.borderColor = UIColorFromRGB(0xD25C64).CGColor;
        _headerImgView.layer.borderWidth = 3;
        [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@",[UserModel sharedUserInfo].headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    }
    return _headerImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _nameLabel.text = [UserModel sharedUserInfo].nickName;
    }
    return _nameLabel;
}
-(UIImageView *)noteImgView{
    if (!_noteImgView) {
        _noteImgView = [[UIImageView alloc]init];
        _noteImgView.backgroundColor = [UIColor clearColor];
        _noteImgView.image = [UIImage imageNamed:@"label_ptyh"];
        _noteImgView.userInteractionEnabled  = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showExplain)];
        [_noteImgView addGestureRecognizer:tap];
      
    }
    return _noteImgView;
}
-(void)setContent:(NSString *)content{
    _content = content;
}
-(void)showExplain{
    if(self.noticeView){
        self.noticeView = nil;
    }
    [self noticeView];
    if(_content.length > 0){
       self.noticeView.dic = @{@"content":_content};
    }
    [self.noticeView showActionSheetView];
}
-(LLGoodCarNoticeView *)noticeView{
    if(!_noticeView){
        _noticeView = [[LLGoodCarNoticeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);


    }
    return _noticeView;;
}
-(void)tapActionnoteImgView:(UITapGestureRecognizer *)sender{
    LLNewsViewController *vc = [[LLNewsViewController alloc]init];
    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _numberLabel.text = @"";
    }
    return _numberLabel;
}

@end
@interface LLGoodCarNoticeView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *backView;/** <#class#> **/

@property (nonatomic,strong) UIImageView *selectImage;

@end
@implementation LLGoodCarNoticeView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [Black_Color colorWithAlphaComponent:0.3];;
        [self setLayout];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = CGFloatBasedI375(10);
        self.layer.borderColor = [[UIColor colorWithHexString:@"#E4E4E4"] CGColor];
        self.layer.borderWidth = 1.0f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideActionSheetView)];
        tap.delegate = self;
        tap.cancelsTouchesInView = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
///**解决点击子view穿透到父视图的问题*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if ([touch.view isDescendantOfView:self.backView]) {
        return NO;
    }
    return YES;
}
-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.left.mas_equalTo(CGFloatBasedI375(30));
        make.right.mas_equalTo(-CGFloatBasedI375(30));
        make.height.offset(CGFloatBasedI375(200));
    }];

    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(0));
        make.right.offset(CGFloatBasedI375(-10));
        make.left.offset(CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(40));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(10));
        make.left.offset(CGFloatBasedI375(10));
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(0));

    }];
    UIButton *closebtn=[[UIButton alloc]init];
    [self.backView addSubview:closebtn];
    [closebtn setTitle:@"╳" forState:UIControlStateNormal];
    [closebtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    closebtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
    [closebtn addTarget:self action:@selector(hideActionSheetView) forControlEvents:UIControlEventTouchUpInside];
    [closebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(-5));
        make.width.height.offset(CGFloatBasedI375(40));
        make.centerY.equalTo(weakself.nameLabel1.mas_centerY);
    }];

}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.nameLabel1.text = @"收益说明";
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[_dic[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    self.detailsLabel.attributedText =attrStr;

}

-(void)setIsSelects:(BOOL)isSelects{
    _isSelects = isSelects;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CGFloatBasedI375(5);
    if(_isSelects){
        self.selectImage.hidden = NO;

        self.layer.borderColor = [[UIColor colorWithHexString:@"#00A47C"] CGColor];
        self.layer.borderWidth = 1.0f;
    }else{
        self.selectImage.hidden = YES;
        self.layer.borderColor = [[UIColor colorWithHexString:@"#E4E4E4"] CGColor];
        self.layer.borderWidth = 1.0f;
    }
}
#pragma mark ============= 懒加载 =============
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatBasedI375(10);
        [self addSubview:self.backView];
    }
    return _backView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.contentMode = UIViewContentModeScaleAspectFill;
        _showImage.userInteractionEnabled = YES;
        _showImage.image = [UIImage imageNamed:morenpic];
        [self.backView addSubview:self.showImage];
    }
    return _showImage;
}
-(UIImageView *)selectImage{
    if (!_selectImage) {
        _selectImage = [[UIImageView alloc]init];;
        _selectImage.userInteractionEnabled = YES;
        _selectImage.image = [UIImage imageNamed:@"selectsimagecar"];
        _selectImage.hidden = YES;
        [self.backView addSubview:self.selectImage];
    }
    return _selectImage;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(18)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentCenter;
        _nameLabel1.userInteractionEnabled = YES;
        [self.backView addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"商品礼包";

    }
    return _nameLabel1;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.numberOfLines = 0;
        [self.backView addSubview:self.detailsLabel];
    }
    return _detailsLabel;
}
/********************  Animation  *******************/

- (void)showActionSheetView {

//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        [window addSubview:self];
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];

}
- (void)hideActionSheetView {
    [self removeFromSuperview];
}
@end


@interface LLMeCommissionNoteView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong)UIView *line;


@end

@implementation LLMeCommissionNoteView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.bottomView];
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CGFloatBasedI375(280));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.noteLabel];
    [self.contentView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(20));
        make.left.mas_equalTo(CGFloatBasedI375(20));
        make.right.mas_equalTo(CGFloatBasedI375(-20));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noteLabel.mas_bottom).offset(CGFloatBasedI375(20));
        make.height.mas_equalTo(CGFloatBasedI375(45));
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(CGFloatBasedI375(-45));
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    
    
    
}


-(void)tap{
    
    [self hidden];
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hidden{
    [self removeFromSuperview];
}

#pragma mark--lazy
-(void)confirmBtnClick:(UIButton *)btn{
    
    [self hidden];
    
//    if (self.LLCommissionNoteBlock) {
//        self.LLCommissionNoteBlock();
//    }
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.6;
        _bottomView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.numberOfTapsRequired = 1;
        [_bottomView addGestureRecognizer:tap];
        
    }
    return _bottomView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = CGFloatBasedI375(5);
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _titleLabel.text = @"收益说明";
    }
    return _titleLabel;
}
-(void)setContent:(NSString *)content{
    _content = content;
    _noteLabel.text = _content;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x666666);
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0x09141F);
        _line.alpha = 0.3;
    }
    return _line;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        [_confirmBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}


@end
    

