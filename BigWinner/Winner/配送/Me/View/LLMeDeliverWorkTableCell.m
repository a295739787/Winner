//
//  LLMeDeliverWorkTableCell.m
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import "LLMeDeliverWorkTableCell.h"
#import "LLMoudleButton.h"

@interface LLMeDeliverWorkTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *rightImg;
@property (nonatomic,strong)UIView *topLine;
@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation LLMeDeliverWorkTableCell

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
    [self.bottomView addSubview:self.topLine];
    [self.bottomView addSubview:self.bottomLine];
   
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.top.bottom.mas_equalTo(0);
    }];
    
    
    
    NSArray *titleArray = @[@"累计完成配送",@"累计任务佣金"];
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / 2;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        [[self.bottomView viewWithTag:100 + i] removeFromSuperview];
        
        LLMoudleButton *moudleBtn = [LLMoudleButton buttonWithType:UIButtonTypeCustom];
        moudleBtn.frame = CGRectMake(btnWidth * i, 0, btnWidth, CGFloatBasedI375(80));
        moudleBtn.tag = 100 + i;
        [moudleBtn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        moudleBtn.textStr = titleArray[i];
        moudleBtn.countStr = @"0";
        if (i > 0) {
            moudleBtn.countLabel.font = [UIFont dinFontWithFontSize:16];
        }
        [self.bottomView addSubview:moudleBtn];
    }
    
    
    NSArray *stockArray = @[@"配送库存",@"分享好友"];
    NSArray *imgArray = @[@"wdpskc",@"wdtg"];
    CGFloat stockBtnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / 2;
    for (int i = 0; i < stockArray.count; i++) {
        
        [[self.bottomView viewWithTag:200 + i] removeFromSuperview];
        
        LLMeStockButton * stockBtn = [LLMeStockButton buttonWithType:UIButtonTypeCustom];
        stockBtn.frame = CGRectMake(stockBtnWidth * i, CGFloatBasedI375(80), stockBtnWidth, CGFloatBasedI375(60));
        stockBtn.tag = 200 + i;
        stockBtn.textStr = stockArray[i];
        stockBtn.countStr = @"0";
        stockBtn.imgStr = imgArray[i];
        [stockBtn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:stockBtn];
    }
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.bottom.mas_equalTo(CGFloatBasedI375(-20));
        make.height.mas_equalTo(CGFloatBasedI375(20));
        make.width.mas_equalTo(0.5);
    }];
    
    
    [self.bottomView addSubview:self.rightImg];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.width.height.mas_equalTo(CGFloatBasedI375(34));
    }];
}
-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    
   //累计完成配送
    NSString *cumulativeDeliveryNum = [personalModel.cumulativeDeliveryNum length] > 0 ? personalModel.cumulativeDeliveryNum : @"0";
   //累计任务佣金
    NSString *accumulatedCommissionPrice = [personalModel.accumulatedCommissionPrice length] > 0 ? personalModel.accumulatedCommissionPrice : @"0";
    
    for (int i = 0; i < 2; i++) {
        LLMoudleButton *moudleBtn = [self.bottomView viewWithTag:100 + i];
        if (i == 0) {
//            moudleBtn.countStr = cumulativeDeliveryNum;
            moudleBtn.countLabel.text = cumulativeDeliveryNum;
        }else{
            moudleBtn.countStr = accumulatedCommissionPrice;
        }
    }
    
    
    //配送库存
    NSString *distStockNum = [personalModel.distStockNum length] > 0 ? personalModel.distStockNum : @"0";
    //分享好友 
    NSString *promotionPrice = [personalModel.promotionUserNum length] > 0 ? personalModel.promotionUserNum : @"0";
    
    for (int i = 0; i < 2; i++) {
        LLMeStockButton * stockBtn = [self.bottomView viewWithTag:200 + i];
        if (i == 0) {
            stockBtn.countStr = distStockNum;
        }else{
            stockBtn.countStr = @"";
        }
    }
    
}
#pragma mark--sectionBtnClick && sectionBtnClick
-(void)sectionBtnClick:(UIButton *)btn{
    if (self.deliverMoudleBlock) {
        self.deliverMoudleBlock(btn.tag);
    }
}
-(void)tap{
    
    if (self.deliverMoudleBlock) {
        self.deliverMoudleBlock(1000);
    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}
-(UIImageView *)rightImg{
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc]init];
        _rightImg.backgroundColor = [UIColor whiteColor];
        _rightImg.image = [UIImage imageNamed:@"sm"];
        _rightImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.numberOfTapsRequired = 1;
        [_rightImg addGestureRecognizer:tap];
    }
    return _rightImg;
}
-(UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    }
    return _topLine;
}
-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    }
    return _bottomLine;
}

