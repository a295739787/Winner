//
//  LLMeOrderheaderView.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeOrderheaderView.h"

@interface LLMeOrderheaderView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLMeOrderheaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    
    [self.bottomView addSubview:self.numberLabel];
    [self.bottomView addSubview:self.stateLabel];
    [self.bottomView addSubview:self.line];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
}

-(void)setModel:(LLMeOrderListModel *)model{
    _model = model;
    _numberLabel.text = _model.orderNo;
    _stateLabel.text = [self getOrderShouStatusString:_model.orderAfterStatus];
}
//根据订单状态码返回订单的状态值
-(NSString *)getOrderShouStatusString:(NSString *)orderStatus{
    //售后状态(1待审核，2用户待发货 3已通过，4已拒绝 5平台待收货)
    NSString *statusString = @"";
    if ([orderStatus intValue] == 1) {
        statusString = @"审核中";
        if( _model.afterType.integerValue == 1){//售后类型(1退货，2退款退货，3库存补发)
            statusString = @"退款中";
        }
    }else if ([orderStatus intValue] == 2 && _model.logisticStatus.integerValue == 2){
        statusString = @"退货退款";
    }else if ([orderStatus intValue] == 2 && _model.logisticStatus.integerValue == 1){
        statusString = @"退货退款";
    }else if ([orderStatus intValue] == 3){
        statusString = @"退款成功";
        if(_model.afterType.integerValue == 3){
            statusString = @"库存补发成功";
        }
    }else if ([orderStatus intValue] == 4){
        statusString = @"售后失败";
    }else if ([orderStatus intValue] == 5){
        statusString = @"商家待收货";
    }else if ([orderStatus intValue] == 6){
        statusString = @"售后取消";
    }
    
    return statusString;
}
-(void)setOrderModel:(LLMeOrderListModel *)orderModel{
    _orderModel = orderModel;
    _numberLabel.text = _orderModel.orderNo;
    
    
    if ([_orderModel.orderType intValue] == 1 && [_orderModel.expressType intValue] == 2) {
        //零售区。同城配送
        if([_orderModel.orderStatus intValue] == 1){
            _stateLabel.text = @"待付款";
        }else if ( [_orderModel.taskStatus intValue] == 3 && [_orderModel.orderStatus intValue] == 2){
            _stateLabel.text = @"待提货";
        }else if ( [_orderModel.taskStatus intValue] == 2 && [_orderModel.orderStatus intValue] == 2){
            _stateLabel.text = @"待提货";
        }else if ([_orderModel.orderStatus intValue] == 4){
            _stateLabel.text = @"待评价";
        }else if ([_orderModel.orderStatus intValue] == 7){
            _stateLabel.text = @"已完成";
        }else if ([_orderModel.orderStatus intValue] == 6){
            _stateLabel.text = @"已关闭";
        }else if ([_orderModel.orderStatus intValue] == 5){
            _stateLabel.text = @"售后中";
        }
        
    }else if([orderModel.orderType intValue] == 3){
        //品鉴商品
        NSString *taskStatus = _orderModel.taskStatus;
        
        //taskStatus 接单状态（1待支付、2待接单、3已接单/配送中/待提货、4已完成、5已转单
        //orderStatus 订单状态（状态：1待付款，2待发货，3待收货，4已收货/待评价，5售后中，6已取消，7已完成）
        if ([taskStatus intValue] == 2 && _orderModel.orderStatus.integerValue == 2) {
            _stateLabel.text = @"待接单";
        }else if ([taskStatus intValue] == 3){
            _stateLabel.text = @"待提货";
        }else if ([taskStatus intValue] == 5 && _orderModel.orderStatus.integerValue == 2){
            _stateLabel.text = @"待接单";
        }else if ([_orderModel.orderStatus intValue] == 4){
            _stateLabel.text = @"待评价";
        }else if ([_orderModel.orderStatus intValue] == 7){
            _stateLabel.text = @"已完成";
        }else if ([_orderModel.orderStatus intValue] == 6){
            _stateLabel.text = @"交易关闭，取消订单";
        }else if ([taskStatus intValue] == 1 ){
            _stateLabel.text = @"待付款";
        }
    }else{
        _stateLabel.text = [self getOrderStatusString:orderModel.orderStatus];
    }
}
//根据订单状态码返回订单的状态值
-(NSString *)getOrderStatusString:(NSString *)orderStatus{
    //售后状态(1待审核，2待收货，3已通过，4已拒绝)
    NSString *statusString = @"";
    if ([orderStatus intValue] == 1) {
        statusString = @"待付款";
    }else if ([orderStatus intValue] == 2){
        statusString = @"待发货";
//        if(_model.orderType.integerValue == 4 && _model.taskStatus.integerValue == 2){
//            statusString = @"待提货";
//        }
    }else if ([orderStatus intValue] == 3){
        statusString = @"待收货";
    }else if ([orderStatus intValue] == 4){
        statusString = @"待评价";
    }else if ([orderStatus intValue] == 5){
        statusString = @"售后中";
    }else if ([orderStatus intValue] == 6){
        statusString = @"交易关闭，取消订单";
    }else if ([orderStatus intValue] == 7){
        statusString = @"已完成";
    }
    
    return statusString;
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), CGFloatBasedI375(10), SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(44))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0x443415);
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _numberLabel.text = @"20210715040210005";
    }
    return _numberLabel;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = UIColorFromRGB(0xD40006);
        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _stateLabel.text = @"已完成";
    }
    return _stateLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

