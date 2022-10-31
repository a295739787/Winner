//
//  LLAddBankCardFooterView.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLAddBankCardFooterView.h"

@interface LLAddBankCardFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *agreeBtn;
@property (nonatomic,strong)UIButton *confirmBtn;

@end

@implementation LLAddBankCardFooterView

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
    [self.bottomView addSubview:self.selectBtn];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.agreeBtn];
    [self addSubview:self.confirmBtn];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
        make.width.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(0);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    
    
}
#pragma mark--agreeBtnClick
-(void)agreeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.addCarBlock) {
        self.addCarBlock(0, btn.selected,btn);
    }
}
#pragma mark--selectBtnClick
-(void)selectBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [btn setImage:[UIImage imageNamed:@"xz_red"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"xz_gray"] forState:UIControlStateNormal];
    }
    if (self.addCarBlock) {
        self.addCarBlock(100, _selectBtn.selected,btn);
    }
}
#pragma mark--confirmBtnClick
-(void)confirmBtnClick:(UIButton *)btn{
    if (self.addCarBlock) {
        self.addCarBlock(200, _selectBtn.selected,btn);
    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc]init];
        _bottomView.backgroundColor = UIColorFromRGB(0xFAFAFA);
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.backgroundColor = [UIColor whiteColor];
        _selectBtn.selected = YES;
        [_selectBtn setImage:[UIImage imageNamed:@"xz_red"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _titleLabel.text = @"查看并同意";
    }
    return _titleLabel;
}
-(UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.backgroundColor = [UIColor clearColor];
        _agreeBtn.tag = 100;
        [_agreeBtn setTitle:@"《服务协议》" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:UIColorFromRGB(0x5082B0) forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        [_agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        _confirmBtn.tag = 200;
        [_confirmBtn setTitle:@"立即提交" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end





@interface LLSelectBankNameView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIView *line;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLSelectBankNameView

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.cancleBtn];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(40));
        make.bottom.mas_equalTo(-SCREEN_Bottom);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CGFloatBasedI375(50));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.tableView reloadData];
}
#pragma mark--cancleBtnClick
-(void)cancleBtnClick:(UIButton *)btn{
    [self hidden];
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    WS(weakself);
    [UIView animateWithDuration:0.1 animations:^{
        weakself.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(210) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(210) + SCREEN_Bottom);
    }];
}
-(void)hidden{
    
    WS(weakself);
    [UIView animateWithDuration:0.1 animations:^{
        weakself.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CGFloatBasedI375(210) + SCREEN_Bottom);
    }];
    [self removeFromSuperview];
}


#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (self.dataArray.count > 0) {
        NSDictionary *dict = self.dataArray[indexPath.row];
        NSString *name = dict[@"name"];
        cell.textLabel.text = name;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = UIColorFromRGB(0x443415);
        cell.textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(40);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    if (self.LLSelectBankBlock) {
        self.LLSelectBankBlock(dict);
        [self hidden];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(50), SCREEN_WIDTH, CGFloatBasedI375(120)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        
        NSURL *URL=[[NSBundle mainBundle]URLForResource:@"BankNameInfo" withExtension:@"plist"];
            //plist 文件为字典类型
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfURL:URL];
        NSArray *list = dic[@"List"];
        for (NSDictionary *dict in list) {
            [_dataArray addObject:dict];
        }
    }
    return _dataArray;
}



#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.3;
    }
    return _bottomView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(210) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(210) + SCREEN_Bottom)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _titleLabel.text = @"请选择银行卡";
    }
    return _titleLabel;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = UIColorFromRGB(0xF0EEEB);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0x999999);
        _line.alpha = 0.4;
    }
    return _line;
}


@end
