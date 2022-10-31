//
//  LLCanshuView.m
//  ShopApp
//
//  Created by lijun L on 2021/3/23.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLReturnShowView.h"
#import "LLReturnServiceCell.h"

static NSString *const LLReturnServiceCellid = @"LLReturnServiceCell";
@interface LLReturnShowView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) UILabel *label1 ;/** <#class#> **/

@property (nonatomic,assign) NSInteger tagindex;/** <#class#> **/
@end
@implementation LLReturnShowView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _indexs = -1;
        [self setLayout];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
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
-(void)setTitles:(NSString *)titles{
    _titles = titles;
    _label1.text = _titles;
}
-(void)setDatas:(NSArray *)datas{

    _datas = datas;
    [self.tableView reloadData];
}
-(void)setIndexs:(NSInteger)indexs{
    _indexs = indexs;
    self.tagindex = _indexs;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    self.backView.mj_size = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(320));
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.left.bottom.mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(320));
     }];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backView .bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.backView .bounds;
    maskLayer.path = maskPath.CGPath;
    self.backView .layer.mask = maskLayer;
    _label1 = [[UILabel alloc]init];
    _label1.textColor = [UIColor colorWithHexString:@"#333333"];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.font = [UIFont systemFontOfSize:CGFloatBasedI375(16)];
    [self.backView addSubview:_label1];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(54));
    }];
    
    UIButton *closebtn=[[UIButton alloc]init];
    [self.backView addSubview:closebtn];
    [closebtn setTitle:@"╳" forState:UIControlStateNormal];
    [closebtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    closebtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
    [closebtn addTarget:self action:@selector(hideActionSheetView) forControlEvents:UIControlEventTouchUpInside];
    [closebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(-15));
        make.centerY.equalTo(_label1.mas_centerY);
        make.width.height.equalTo(CGFloatBasedI375(30));
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(CGFloatBasedI375(54));
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(50);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(0.001))];
    view.backgroundColor = [UIColor whiteColor];

    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLReturnShowCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnServiceCellid];
    NSDictionary *dic =_datas[indexPath.row];
    if([_datas[indexPath.row] isKindOfClass:[NSString class]]){
        cell.nameLabel1.text =_datas[indexPath.row];
    }else{
        LLGoodModel *model = _datas[indexPath.row];;
        cell.nameLabel1.text = model.title;
    }
   
    if(self.tagindex == indexPath.row){
        cell.selectBtn.selected = YES;
    }else{
        cell.selectBtn.selected = NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tagindex = indexPath.row;
    [self.tableView reloadData];
    if([_datas[indexPath.row] isKindOfClass:[NSString class]]){
        
        if(self.getDatasBlock){
            self.getDatasBlock(_datas[indexPath.row],indexPath.row,_tagindex);
        }
    }else{
        if(self.getDatasBlocks){
            self.getDatasBlocks(_datas[indexPath.row],indexPath.row,_tagindex);
        }
    }
    [self hideActionSheetView];
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor whiteColor];
        [ _tableView  registerClass:[LLReturnShowCell class] forCellReuseIdentifier:LLReturnServiceCellid];
        [self.backView addSubview:self.tableView];
    }
    return _tableView;
}
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor =[UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        [self addSubview:_backView];
    }
    return _backView;
}
/********************  Animation  *******************/

- (void)showActionSheetView {

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    
        
        CGRect tempFrame = self.backView.frame;
        self.alpha = 0.0f;
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
            }];
        }];
    
}

- (void)hideActionSheetView {
    
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
