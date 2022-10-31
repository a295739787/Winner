//
//  LLMainReusableView.m
//  Winner
//
//  Created by 廖利君 on 2022/1/24.
//

#import "LLMainReusableView.h"
#import "LLSurpriseRegBagViewController.h"
#import "LLIntroPointViewController.h"
#import "LLPaihangbanViewController.h"
@interface LLMainReusableView ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *sycleview;/** <#class#> **/
@property (nonatomic,strong) UIView *topView ;/** <#class#> **/
@property (nonatomic,assign) NSInteger *index ;/** <#class#> **/
@property (nonatomic,strong) JhtVerticalMarquee *verticalMarquee;/** <#class#> **/
@property (nonatomic,strong) UIImageView *leftImage ;/** <#class#> **/
@property (nonatomic,strong) UIImageView *rightImage ;/** <#class#> **/
@property (nonatomic,strong) UIView *bangView ;/** <#class#> **/
@property (nonatomic,strong) UIImageView *midImage ;/** <#class#> **/
@property (nonatomic,strong) UIImageView *redImage ;/** <#class#> **/
@property (nonatomic,strong) UIImageView *boImage ;/** <#class#> **/
@property(nonatomic,strong)UILabel *timelable;
@property (nonatomic,strong) UIImageView *allowImage ;/** <#class#> **/
@property(nonatomic,strong)UILabel *numlable;
@property (nonatomic,strong) UIImageView *headImage ;/** <#class#> **/
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *delable;
@property(nonatomic,strong)UIView *backView;
@property (nonatomic,strong) UIImageView *showBackimage;/** <#class#> **/
@property (nonatomic,strong) UIImageView *allowBackImage ;/** <#class#> **/
@property (nonatomic,strong) UIImageView *noimage;/** <#class#> **/
@property(nonatomic,strong)UILabel *nolable;