@end




@interface LLMeOrderFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *realLabel;
@property (nonatomic,strong)UILabel *realNoteLabel;
@property (nonatomic,strong)UILabel *realTitleLabel;
@property (nonatomic,strong)UILabel *totalLabel;
@property (nonatomic,strong)UILabel *totalNoteLabel;
@property (nonatomic,strong)UILabel *totalTitleLabel;


@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *centerBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UILabel *verificationLabel;//核销码


@end

@implementation LLMeOrderFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    
    [self.bottomView addSubview:self.realLabel];
    [self.bottomView addSubview:self.realNoteLabel];
    [self.bottomView addSubview:self.realTitleLabel];
    [self.bottomView addSubview:self.totalLabel];
    [self.bottomView addSubview:self.totalNoteLabel];
    [self.bottomView addSubview:self.totalTitleLabel];
    [self.bottomView addSubview:self.verificationLabel];
    
    [self.verificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    [self.realLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.realNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.realLabel.mas_left).offset(CGFloatBasedI375(-2));
        make.centerY.mas_equalTo(self.realLabel);
    }];

    [self.realTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.realNoteLabel.mas_left).offset(CGFloatBasedI375(-4));
        make.centerY.mas_equalTo(self.realLabel);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];

    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.realTitleLabel.mas_left).offset(CGFloatBasedI375(-10));
        make.centerY.mas_equalTo(self.realLabel);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.totalNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.totalLabel.mas_left).offset(CGFloatBasedI375(-2));
        make.centerY.mas_equalTo(self.totalLabel);
    }];
    
    [self.totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.totalNoteLabel.mas_left).offset(CGFloatBasedI375(-4));
        make.centerY.mas_equalTo(self.realLabel);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.bottomView addSubview:self.leftBtn];
    [self.bottomView addSubview:self.centerBtn];
    [self.bottomView addSubview:self.rightBtn];

    
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-105));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-195));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    
    
    self.leftBtn.hidden = YES;
    self.centerBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.verificationLabel.hidden = YES;
    
}
#pragma mark--footerOrderBtnClick
-(void)footerOrderBtnClick:(UIButton *)btn{
    if(self.ActionBlock){
        self.ActionBlock(btn.titleLabel.text, _orderModel);
    }
}

