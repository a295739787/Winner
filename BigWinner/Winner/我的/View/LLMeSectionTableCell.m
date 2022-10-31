//
//  LLMeSectionTableCell.m
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import "LLMeSectionTableCell.h"
#import "LLMoudleButton.h"


@interface LLMeSectionTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *rightImg;
@property (nonatomic,strong)UIView *topLine;
@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation LLMeSectionTableCell

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
    
    
    NSArray *titleArray = @[@"累计现金红包",@"累计消费红包",@"累计已到佣金"];
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / 3;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        [[self.bottomView viewWithTag:100 + i] removeFromSuperview];
        
        LLMoudleButton *moudleBtn = [LLMoudleButton buttonWithType:UIButtonTypeCustom];
        moudleBtn.frame = CGRectMake(btnWidth * i, 0, btnWidth, CGFloatBasedI375(80));
        moudleBtn.tag = 100 + i;
        [moudleBtn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        moudleBtn.textStr = titleArray[i];
        moudleBtn.countStr = @"0.00";
        [self.bottomView addSubview:moudleBtn];
    }
    
    [self.bottomView addSubview:self.rightImg];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.width.height.mas_equalTo(CGFloatBasedI375(34));
    }];
    
    NSArray *stockArray = @[@"我的库存",@"我的推广"];
    NSArray *imgArray = @[@"wdkc",@"wdtg"];
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
    
}
-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    _personalModel = personalModel;
    //累计现金红包
    NSString *totalCashRedPrice = [_personalModel.totalCashRedPrice length] > 0 ? _personalModel.totalCashRedPrice : @"0.00";
    //累计消费红包
    NSString *totalConsumeRedPrice = [_personalModel.totalConsumeRedPrice length] > 0  ? _personalModel.totalConsumeRedPrice : @"0.00";
    //累计推广佣金
    NSString *totalPromotionPrice = [_personalModel.totalPromotionPrice length] > 0 ? _personalModel.totalPromotionPrice : @"0.00";
    
    
    for (int i = 0; i < 3; i++) {
        LLMoudleButton *moudleBtn = [self.bottomView viewWithTag:100 + i];
        
        if (i == 0) {
            moudleBtn.countStr = totalCashRedPrice;
      
        }else if (i == 1){
            moudleBtn.countStr = totalConsumeRedPrice;//totalConsumeRedPrice
        }else{
            moudleBtn.countStr = totalPromotionPrice;
        }
    }
    
    //我得库存
    NSString *stock = [_personalModel.stock length] > 0 ? _personalModel.stock : @"0";
    //分享好友
    NSString *promotionUserNum = [_personalModel.promotionUserNum length] > 0 ? _personalModel.promotionUserNum : @"0";

    for (int i = 0; i < 2; i++) {
        LLMeStockButton * stockBtn = [self.bottomView viewWithTag:200 + i];
        if (i == 0) {
            stockBtn.countStr = stock;
        }else{
            stockBtn.countStr = @"";
            
        }
    }
}

#pragma mark--sectionBtnClick
-(void)sectionBtnClick:(UIButton *)btn{
    
    if (self.sectionBtnBlock) {
        self.sectionBtnBlock(btn.tag);
    }
}
-(void)tap{
    
    if (self.sectionBtnBlock) {
        self.sectionBtnBlock(0);
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



@interface LLMeOrderTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)LLMeOrderHeaderButton *headerBtn;

@end

@implementation LLMeOrderTableCell

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
    
    NSArray *titleArray = @[@"待付款",@"待发货 ",@"待收货",@"已完成",@"售后"];
    NSArray *imgArray = @[@"dfk",@"dfh",@"dsh",@"ywc",@"sh"];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / titleArray.count;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        [[self.bottomView viewWithTag:100 + i] removeFromSuperview];
        
        LLMeOrderButton *orderBtn = [LLMeOrderButton buttonWithType:UIButtonTypeCustom];
        orderBtn.frame = CGRectMake(btnWidth * i, CGFloatBasedI375(42), btnWidth, CGFloatBasedI375(80));
        orderBtn.imgStr = imgArray[i];
        orderBtn.textStr = titleArray[i];
        orderBtn.tag = 100 + i;
        
        [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:orderBtn];
    }
}

-(void)setPersonalModel:(LLPersonalModel *)personalModel{
    
    NSString *stayPayOrderNum = [personalModel.stayPayOrderNum length] > 0 ? personalModel.stayPayOrderNum : @"0";
    
    NSString *stayDeliveryOrderNum = [personalModel.stayDeliveryOrderNum length] > 0 ? personalModel.stayDeliveryOrderNum : @"0";
    
    NSString *stayReceivingOrderNum = [personalModel.stayReceivingOrderNum length] > 0 ? personalModel.stayReceivingOrderNum : @"0";
    
    NSString *stayAfterOrderNum = [personalModel.stayAfterOrderNum length] > 0 ? personalModel.stayAfterOrderNum : @"0";
    
    
    for (int i = 0; i < 5; i++) {
        LLMeOrderButton *orderBtn = [self.bottomView viewWithTag:100 + i];
        if (i == 0) {
            orderBtn.countStr = stayPayOrderNum;
        }else if (i == 1){
            orderBtn.countStr = stayDeliveryOrderNum;
        }else if (i == 2){
            orderBtn.countStr = stayReceivingOrderNum;
        }else if (i == 3){
            orderBtn.countStr = @"0";
        }else if (i == 4){
            orderBtn.countStr = stayAfterOrderNum;
        }
    }
    
}

#pragma mark--orderBtnClick
-(void)orderBtnClick:(UIButton *)btn{
    if (self.orderBlock) {
        self.orderBlock(btn.tag);
    }
}
#pragma mark--LLmeHeaderBtnBlock
-(void)LLmeHeaderBtnBlock{
    if (self.orderBlock) {
        self.orderBlock(200);
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
        [_headerBtn addTarget:self action:@selector(LLmeHeaderBtnBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}



@end




@interface LLMeMoudleTableCell ()

@property (nonatomic,strong)UIView *bottomView;

@end

@implementation LLMeMoudleTableCell

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
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.top.bottom.mas_equalTo(0);
    }];
    
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        [[self.bottomView viewWithTag:100 + i] removeFromSuperview];
        
        LLMeListButton *listButton = [LLMeListButton buttonWithType:UIButtonTypeCustom];
        listButton.frame = CGRectMake(0, CGFloatBasedI375(49) * i, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(49));
        listButton.imgStr = _imgArray[i];
        listButton.textStr = _titleArray[i];
        [listButton addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        listButton.tag = 100 + i;
        [self.bottomView addSubview:listButton];
    }
}
-(void)setImgArray:(NSArray *)imgArray{
    _imgArray = imgArray;
}

#pragma mark--listBtnClick
-(void)listBtnClick:(UIButton *)btn{
    if (self.moudleBtnBlock) {
        self.moudleBtnBlock(btn.tag);
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

@end