@end
@implementation LLMainReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    [self.sycleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(175));
        make.top.equalTo(weakself.topView.mas_bottom).mas_equalTo(CGFloatBasedI375(0));
    }];
    [self.midImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(98));
        make.top.equalTo(weakself.sycleview.mas_bottom).mas_equalTo(CGFloatBasedI375(10));
    }];
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(32));
        make.left.offset(CGFloatBasedI375(100));
    }];
    [self.allowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(12));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(45));
        make.bottom.offset(-CGFloatBasedI375(15));

    }];
    [self.noimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(84));
        make.width.offset(CGFloatBasedI375(30));
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
    [self.nolable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.noimage.mas_right).offset(CGFloatBasedI375(7));
        make.right.offset(-CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
    [self.numlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(20));
        make.width.offset(CGFloatBasedI375(40));
        make.height.mas_equalTo(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
    [self.showBackimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.numlable.mas_right).offset(CGFloatBasedI375(20));
        make.width.offset(CGFloatBasedI375(33));
        make.height.mas_equalTo(CGFloatBasedI375(29));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
    [self.headImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.showBackimage.mas_centerX);
        make.width.offset(CGFloatBasedI375(20));
        make.height.offset(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.showBackimage.mas_centerY);
    }];

    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.headImage.mas_right).offset(CGFloatBasedI375(6));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    
    }];
    [self.redImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(32));
        make.top.equalTo(weakself.midImage.mas_bottom).mas_equalTo(CGFloatBasedI375(10));
    }];
    [self.boImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(100));
        make.top.equalTo(weakself.redImage.mas_bottom).mas_equalTo(CGFloatBasedI375(10));
    }];
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.topView.mas_centerY);
    }];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.topView.mas_centerY);
    }];
    [_verticalMarquee marqueeOfSettingWithState:MarqueeContinue_V];
    [self addVerticalMarquee];
}
-(void)setRedUsers:(NSArray *)redUsers{
    _redUsers = redUsers;
    NSMutableArray *redUse = [NSMutableArray array];
    for(NSDictionary *mo in _redUsers){
        NSString *nick =mo[@"nickName"];
        if(nick.length >= 2){
            nick = [nick stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }
        NSString *str = FORMAT(@" 恭喜 %@ 获得惊喜红包￥%@ 奖励！",nick,mo[@"redPrice"]);
        NSString *realName = FORMAT(@"%@", mo[@"nickName"]);
        NSString *redPrice =FORMAT(@"￥%@", mo[@"redPrice"]);
        if(realName.length > 0){
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName value:Main_Color range:NSMakeRange(4, [realName length])];
        [attrStr addAttribute:NSForegroundColorAttributeName value:Main_Color range:NSMakeRange([realName length]+11, [redPrice length])];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:@"hb"];
        attch.bounds = CGRectMake(0, -2, 14, 15);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attrStr insertAttributedString:string atIndex:0];

        [redUse addObject:attrStr];
        }
    }
    self.verticalMarquee.sourceArray = redUse.mutableCopy;;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    NSMutableArray *temp = [NSMutableArray array];
    for(LLGoodModel *model in _model.carousels){
        if([model.image containsString:@"http"]){
            [temp addObject:model.image];
        }else{
            [temp addObject:FORMAT(@"%@%@",API_IMAGEHOST,model.image)];
        }
    }
    self.sycleview.imageURLStringsGroup = temp.mutableCopy;
    if(_model.userInfo){
        self.noimage.hidden = YES;
        self.nolable.hidden = YES;
   
        self.titlelable.hidden = NO;
        self.numlable.hidden = NO;
        self.headImage.hidden = NO;
        self.delable.hidden = NO;
        self.timelable.hidden = NO;
        self.showBackimage.hidden = NO;
        self.allowImage.hidden = NO;
        self.numlable.text = _model.userInfo.ranking;
        self.titlelable.text = @"我的排名";;
        self.timelable.text = FORMAT(@"活动时间:%@ 至 %@",_model.userInfo.startTime,_model.userInfo.endTime);
        [self.headImage sd_setImageWithUrlString:_model.userInfo.headIcon];
        self.delable.text = FORMAT(@"%@点",_model.userInfo.spotNum);
    }else{
        self.noimage.hidden = NO;
        self.nolable.hidden = NO;
        self.titlelable.hidden = YES;
        self.numlable.hidden = YES;
        self.headImage.hidden = YES;
        self.delable.hidden = YES;
        self.timelable.hidden = YES;
        self.showBackimage.hidden = YES;
        self.allowImage.hidden = YES;
    }
    
}
#pragma mark 纵向 跑马灯
/** 添加纵向 跑马灯 */
- (void)addVerticalMarquee {
    [self layoutIfNeeded];
    [self.topView addSubview:self.verticalMarquee];
    
    [self.verticalMarquee scrollWithCallbackBlock:^(JhtVerticalMarquee *view, NSInteger currentIndex) {
    }];

    // 开始滚动
    [self.verticalMarquee marqueeOfSettingWithState:MarqueeStart_V];
}
- (JhtVerticalMarquee *)verticalMarquee {
    if (!_verticalMarquee) {
        _verticalMarquee = [[JhtVerticalMarquee alloc]  initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-CGFloatBasedI375(60), CGFloatBasedI375(40))];
        
        _verticalMarquee.tag = 101;
//        _verticalMarquee.isCounterclockwise = YES;
        _verticalMarquee.numberOfLines = 0;
        _verticalMarquee.textAlignment = NSTextAlignmentCenter;
//        _verticalMarquee.backgroundColor = [UIColor yellowColor];
        _verticalMarquee.textColor = lightGray9999_Color;
        
        // 添加点击手势
        UITapGestureRecognizer *vtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marqueeTapGes:)];
        [_verticalMarquee addGestureRecognizer:vtap];
    }
    
    return _verticalMarquee;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    LLGoodModel *model = _model.carousels[index];
    if(model.type == 3){
        if([UserModel sharedUserInfo].token.length <= 0){
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [dele loginVc];
            return ;
        }
        //状态（1待审核、2已通过、3不通过
        NSLog(@"clerkStatus == %ld shopStatus==%ld",[UserModel sharedUserInfo].clerkStatus,[UserModel sharedUserInfo].shopStatus);
        if([UserModel sharedUserInfo].clerkStatus == 0){//状态（1待审核、2已通过、3不通过）
            if([UserModel sharedUserInfo].shopStatus == 0 ){
                LLIntroPointViewController *vc = [[LLIntroPointViewController alloc]init];
                vc.status = RoleStatusTuiguang;
                [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
            }else if ([UserModel sharedUserInfo].shopStatus == 1){
                [JXUIKit showErrorWithStatus:@"推广点申请审核中"];
            }else if ([UserModel sharedUserInfo].shopStatus == 3){
                LLIntroPointViewController *vc = [[LLIntroPointViewController alloc]init];
                vc.status = RoleStatusTuiguang;
                vc.refuseStutas = YES;
                [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
            }
            
        }else if([UserModel sharedUserInfo].clerkStatus == 1){
            [JXUIKit showErrorWithStatus:@"申请配送员审核中，不能申请推广点"];
        }else if([UserModel sharedUserInfo].clerkStatus == 3){
            LLIntroPointViewController *vc = [[LLIntroPointViewController alloc]init];
            vc.status = RoleStatusTuiguang;
            vc.refuseStutas = YES;
            [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
        }
    }else if(model.type == 1){
        LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
        vc.ID = model.goodsId;
        [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
    }else if(model.type == 2){
        NSString *url = model.link;
        if(![model.link containsString:@"http"]){
            url = FORMAT(@"https://%@",model.link);
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    }
  
}
#pragma mark Get Method
/** 点击 滚动跑马灯 触发方法 */
- (void)marqueeTapGes:(UITapGestureRecognizer *)ges {
//    if (ges.view.tag == 100) {
//        NSLog(@"点击__水平__滚动的跑马灯啦！！！");
//
//    } else if (ges.view.tag == 101) {
//        NSLog(@"点击__纵向__滚动的跑马灯_第 %ld 条数据啦！！！", (long)self.verticalMarquee.currentIndex);
//    }

//    [self.verticalMarquee marqueeOfSettingWithState:MarqueePause_V];
//    _isPauseV = YES;
    
//    [self.navigationController pushViewController:[[testVC alloc] init] animated:YES];
}
-(UIImageView *)rightImage{
    if(!_rightImage){
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"logo_r"];
        _rightImage.userInteractionEnabled = YES;
        [self.topView addSubview:self.rightImage];
    }
    return _rightImage;
    }
-(UIImageView *)midImage{
    if(!_midImage){
        _midImage = [[UIImageView alloc]init];
        _midImage.image = [UIImage imageNamed:@"phb_bg"];
        _midImage.userInteractionEnabled = YES;
        [self addSubview:self.midImage];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickpaihang)];
        [_midImage addGestureRecognizer:tap];
      
    }
    return _midImage;
    }

-(void)clickpaihang{
    if([UserModel sharedUserInfo].token.length <= 0){
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele loginVc];
        return ;
    }
    LLPaihangbanViewController *vc = [[LLPaihangbanViewController alloc]init];
    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}