-(void)tapAction:(UITapGestureRecognizer *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _orderModel.writeCode;
}
-(void)setOrderModel:(LLMeOrderListModel *)orderModel{
    
    _orderModel = orderModel;
    
    NSString *totalPrice = _orderModel.totalPrice;
    NSString *actualPrice = _orderModel.actualPrice;
    NSString *writeCode = _orderModel.writeCode;
    
    _realLabel.text = actualPrice;
    _totalLabel.text = totalPrice;

    _verificationLabel.text = [NSString stringWithFormat:@"核销码:%@",writeCode];
    _rightBtn.hidden = NO;
    _realLabel.hidden = NO;
    _totalLabel.hidden = NO;
    _realTitleLabel.hidden = NO;
    _realNoteLabel.hidden = NO;
    _totalNoteLabel.hidden = NO;
    _totalTitleLabel.hidden = NO;
    if ([orderModel.orderType intValue] == 1 && [orderModel.expressType intValue] == 2) {
        //零售区。同城配送
        [self retailDistrictAndCityFooterViewStatus:orderModel.orderStatus];
        
    }else if([orderModel.orderType intValue] == 3){
        //品鉴商品
        [self examineGoodsFooterViewStatus:orderModel.orderStatus];
        
    }else{
        
        if ([orderModel.orderStatus intValue] == 1) {
            //待付款
            self.realTitleLabel.text = @"待付款";
            _leftBtn.hidden = YES;
            _centerBtn.hidden = NO;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_centerBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
            
            [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
            
        }else if ([orderModel.orderStatus  intValue] == 2){
            //待发货
            
            _leftBtn.hidden = YES;
            _centerBtn.hidden = YES;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            if(orderModel.orderType.integerValue == 2 && orderModel.orderStatus.integerValue == 2){
                _rightBtn.hidden = YES;
                _realLabel.hidden = YES;
                _totalLabel.hidden = YES;
                _realTitleLabel.hidden = YES;
                _realNoteLabel.hidden = YES;
                _totalNoteLabel.hidden = YES;
                _totalTitleLabel.hidden = YES;
                self.bottomView.height = CGFloatBasedI375(10);
                UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

               CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
               cornerRadiusLayer.frame = self.bottomView.bounds;
                cornerRadiusLayer.path = cornerRadiusPath.CGPath;
                self.bottomView.layer.mask = cornerRadiusLayer;
                
            }
            if(_orderModel.stockNum > 0){
                [_rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            }
            if(!_orderModel.isAfter){
                _rightBtn.hidden = YES;
            }
        }else if ([orderModel.orderStatus  intValue] == 3){
            //待收货
            
            _leftBtn.hidden = NO;
            _centerBtn.hidden = NO;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
            if(!_orderModel.isAfter){
                _leftBtn.hidden = YES;
            }
        }else if ([orderModel.orderStatus  intValue] == 4){
            //待评价
            
            _leftBtn.hidden = YES;
            _centerBtn.hidden = NO;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
            if(_orderModel.orderType.integerValue == 4){//售后状态(1待审核，2用户待发货 3已通过，4已拒绝 5平台待收货)
                if(_orderModel.orderAfterStatus.integerValue == 1){
                    [_leftBtn setTitle:@"审核中" forState:UIControlStateNormal];
                }else if(_orderModel.orderAfterStatus.integerValue == 2){
                    [_leftBtn setTitle:@"用户待发货" forState:UIControlStateNormal];
                }else if(_orderModel.orderAfterStatus.integerValue == 3){
                    [_leftBtn setTitle:@"售后成功" forState:UIControlStateNormal];
                }else if(_orderModel.orderAfterStatus.integerValue == 4){
                    [_leftBtn setTitle:@"售后拒绝" forState:UIControlStateNormal];
                }else if(_orderModel.orderAfterStatus.integerValue == 5){
                    [_leftBtn setTitle:@"平台待收货" forState:UIControlStateNormal];
                }
                _centerBtn.hidden = YES;
                _leftBtn.hidden = YES;
            }
            
            if(!_orderModel.isAfter){
                _leftBtn.hidden = YES;
            }
        }else if ([orderModel.orderStatus  intValue] == 5){
            //售后中
            
            _leftBtn.hidden = YES;
            _centerBtn.hidden = YES;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_rightBtn setTitle:@"售后中" forState:UIControlStateNormal];
//            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
//            [_rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            if(_orderModel.orderAfterStatus.integerValue == 1){//售后状态(1待审核，2待收货，3已通过，4已拒绝)
                [_rightBtn setTitle:@"审核中" forState:UIControlStateNormal];
                if(_orderModel.afterType.integerValue == 1){//售后类型(1退货，2退款退货，3库存补发)
                    [_rightBtn setTitle:@"退款中" forState:UIControlStateNormal];
                }else{
                    [_rightBtn setTitle:@"审核中" forState:UIControlStateNormal];
                }
            }else if(_orderModel.orderAfterStatus.integerValue == 2){
                [_rightBtn setTitle:@"待收货" forState:UIControlStateNormal];
            }else if(_orderModel.orderAfterStatus.integerValue == 3){
                [_rightBtn setTitle:@"退款中" forState:UIControlStateNormal];
            }else if(_orderModel.orderAfterStatus.integerValue == 4){
                [_rightBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
            }else if(_orderModel.orderAfterStatus.integerValue == 5){
                [_rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            }
            if(orderModel.orderType.integerValue == 2 && orderModel.orderStatus.integerValue == 5){
                _rightBtn.hidden = YES;
                _realLabel.hidden = YES;
                _totalLabel.hidden = YES;
                _realTitleLabel.hidden = YES;
                _realNoteLabel.hidden = YES;
                _totalNoteLabel.hidden = YES;
                _totalTitleLabel.hidden = YES;
                self.bottomView.height = CGFloatBasedI375(10);
                UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

               CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
               cornerRadiusLayer.frame = self.bottomView.bounds;
                cornerRadiusLayer.path = cornerRadiusPath.CGPath;
                self.bottomView.layer.mask = cornerRadiusLayer;
                
            }
            if(!_orderModel.isAfter){
                _leftBtn.hidden = YES;
            }
        }else if ([orderModel.orderStatus  intValue] == 6){
            //已取消

            _leftBtn.hidden = YES;
            _centerBtn.hidden = YES;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            
        }else if ([orderModel.orderStatus  intValue] == 7){
           //已完成
            
            _leftBtn.hidden = NO;
            _centerBtn.hidden = NO;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_leftBtn setTitle:@"申请开票" forState:UIControlStateNormal];
            if(_orderModel.invoiceStatus.integerValue == 1){
                [_leftBtn setTitle:@"申请开票" forState:UIControlStateNormal];
            }else if(_orderModel.invoiceStatus.integerValue == 2){
                [_leftBtn setTitle:@"开票中" forState:UIControlStateNormal];
            }else if(_orderModel.invoiceStatus.integerValue == 3){
                [_leftBtn setTitle:@"已开票" forState:UIControlStateNormal];
            }else if(_orderModel.invoiceStatus.integerValue == 4){
                [_leftBtn setTitle:@"开票不通过" forState:UIControlStateNormal];
            }
            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            if(_orderModel.orderType.integerValue == 4){
                _leftBtn.hidden = YES;
                [_centerBtn setTitle:@"申请开票" forState:UIControlStateNormal];
                [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            }
        }
    }
    _realLabel.hidden = NO;
    _totalLabel.hidden = NO;
    if(_orderModel.orderType.integerValue == 2){//惊喜红包
        _rightBtn.hidden = YES;
        _realLabel.hidden = YES;
        _totalLabel.hidden = YES;
        _realTitleLabel.hidden = YES;
        _realNoteLabel.hidden = YES;
        _totalNoteLabel.hidden = YES;
        _totalTitleLabel.hidden = YES;
        if(_orderModel.orderStatus.integerValue == 2){//待发货
            _leftBtn.hidden = YES;
            _centerBtn.hidden = YES;
            _rightBtn.hidden = YES;
            _verificationLabel.hidden = YES;
        }else if(_orderModel.orderStatus.integerValue == 4){//待评价
            _leftBtn.hidden = YES;
            _centerBtn.hidden = NO;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            
            [_leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
            self.bottomView.height = CGFloatBasedI375(64);
            if(!_orderModel.isAfter){
                _leftBtn.hidden = YES;
            }
        }else if(_orderModel.orderStatus.integerValue == 3){//待收货
            _leftBtn.hidden = NO;
            _centerBtn.hidden = NO;
            _rightBtn.hidden = NO;
            _verificationLabel.hidden = YES;
            [_leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
            self.bottomView.height = CGFloatBasedI375(64);
            if(!_orderModel.isAfter){
                _leftBtn.hidden = YES;
            }
        }else if ([_orderModel.orderStatus  intValue] == 7){
            //已完成
            self.bottomView.height = CGFloatBasedI375(64);
             _leftBtn.hidden = NO;
             _centerBtn.hidden = NO;
             _rightBtn.hidden = NO;
             _verificationLabel.hidden = YES;
             
             [_leftBtn setTitle:@"申请开票" forState:UIControlStateNormal];
             if(_orderModel.invoiceStatus.integerValue == 1){
                 [_leftBtn setTitle:@"申请开票" forState:UIControlStateNormal];
             }else if(_orderModel.invoiceStatus.integerValue == 2){
                 [_leftBtn setTitle:@"开票中" forState:UIControlStateNormal];
             }else if(_orderModel.invoiceStatus.integerValue == 3){
                 [_leftBtn setTitle:@"已开票" forState:UIControlStateNormal];
             }else if(_orderModel.invoiceStatus.integerValue == 4){
                 [_leftBtn setTitle:@"开票不通过" forState:UIControlStateNormal];
             }
             [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
             [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
             [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
             _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            
         }
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];
       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
 
        
    }
}


#pragma mark--零售区同城配送商品
-(void)retailDistrictAndCityFooterViewStatus:(NSString *)orderStatus{
    
    if ([orderStatus intValue] == 1) {
        //待付款
        
        _leftBtn.hidden = YES;
        _centerBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        self.realTitleLabel.text = @"待付款";
        [_centerBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        
    }else if([orderStatus intValue] == 3 || [orderStatus intValue] == 2){
        //待提货
        
        _leftBtn.hidden = YES;
        _centerBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = NO;
        
        [_centerBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"联系推广点" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        
        
    }else if ([orderStatus intValue] == 4){
        //待评价
        
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        [_rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        
    }else if ([orderStatus intValue] == 7){
        //已完成
        
        _leftBtn.hidden = YES;
        _centerBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = NO;
        //invoiceStatus 开票状态（1未开票，2开票中，3已开票，4不通过）
        if(_orderModel.invoiceStatus.integerValue == 1){
            [_centerBtn setTitle:@"申请开票" forState:UIControlStateNormal];
        }else if(_orderModel.invoiceStatus.integerValue == 2){
            [_centerBtn setTitle:@"开票中" forState:UIControlStateNormal];
        }else if(_orderModel.invoiceStatus.integerValue == 3){
            [_centerBtn setTitle:@"已开票" forState:UIControlStateNormal];
        }else if(_orderModel.invoiceStatus.integerValue == 4){
            [_centerBtn setTitle:@"开票不通过" forState:UIControlStateNormal];
        }
        [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
    }else if ([orderStatus intValue] == 6){
        //取消
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = NO;
        [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
    }else if ([orderStatus  intValue] == 5){
        //售后中
        
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
//            [_centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
//            [_rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
        if(!_orderModel.isAfter){
            _rightBtn.hidden = YES;
        }
    }else if ([orderStatus intValue] == 2 && [_orderModel.taskStatus intValue] == 3) {
        //待接单
        _leftBtn.hidden = YES;
        _centerBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = NO;
        [self.rightBtn setTitle:@"联系推广员" forState:UIControlStateNormal];
        [self.centerBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        self.rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        self.rightBtn.layer.borderWidth = CGFloatBasedI375(1);
        [self.rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
//        [_rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        if(!_orderModel.isAfter){
            self.centerBtn.hidden = YES;
        }
    }
}
#pragma mark--品鉴商品
-(void)examineGoodsFooterViewStatus:(NSString *)orderStatus{
    NSLog(@"orderStatus == %@",orderStatus);
    NSString *taskStatus = _orderModel.taskStatus;
    //taskStatus 接单状态（1待支付、2待接单、3已接单/配送中/待提货、4已完成、5已转单
    //orderStatus 订单状态（状态：1待付款，2待发货，3待收货，4已收货/待评价，5售后中，6已取消，7已完成）
    if (([taskStatus intValue] == 2 ||[taskStatus intValue] == 5 ) && _orderModel.orderStatus.integerValue == 2) {
        //待接单
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        if(_orderModel.stockNum > 0){
            [_rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        }
        if(!_orderModel.isAfter){
            self.rightBtn.hidden = YES;
        }
    }else if ([taskStatus intValue] == 1 && _orderModel.orderStatus.integerValue != 6) {
        //待付款
        self.realTitleLabel.text = @"待付款";
        _leftBtn.hidden = YES;
        _centerBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_centerBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        
    }else if (_orderModel.orderStatus.integerValue == 5) {
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_rightBtn setTitle:@"售后中" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
    }else if ([taskStatus intValue] == 3){
        //待提货
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = NO;
        
        [_rightBtn setTitle:@"联系配送员" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        if(_orderModel.shopTelePhone.length > 0){
            [_rightBtn setTitle:@"联系推广员" forState:UIControlStateNormal];
        }
        if(_orderModel.clerkTelePhone.length > 0){
            [_rightBtn setTitle:@"联系配送员" forState:UIControlStateNormal];
        }
    }else if ([taskStatus intValue] == 4 ){//已完成
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        
    }else if ([_orderModel.orderStatus intValue] == 7){
        //已完成
        _leftBtn.hidden = YES;
        _centerBtn.hidden = NO;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_centerBtn setTitle:@"申请开票" forState:UIControlStateNormal];
        if(_orderModel.invoiceStatus.integerValue == 1){
            [_centerBtn setTitle:@"申请开票" forState:UIControlStateNormal];
        }else if(_orderModel.invoiceStatus.integerValue == 2){
            [_centerBtn setTitle:@"开票中" forState:UIControlStateNormal];
        }else if(_orderModel.invoiceStatus.integerValue == 3){
            [_centerBtn setTitle:@"已开票" forState:UIControlStateNormal];
        }else if(_orderModel.invoiceStatus.integerValue == 4){
            [_centerBtn setTitle:@"开票不通过" forState:UIControlStateNormal];
        }
        [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
    }else if ([_orderModel.orderStatus intValue] == 6){
        //已完成
        _leftBtn.hidden = YES;
        _centerBtn.hidden = YES;
        _rightBtn.hidden = NO;
        _verificationLabel.hidden = YES;
        
        [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
    }
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), 0, SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(88))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
#pragma mark--lazy
-(UILabel *)realLabel{
    if (!_realLabel) {
        _realLabel = [[UILabel alloc]init];
        _realLabel.textColor = UIColorFromRGB(0x443415);
        _realLabel.textAlignment = NSTextAlignmentCenter;
        _realLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _realLabel.text = @"119.00";
    }
    return _realLabel;
}
-(UILabel *)realNoteLabel{
    if (!_realNoteLabel) {
        _realNoteLabel = [[UILabel alloc]init];
        _realNoteLabel.textColor = UIColorFromRGB(0x443415);
        _realNoteLabel.textAlignment = NSTextAlignmentCenter;
        _realNoteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _realNoteLabel.text = @"¥";
    }
    return _realNoteLabel;
}
-(UILabel *)realTitleLabel{
    if (!_realTitleLabel) {
        _realTitleLabel = [[UILabel alloc]init];
        _realTitleLabel.textColor = UIColorFromRGB(0x443415);
        _realTitleLabel.textAlignment = NSTextAlignmentCenter;
        _realTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _realTitleLabel.text = @"实付款";
    }
    return _realTitleLabel;
}

-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]init];
        _totalLabel.textColor = UIColorFromRGB(0x999999);
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _totalLabel.text = @"119.00";
    }
    return _totalLabel;
}
-(UILabel *)totalNoteLabel{
    if (!_totalNoteLabel) {
        _totalNoteLabel = [[UILabel alloc]init];
        _totalNoteLabel.textColor = UIColorFromRGB(0x999999);
        _totalNoteLabel.textAlignment = NSTextAlignmentCenter;
        _totalNoteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _totalNoteLabel.text = @"¥";
    }
    return _totalNoteLabel;
}
-(UILabel *)totalTitleLabel{
    if (!_totalTitleLabel) {
        _totalTitleLabel = [[UILabel alloc]init];
        _totalTitleLabel.textColor = UIColorFromRGB(0x443415);
        _totalTitleLabel.textAlignment = NSTextAlignmentCenter;
        _totalTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _totalTitleLabel.text = @"总价";
    }
    return _totalTitleLabel;
}

-(UILabel *)verificationLabel{
    if (!_verificationLabel) {
        _verificationLabel = [[UILabel alloc]init];
        _verificationLabel.textColor = UIColorFromRGB(0x443415);
        _verificationLabel.textAlignment = NSTextAlignmentCenter;
        _verificationLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _verificationLabel.text = @"核销码:";
        _verificationLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_verificationLabel addGestureRecognizer:tap];
    }
    return _verificationLabel;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_leftBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _leftBtn.clipsToBounds = YES;
        _leftBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _leftBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _leftBtn;
}

-(UIButton *)centerBtn{
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.backgroundColor = [UIColor whiteColor];
        _centerBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_centerBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _centerBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _centerBtn.clipsToBounds = YES;
        _centerBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _centerBtn.layer.borderWidth = CGFloatBasedI375(1);
        [_centerBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];

    }
    return _centerBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_rightBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _rightBtn.clipsToBounds = YES;
        _rightBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _rightBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _rightBtn;
}


@end






@interface LLMeOrderAfterFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *lookDetailBtn;
@property (nonatomic,strong)UIButton *lookDetailBtn1;

@end

@implementation LLMeOrderAfterFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.lookDetailBtn];
    [self.bottomView addSubview:self.lookDetailBtn1];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.lookDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    [self.lookDetailBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lookDetailBtn.mas_left).mas_equalTo(-CGFloatBasedI375(10));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
}
#pragma mark--footerOrderBtnClick
-(void)footerOrderBtnClick:(UIButton *)btn{
    if(self.ActionBlock){
        self.ActionBlock(btn.titleLabel.text, _orderModel);
    }
}
/*
 待审核--审核中
 退款成功，退货退款成功，库存不发成功--已通过
 待收货- 退货退款申请通过-需要进去填写快递信息-然后再次提交
 已拒绝-售后失败  
 */
-(void)setOrderModel:(LLMeOrderListModel *)orderModel{
    _orderModel = orderModel;//售后状态(1待审核，2待收货，3已通过，4已拒绝)
    self.lookDetailBtn1.hidden = YES;
    self.lookDetailBtn.userInteractionEnabled = YES;
    if(_orderModel.orderAfterStatus.integerValue == 1){
        self.lookDetailBtn1.hidden = NO;
        [self.lookDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [self.lookDetailBtn1 setTitle:@"取消售后" forState:UIControlStateNormal];
        self.titleLabel.text = @"商家审核中,请耐心等待...";
    }else if(_orderModel.orderAfterStatus.integerValue == 2 && _orderModel.logisticStatus.integerValue == 2){
        [self.lookDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.titleLabel.text = @"卖家已同意退货退款，请买家退货";
    }else if(_orderModel.orderAfterStatus.integerValue == 2 && _orderModel.logisticStatus.integerValue == 1){
        [self.lookDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.titleLabel.text = @"卖家已同意退货退款，请买家退货";
        self.lookDetailBtn1.hidden = NO;
    }else if(_orderModel.orderAfterStatus.integerValue == 3){
        self.lookDetailBtn1.hidden = NO;
        [self.lookDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.titleLabel.text = @"退款成功，退款金额已原路返回";
        if(_orderModel.afterType.integerValue == 3){
            self.titleLabel.text = @"库存补发成功，请到我的库存中查看";
        }
    }else if(_orderModel.orderAfterStatus.integerValue == 4){
        self.lookDetailBtn1.hidden = NO;
        [self.lookDetailBtn setTitle:@"重新申请" forState:UIControlStateNormal];
        self.titleLabel.text = FORMAT(@"售后失败原因: %@",_orderModel.refuseReason);
    }else if ([_orderModel.orderAfterStatus intValue] == 5){
        [self.lookDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.titleLabel.text = @"买家已发货,待商家确认收货";
    }else if ([_orderModel.orderAfterStatus intValue] == 6){
        [self.lookDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.titleLabel.text = @"买家已取消售后";
    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), 0, SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(88))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];

    }
    return _titleLabel;
}
-(UIButton *)lookDetailBtn{
    if (!_lookDetailBtn) {
        _lookDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookDetailBtn.backgroundColor = [UIColor whiteColor];
        [_lookDetailBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [_lookDetailBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _lookDetailBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_lookDetailBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _lookDetailBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _lookDetailBtn.clipsToBounds = YES;
        _lookDetailBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _lookDetailBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _lookDetailBtn;
}
-(UIButton *)lookDetailBtn1{
    if (!_lookDetailBtn1) {
        _lookDetailBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookDetailBtn1.backgroundColor = [UIColor whiteColor];
        [_lookDetailBtn1 setTitle:@"删除记录" forState:UIControlStateNormal];
        [_lookDetailBtn1 setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _lookDetailBtn1.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_lookDetailBtn1 addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _lookDetailBtn1.layer.cornerRadius = CGFloatBasedI375(15);
        _lookDetailBtn1.clipsToBounds = YES;
        _lookDetailBtn1.hidden = YES;
        _lookDetailBtn1.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _lookDetailBtn1.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _lookDetailBtn1;
}
@end
@interface LLAlertShowView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *backView;/** <#class#> **/
@property (nonatomic,strong) UILabel *titleLable;/** <#class#> **/
@property (nonatomic,strong) UILabel *noticeLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView1;/** <#class#> **/
@property (nonatomic,strong) UILabel *priceLabel;/** <#class#> **/

@end
@implementation LLAlertShowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setLayout];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];;
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

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(30));
        make.right.offset(-CGFloatBasedI375(30));
        make.height.offset(CGFloatBasedI375(220));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.offset(CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(30));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(30));
        make.top.mas_equalTo(self.noticeLabel.mas_bottom).offset(CGFloatBasedI375(5));

    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(CGFloatBasedI375(5));
        make.bottom.mas_equalTo(self.lineView1.mas_top).offset(CGFloatBasedI375(0));

    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(CGFloatBasedI375(0));
        make.bottom.offset(-CGFloatBasedI375(60));
        make.height.offset(CGFloatBasedI375(1));
    }];
    [self.sureBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset((SCREEN_WIDTH-CGFloatBasedI375(30))/2);
        make.bottom.offset(0);
        make.height.offset(CGFloatBasedI375(60));
    }];

    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.offset((SCREEN_WIDTH-CGFloatBasedI375(30))/2);
        make.bottom.offset(0);
        make.height.offset(CGFloatBasedI375(60));
    }];
//    self.sureBtn1.backgroundColor = Red_Color;
}
-(void)setDatas:(NSDictionary *)datas{
    _datas = datas;

}
-(void)getData{//获取配送服务
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *ulrl = @"AppExpress5_10AddService";
    if(_model.feePriceSize == 1){
        ulrl = @"AppExpress10_15AddService";
    }
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,ulrl) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        NSLog(@"data == %@",responseObj[@"data"]);
        [self ceatDtas:data];
//        self.datas = data;
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}
-(void)setModel:(LLMeOrderDetailModel *)model{
    _model = model;
    
    [self getData];


}
-(void)ceatDtas:(NSDictionary *)data{
    if(data){
        self.priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",[data[@"content"] floatValue])] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(14)], [UIFont boldFontWithFontSize:CGFloatBasedI375(18)]] colors:@[ Black_Color, Black_Color]];
        NSString *noticesl = @"5KM";
        NSString *noticesl1 = @"5-10KM";

        if(_model.feePriceSize == 0){//当前收货地址在5KM服务范围内￥0.00元配送费；
            noticesl = @"5KM";
            noticesl1 = @"5-10KM";
            self.titleLable.attributedText = [self getAttribuStrWithStrings:@[@"当前定位地址",noticesl,@"范围内无人接单,是否",FORMAT(@"加价%.2f元",[data[@"content"] floatValue]),@"开启",noticesl1,@"服务范围内配送；接单后预计",@"40-60分钟",@"内送达"] colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color]];
        }else if(_model.feePriceSize == 1){//当前收货地址在5-10KM服务范围内加价￥10.00元配送费；
             noticesl = @"5-10KM";
            noticesl1 = @"10-15KM";
            self.titleLable.attributedText = [self getAttribuStrWithStrings:@[@"当前定位地址",noticesl,@"范围内无人接单,是否",FORMAT(@"加价%.2f元",[data[@"content"] floatValue]),@"开启",noticesl1,@"服务范围内配送；接单后预计",@"60-90分钟",@"内送达"] colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color]];
        }else{
            _noticeLabel.text = @"温馨提示";
            noticesl = @"15KM";
           noticesl1 = @"10-15KM";
            self.titleLable.attributedText = [self getAttribuStrWithStrings:@[@" 超出",noticesl,@"范围或还是没人接单，订单自动取消并原路返回支付金额"] colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color]];
            self.sureBtn.hidden = YES;
            self.priceLabel.hidden = YES;
            [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(CGFloatBasedI375(30));
                make.right.offset(-CGFloatBasedI375(30));
                make.height.offset(CGFloatBasedI375(200));
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
            }];
            [self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(CGFloatBasedI375(30));
                make.right.offset(-CGFloatBasedI375(30));
                make.top.mas_equalTo(self.noticeLabel.mas_bottom).offset(CGFloatBasedI375(15));
//                make.bottom.mas_equalTo(self.lineView1.mas_top).offset(CGFloatBasedI375(0));

            }];
            [self.sureBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
                make.bottom.offset(0);
                make.height.offset(CGFloatBasedI375(60));
            }];
            
        }
        
     
    }
}

