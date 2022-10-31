//
//  LLGoodBoView.m
//  ShopApp
//
//  Created by lijun L on 2021/3/23.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLGoodBoView.h"
@interface LLGoodBoView ()
@property (nonatomic,strong) UIButton *huowuBtn;/** <#class#> **/
@property (nonatomic,strong) UIButton *bugBtn;/** class **/
@property (nonatomic,strong) LLShowView *shopcarBtn;/** <#class#> **/
@property (nonatomic,strong) LLShowView *kefuBtn;/** <#class#> **/
@property (nonatomic,strong) UIView *backView;/** <#class#> **/
@property (nonatomic,strong) UILabel *titlelable;/** <#class#> **/

@end
@implementation LLGoodBoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    
    [self addSubview:self.kefuBtn];
    [self addSubview:self.shopcarBtn];
        [self.bugBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-CGFloatBasedI375(10));
            make.width.mas_equalTo(CGFloatBasedI375(110));
            make.height.mas_equalTo(CGFloatBasedI375(36));
            make.top.mas_equalTo(CGFloatBasedI375(6));
         }];
    
    [self.huowuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.bugBtn.mas_left).mas_equalTo(-CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(110));
        make.height.mas_equalTo(CGFloatBasedI375(36));
        make.centerY.equalTo(weakself.bugBtn.mas_centerY);
         }];
  
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.shopcarBtn.mas_right).mas_equalTo(-CGFloatBasedI375(3));
        make.top.equalTo(CGFloatBasedI375(1));
        make.width.mas_equalTo(CGFloatBasedI375(16));
        make.height.mas_equalTo(CGFloatBasedI375(16));
     }];
}
-(void)setStatus:(RoleStatus)status{
    _status = status;
    WS(weakself);
    if(_status == RoleStatusRedBag || _status == RoleStatusStockPeisong){
        self.shopcarBtn.hidden = YES;
        self.huowuBtn.hidden = YES;
        self.titlelable.hidden = YES;
        [self.bugBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo(-CGFloatBasedI375(15));
            make.left.equalTo(weakself.kefuBtn.mas_right).mas_equalTo(CGFloatBasedI375(0));
            make.height.mas_equalTo(CGFloatBasedI375(36));
            make.top.mas_equalTo(CGFloatBasedI375(6));
         }];
        if(_status == RoleStatusStockPeisong){
            [self.bugBtn setTitle:@"立即采购" forState:UIControlStateNormal];
        }
        
    }
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    if(_status == RoleStatusRedBag || _status == RoleStatusStockPeisong){
    }else{
        if(_model.cartNum > 0){
            self.titlelable.hidden = NO;
            self.titlelable.text = FORMAT(@"%ld",_model.cartNum);
        }else{
            self.titlelable.hidden = YES;
        }
        if(_status == RoleStatusRedBag){
            self.titlelable.hidden = YES;
            self.shopcarBtn.userInteractionEnabled = NO;
        }
    }
}
-(void)setIs_virtual:(NSInteger)is_virtual{
    _is_virtual = is_virtual;
    self.backView.hidden = NO;
    if(_is_virtual == 1){
        _huowuBtn.hidden = NO;
    }else{
        _huowuBtn.hidden = YES;
    }
    [self setLayout];
}
-(LLShowView *)kefuBtn{
    if(!_kefuBtn){
        _kefuBtn = [[LLShowView alloc]initWithFrame:CGRectMake(0, 0, CGFloatBasedI375(130)/2, DeviceXTabbarHeigh(50))];
        _kefuBtn.style = ShowViewNormalImage24State;
        _kefuBtn.titlelable.text =@"客服";
        _kefuBtn.titlelable.textColor = [UIColor colorWithHexString:@"#837D71"];
        _kefuBtn.showimage.image = [UIImage imageNamed:@"kfzx"];
        _kefuBtn.tag = 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickshop:)];
        [_kefuBtn addGestureRecognizer:tap];
    }
    return _kefuBtn;
}

-(void)setIsAttention:(NSInteger)isAttention{
    _isAttention = isAttention;
    if(_isAttention == 0){
        _shopcarBtn.showimage.image = [UIImage imageNamed:@"goodedeundele"];//deselectimage
    }else{
        _shopcarBtn.showimage.image = [UIImage imageNamed:@"deselectimage"];//deselectimage

    }
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"0";
        _titlelable.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _titlelable.backgroundColor = Red_Color;
        _titlelable.layer.masksToBounds = YES;
        _titlelable.layer.cornerRadius = CGFloatBasedI375(8);
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(10)];
        [self addSubview:self.titlelable];
        self.titlelable.hidden = YES;
    }
    return _titlelable;
}
-(LLShowView *)shopcarBtn{
    if(!_shopcarBtn){
        _shopcarBtn = [[LLShowView alloc]initWithFrame:CGRectMake(NW(self.kefuBtn), 0, CGFloatBasedI375(130)/2, DeviceXTabbarHeigh(50))];
        _shopcarBtn.titlelable.text =@"购物车";
        _shopcarBtn.style = ShowViewNormalImage24State;
        _shopcarBtn.titlelable.textColor = [UIColor colorWithHexString:@"#837D71"];
        _shopcarBtn.userInteractionEnabled = YES;
        _shopcarBtn.showimage.image = [UIImage imageNamed:@"gwc"];//deselectimage
        _shopcarBtn.tag = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickshop:)];
        [_shopcarBtn addGestureRecognizer:tap];
    }
    return _shopcarBtn;
}
-(UIButton *)huowuBtn{
    if(!_huowuBtn){
        _huowuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_huowuBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_huowuBtn setTitleColor:Black_Color forState:UIControlStateNormal];
        _huowuBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _huowuBtn.backgroundColor= [UIColor colorWithHexString:@"#F0EEEB"];
        _huowuBtn.tag = 1;
//        _huowuBtn.hidden = YES;
        _huowuBtn.layer.masksToBounds = YES;
        _huowuBtn.layer.cornerRadius = CGFloatBasedI375(18);
        [_huowuBtn addTarget:self action:@selector(takeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.huowuBtn];
    }
    return _huowuBtn;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
//        _backView.hidden = YES;
        _backView.layer.cornerRadius = CGFloatBasedI375(18);
        [self addSubview:_backView];
    }
    return _backView;
}
-(UIButton *)bugBtn{
    if(!_bugBtn){
        _bugBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bugBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_bugBtn setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        _bugBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _bugBtn.backgroundColor= [UIColor colorWithHexString:@"#D53329"];
        _bugBtn.tag = 2;
        _bugBtn.layer.masksToBounds = YES;
        _bugBtn.layer.cornerRadius = CGFloatBasedI375(18);
        [_bugBtn addTarget:self action:@selector(takeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bugBtn];
    }
    return _bugBtn;
}
-(void)takeAction:(UIButton *)sender{
    if(self.ActionBlock){
        self.ActionBlock(sender.tag);
    }
}
-(void)clickshop:(UITapGestureRecognizer *)sender{
    if(self.ActionBlock){
        self.ActionBlock(sender.view.tag);
    }
}
@end