-(UIImageView *)leftImage{
    if(!_leftImage){
        _leftImage = [[UIImageView alloc]init];
        _leftImage.image = [UIImage imageNamed:@"logo_l"];
        _leftImage.userInteractionEnabled = YES;
        [self.topView addSubview:self.leftImage];
    }
    return _leftImage;
    }
-(UIImageView *)redImage{
    if(!_redImage){
        _redImage = [[UIImageView alloc]init];
        _redImage.image = [UIImage imageNamed:@"jxhb_title"];
        _redImage.userInteractionEnabled = YES;
        [self addSubview:self.redImage];
    }
    return _redImage;
    }
-(UIImageView *)boImage{
    if(!_boImage){
        _boImage = [[UIImageView alloc]init];
        _boImage.image = [UIImage imageNamed:@"jxhb_ad"];
        _boImage.userInteractionEnabled = YES;
        [self addSubview:self.boImage];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
        [_boImage addGestureRecognizer:tap];
     
    }
    return _boImage;
    }
-(UIImageView *)showBackimage{
    if (!_showBackimage) {
        _showBackimage = [[UIImageView alloc]init];
        _showBackimage.userInteractionEnabled = YES;
        _showBackimage.image =[UIImage imageNamed:@"photo_bg1"];
        [self.backView addSubview:self.showBackimage];
        self.showBackimage.hidden = YES;
    }
    return _showBackimage;
}
-(void)tapclick:(UITapGestureRecognizer *)sender{
    LLSurpriseRegBagViewController *vc = [[LLSurpriseRegBagViewController alloc]init];
    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}
- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#F0EDE9"];
        [self addSubview:_topView];
    }
    return _topView;;
}

-(SDCycleScrollView *)sycleview{
    if(!_sycleview){
      _sycleview= [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
           _sycleview.autoScrollTimeInterval = 4;
//        _sycleview.localizationImageNamesGroup = @[@"banner01",@"banner01"];
        _sycleview.pageDotColor = [UIColor colorWithHexString:@"#ffffff"];
   [self addSubview:_sycleview];
        _sycleview.currentPageDotColor = [UIColor darkGrayColor];
        _sycleview.pageDotColor = [UIColor lightGrayColor];
           _sycleview.delegate = self;
    }
    return _sycleview;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        [self.midImage addSubview:_backView];
    }
    return _backView;
}
-(UIImageView *)noimage{
    if(!_noimage){
        _noimage = [[UIImageView alloc]init];
        _noimage.image = [UIImage imageNamed:@"hdcbz"];
        _noimage.userInteractionEnabled = YES;
        _noimage.hidden = YES;
        [self.backView addSubview:self.noimage];
    }
    return _noimage;
    }
-(UILabel *)nolable{
    if(!_nolable){
        _nolable =[[UILabel alloc]init];
        _nolable.text = @"活动筹备中，尽请期待...";
        _nolable.hidden = YES;
        _nolable.textColor = [UIColor colorWithHexString:@"#999999"];
        _nolable.textAlignment = NSTextAlignmentLeft;
        _nolable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.backView addSubview:self.nolable];
    }
    return _nolable;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"我的排名";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.backView addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
 
        self.titlelable.hidden = YES;
  
    }
    return _titlelable;
}
-(UILabel *)numlable{
    if(!_numlable){
        _numlable =[[UILabel alloc]init];
        _numlable.text = @"0";
        _numlable.textColor = [UIColor colorWithHexString:@"#443415"];
        _numlable.textAlignment = NSTextAlignmentCenter;
        _numlable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.backView addSubview:self.numlable];
        _numlable.layer.masksToBounds = YES;
        _numlable.layer.cornerRadius = CGFloatBasedI375(10);
        _numlable.layer.borderColor =[[[UIColor colorWithHexString:@"#443415"]colorWithAlphaComponent:0.4] CGColor];
        _numlable.layer.borderWidth = .5f;
    
        self.numlable.hidden = YES;
    }
    return _numlable;
}
-(UILabel *)delable{
    if(!_delable){
        _delable =[[UILabel alloc]init];
        _delable.text = @"1588点";
        _delable.textColor = Main_Color;
        _delable.textAlignment = NSTextAlignmentRight;
        _delable.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(14)];
        [self.backView addSubview:self.delable];
  
        self.delable.hidden = YES;

    }
    return _delable;
}
-(UILabel *)timelable{
    if(!_timelable){
        _timelable =[[UILabel alloc]init];
        _timelable.text = @"活动时间:2021/12/01 至 2021/12/31";
        _timelable.textColor = [UIColor colorWithHexString:@"#443415"];
        _timelable.textAlignment = NSTextAlignmentRight;
        _timelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.midImage addSubview:self.timelable];
//        _timelable.numberOfLines = 2;
        self.timelable.hidden = YES;
    }
    return _timelable;
}
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"jxhb_ad"];
        _headImage.userInteractionEnabled = YES;
        [self.showBackimage addSubview:self.headImage];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = CGFloatBasedI375(10);
        self.headImage.hidden = YES;
    }
    return _headImage;
    }
-(UIImageView *)allowImage{
    if(!_allowImage){
        _allowImage = [[UIImageView alloc]init];
        _allowImage.image = [UIImage imageNamed:@"more_white"];
        _allowImage.userInteractionEnabled = YES;
        self.allowImage.hidden = YES;
        [self.midImage addSubview:self.allowImage];
    }
    return _allowImage;
    }

@end
