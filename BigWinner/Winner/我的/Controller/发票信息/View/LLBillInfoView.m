//
//  LLBillInfoView.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLBillInfoView.h"

@interface LLBillInfoView ()

@property (nonatomic,strong)UIButton *addBillBtn;
@property (nonatomic,strong)UIButton *saveBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIButton *saveBillBtn;

@end

@implementation LLBillInfoView


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
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.addBillBtn];
    [self addSubview:self.saveBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.saveBillBtn];
    
    [self.addBillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
    }];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(15) * 3) / 2;
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.saveBillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
        make.width.mas_equalTo(btnWidth);
    }];
    
    self.addBillBtn.hidden = YES;
    self.saveBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    self.saveBillBtn.hidden = YES;
    
}
-(void)setIndexType:(NSInteger)indexType{
    if (indexType == 100) {
        
        self.addBillBtn.hidden = NO;
        self.saveBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.saveBillBtn.hidden = YES;
    }else if (indexType == 200){
        
        self.addBillBtn.hidden = YES;
        self.saveBtn.hidden = NO;
        self.deleteBtn.hidden = YES;
        self.saveBillBtn.hidden = YES;
    }else{
        
        self.addBillBtn.hidden = YES;
        self.saveBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
        self.saveBillBtn.hidden = NO;
    }
}
#pragma mark--footerBillBtnClick
-(void)footerBillBtnClick:(UIButton *)btn{
    
    if (self.billInfoBtnBlock) {
        self.billInfoBtnBlock(btn.tag,btn);
    }
}
#pragma mark--lazy
-(UIButton *)addBillBtn{
    if (!_addBillBtn) {
        _addBillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBillBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _addBillBtn.tag = 100;
        [_addBillBtn setTitle:@"添加发票抬头" forState:UIControlStateNormal];
        [_addBillBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _addBillBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_addBillBtn addTarget:self action:@selector(footerBillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBillBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _addBillBtn.clipsToBounds = YES;
    }
    return _addBillBtn;
}
-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _saveBtn.tag = 200;
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_saveBtn addTarget:self action:@selector(footerBillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _saveBtn.clipsToBounds = YES;
    }
    return _saveBtn;
}

-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = UIColorFromRGB(0xF0EEEB);
        _deleteBtn.tag = 300;
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_deleteBtn addTarget:self action:@selector(footerBillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _deleteBtn.clipsToBounds = YES;
    }
    return _deleteBtn;
}
-(UIButton *)saveBillBtn{
    if (!_saveBillBtn) {
        _saveBillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBillBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _saveBillBtn.tag = 400;
        [_saveBillBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBillBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _saveBillBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_saveBillBtn addTarget:self action:@selector(footerBillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBillBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _saveBillBtn.clipsToBounds = YES;
    }
    return _saveBillBtn;
}

@end






@interface LLBillAddheaderView ()

@property (nonatomic,strong)UIButton *businessBillBtn;
@property (nonatomic,strong)UIButton *personalBillBtn;
@property (nonatomic,strong)UIButton *currentBtn;

@end

@implementation LLBillAddheaderView


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
    
    [self addSubview:self.personalBillBtn];
    [self addSubview:self.businessBillBtn];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(30 + 10)) / 2;
    
    [self.personalBillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(CGFloatBasedI375(34));
    }];
    
    [self.businessBillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(CGFloatBasedI375(34));
    }];
    

}
#pragma mark--headerBillBtnClick
-(void)headerBillBtnClick:(UIButton *)btn{
    
    if (btn != _currentBtn) {
        
        btn.backgroundColor = UIColorFromRGB(0xD40006);
        [btn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        
        _currentBtn.backgroundColor = UIColorFromRGB(0xFAFAFA);
        [_currentBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        
        _currentBtn = btn;
        
        if (self.billHeaderBtnBlock) {
            self.billHeaderBtnBlock(btn.tag);
        }
    }
}

#pragma mark--lazy
-(UIButton *)personalBillBtn{
    if (!_personalBillBtn) {
        _personalBillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _personalBillBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _personalBillBtn.tag = 100;
        [_personalBillBtn setTitle:@"个人/非企业单位" forState:UIControlStateNormal];
        [_personalBillBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _personalBillBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_personalBillBtn addTarget:self action:@selector(headerBillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _personalBillBtn.layer.cornerRadius = CGFloatBasedI375(17);
        _personalBillBtn.clipsToBounds = YES;
        _currentBtn = _personalBillBtn;
    }
    return _personalBillBtn;
}
-(UIButton *)businessBillBtn{
    if (!_businessBillBtn) {
        _businessBillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _businessBillBtn.backgroundColor = UIColorFromRGB(0xFAFAFA);
        _businessBillBtn.tag = 200;
        [_businessBillBtn setTitle:@"企业单位" forState:UIControlStateNormal];
        [_businessBillBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _businessBillBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_businessBillBtn addTarget:self action:@selector(headerBillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _businessBillBtn.layer.cornerRadius = CGFloatBasedI375(17);
        _businessBillBtn.clipsToBounds = YES;
    }
    return _businessBillBtn;
}


@end




@interface LLBillSelectTypeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation LLBillSelectTypeView


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
    
    [self addSubview:self.bottomView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    
}
-(void)hidden{
    [self removeFromSuperview];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CGFloatBasedI375(132) + SCREEN_Bottom);
    }];
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(132) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(132) + SCREEN_Bottom);
    }];
}
-(void)tap{
    [self hidden];
}
#pragma mark--cancleBtnClick
-(void)cancleBtnClick:(UIButton *)btn{
    [self hidden];
}

#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @[@"增值税电子普通发票",@"增值税专用发票"][indexPath.row];
    cell.textLabel.textColor = UIColorFromRGB(0x443415);
    cell.textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.backgroundColor = UIColorFromRGB(0xFAFAFA);
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(44));
    cancleBtn.backgroundColor = [UIColor clearColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:cancleBtn];
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectTYpeBlock) {
        self.selectTYpeBlock(indexPath.row + 1, @[@"增值税电子普通发票",@"增值税专用发票"][indexPath.row]);
    }
    [self hidden];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(132)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CGFloatBasedI375(132) + SCREEN_Bottom)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc] init];
       cornerRadiusLayer.frame = self.contentView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.contentView.layer.mask = cornerRadiusLayer;
        
    }
    return _contentView;
}


@end