@end




@interface LLMeDeliverOrderTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)LLMeOrderHeaderButton *headerBtn;

@end

@implementation LLMeDeliverOrderTableCell

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
    [self.bottomView addSubview:self.headerBtn];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(42));
    }];
    
    NSArray *titleArray = @[@"待发货 ",@"待收货",@"已完成",@"售后"];
    NSArray *imgArray = @[@"dfh",@"dsh",@"ywc",@"sh"];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / titleArray.count;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        [[self.bottomView viewWithTag:100 + i] removeFromSuperview];
        
        LLMeOrderButton *orderBtn = [LLMeOrderButton buttonWithType:UIButtonTypeCustom];
        orderBtn.frame = CGRectMake(btnWidth * i, CGFloatBasedI375(42), btnWidth, CGFloatBasedI375(80));
        orderBtn.imgStr = imgArray[i];
        orderBtn.textStr = titleArray[i];
        orderBtn.tag = 100 + i;
        orderBtn.countStr = @"0";
        [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:orderBtn];
    }
}

-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    
    //待发货
    NSString *distStockStayDeliveryOrderNum = [personalModel.distStockStayDeliveryOrderNum length] > 0 ? personalModel.distStockStayDeliveryOrderNum : @"0";
    //待收货
    NSString *distStockStayReceivingOrderNum = [personalModel.distStockStayReceivingOrderNum length] > 0 ? personalModel.distStockStayReceivingOrderNum : @"0";
    //已完成
    NSString *distStockCompleteOrderNum = [personalModel.distStockCompleteOrderNum length] > 0 ? personalModel.distStockCompleteOrderNum : @"0";
    //售后
    NSString *distStayAfterOrderNum = [personalModel.distStayAfterOrderNum length] > 0 ? personalModel.distStayAfterOrderNum : @"0";
    
    self.headerBtn.titleStr = @"配送库存订单";
    
    for (int i = 0; i < 4; i++) {
        LLMeOrderButton *orderBtn = [self.bottomView viewWithTag:100 + i];
        if (i == 0) {
            orderBtn.countStr = distStockStayDeliveryOrderNum;
        }else if (i == 1){
            orderBtn.countStr = distStockStayReceivingOrderNum;
        }else if (i == 2){
//            orderBtn.countStr = distStockCompleteOrderNum;
            orderBtn.countStr = @"";
        }else if (i == 3){
            orderBtn.countStr = distStayAfterOrderNum;
        }
    }
}

#pragma mark--orderBtnClick
-(void)orderBtnClick:(UIButton *)btn{
    if (self.deliverOrderBlock) {
        self.deliverOrderBlock(btn.tag);
    }
}
#pragma mark--LLmeHeaderBtnBlock
-(void)LLmeHeaderBtnBlock{
    if (self.deliverOrderBlock) {
        self.deliverOrderBlock(200);
    }
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}
#pragma mark--lazy
-(LLMeOrderHeaderButton *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = [LLMeOrderHeaderButton buttonWithType:UIButtonTypeCustom];
        _headerBtn.titleStr = @"配送库存订单";
        [_headerBtn addTarget:self action:@selector(LLmeHeaderBtnBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}


@end