-(UIView *)backView{
    if(!_backView){
        _backView  = [[UIView alloc]init];
                _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius =5;
        [self addSubview: self.backView];
        _backView.backgroundColor = [UIColor whiteColor];

    }
    return _backView;
}

-(UILabel *)noticeLabel{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(15)];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.text = @"是否加价配送";
        _noticeLabel.textColor = BlackTitleFont443415;
        [self.backView addSubview:self.noticeLabel];
        
    }
    return _noticeLabel;
}
-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(15)];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = [UIColor blackColor];
        [self.backView addSubview:self.priceLabel];
        
    }
    return _priceLabel;
}
-(UILabel *)titleLable{
    if(!_titleLable){
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor blackColor];
        [self.backView addSubview:self.titleLable];
        _titleLable.numberOfLines = 0;
    }
    return _titleLable;
}
-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"支付" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:Main_Color forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];;
        [self.backView addSubview: self.sureBtn];
    }
    return _sureBtn;
}
-(UIButton *)sureBtn1{
    if(!_sureBtn1){
        _sureBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn1 setTitle:@"取消" forState:UIControlStateNormal];
        [_sureBtn1 setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _sureBtn1.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];;
        [self.backView addSubview: self.sureBtn1];
    }
    return _sureBtn1;
}
-(void)backclick{

}
- (UIView *)lineView1{
    if(!_lineView1){
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = BG_Color;
        [self.backView addSubview:_lineView1];
    }
    return _lineView1;;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.backView addSubview:_lineView];
    }
    return _lineView;;
}

/********************  Animation  *******************/

- (void)showActionSheetView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [self layoutIfNeeded];
    
    CGRect tempFrame = self.backView.frame;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            self.backView.frame = tempFrame;
        }];
    }];
}

- (void)hideActionSheetView {
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25f animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
    }];
}
@end
