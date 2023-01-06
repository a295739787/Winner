//
//  LLStoreReusableView.m
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import "LLStoreReusableView.h"
@interface LLStoreFooterReusableView ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *sycleview;/** <#class#> **/
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *arrPaixubtn ;/** <#class#> **/
@end
@implementation LLStoreFooterReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor blueColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.sycleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
//        make.height.mas_equalTo(CGFloatBasedI375(175));
    }];

}
-(void)setDatas:(NSArray *)datas{
    _datas= datas;
    NSMutableArray *temp = [NSMutableArray array];
    for(LLGoodModel *model in _datas){
        if([model.image containsString:@"http"]){
            [temp addObject:model.image];
        }else{
            [temp addObject:FORMAT(@"%@%@",API_IMAGEHOST,model.image)];
        }
    }
    self.sycleview.imageURLStringsGroup = temp.mutableCopy;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    NSArray *carousels = _model.carousels;
    NSMutableArray *temp = [NSMutableArray array];
    for(LLGoodModel *model in carousels){
        [temp addObject:FORMAT(@"%@%@",API_IMAGEHOST,model.coverImage)];
    }
    self.sycleview.imageURLStringsGroup =temp;
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    LLGoodModel *model = _datas[index];//类型（1商品，2外链）
    if(model.type == 1){
        LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
        vc.ID = model.goodsId;
        vc.status = RoleStatusStore;
        [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
    }else if(model.type == 2){
        NSLog(@"model.link == %@",model.link);
        NSString *url = model.link;
        if(![model.link containsString:@"http"]){
            url = FORMAT(@"https://%@",model.link);
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
            
        }];

    }else if(model.type == 4){
        if ([model.link isEqual: @"app-download"]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/app/id1586242929?mt=8"]] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }
}
-(SDCycleScrollView *)sycleview{
    if(!_sycleview){
      _sycleview= [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
           _sycleview.autoScrollTimeInterval = 4;
        _sycleview.pageDotColor = [UIColor colorWithHexString:@"#ffffff"];
        _sycleview.currentPageDotColor = [UIColor darkGrayColor];
        _sycleview.pageDotColor = [UIColor lightGrayColor];
   [self addSubview:_sycleview];
           _sycleview.delegate = self;
    }
    return _sycleview;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backView];
    }
    return _backView;
}
-(NSMutableArray *)arrPaixubtn{
    if(!_arrPaixubtn){
        _arrPaixubtn =[[NSMutableArray alloc]init];
    }
    return _arrPaixubtn;
}
@end
@interface LLStoreReusableView ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *sycleview;/** <#class#> **/
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *arrPaixubtn ;/** <#class#> **/

@property (nonatomic, copy) NSString *sidx;
@property (nonatomic, copy) NSString *sort;
@end
@implementation LLStoreReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];
    [self creatbutton];
}
#pragma mark - 创建界面
-(void)creatbutton{
    NSArray *titlearr = @[@"综合",@"价格",@"销量"];
    NSArray *imagearr = @[@"zh_gray",@"sort_nomal",@"sort_nomal"];
    for (int i = 0; i < titlearr.count; i ++) {
        CGFloat w = (SCREEN_WIDTH)/3;
        CGFloat h =CGFloatBasedI375(40);
        CGFloat x = CGFloatBasedI375(0)+(w + CGFloatBasedI375(0))*(i%3);
        CGFloat y =CGFloatBasedI375(0);
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x,y,w,h)];
        [btn setTitle:titlearr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [btn setTitleColor:Main_Color forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:imagearr[i]] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:selimagearr[i]] forState:UIControlStateSelected];

        [btn setTitleColor:[UIColor colorWithHexString:@"#0A0A0A"] forState:UIControlStateNormal];
        btn.backgroundColor = White_Color;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClickeds:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:btn];
        if(i==0){
            [btn setImage:[UIImage imageNamed:@"zh_red"] forState:UIControlStateNormal];
            btn.selected = YES;
        }else{
        }
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];

        [self.arrPaixubtn addObject:btn];
        
    }
  
}
-(void)btnClickeds:(UIButton *)sender{
    for(UIButton *btn in self.arrPaixubtn){
        btn.selected = NO;
        [btn setTitleColor:[UIColor colorWithHexString:@"#0A0A0A"] forState:UIControlStateNormal];
    }
    [self.arrPaixubtn[0] setImage:[UIImage imageNamed:@"zh_gray"] forState:UIControlStateNormal];
    sender.selected = YES;
    if(sender.tag == 0){
        self.sidx = @"Sort";
        self.sort = @"asc";
        [self.arrPaixubtn[0] setImage:[UIImage imageNamed:@"zh_red"] forState:UIControlStateNormal];
        [self.arrPaixubtn[1] setImage:[UIImage imageNamed:@"sort_nomal"] forState:UIControlStateNormal];
        [self.arrPaixubtn[2] setImage:[UIImage imageNamed:@"sort_nomal"] forState:UIControlStateNormal];
    }else if (sender.tag == 1){//价格排序 升序
        self.sidx = @"salesPrice";
        self.sort = @"asc";
        sender.tag = 3;
        [self.arrPaixubtn[1] setImage:[UIImage imageNamed:@"sort_sx"] forState:UIControlStateNormal];
        [self.arrPaixubtn[2] setImage:[UIImage imageNamed:@"sort_nomal"] forState:UIControlStateNormal];
    }else if (sender.tag == 2){
        self.sidx = @"realSalesVolume";
        self.sort = @"asc";
        sender.tag = 4;
        [self.arrPaixubtn[1] setImage:[UIImage imageNamed:@"sort_nomal"] forState:UIControlStateNormal];
        [self.arrPaixubtn[2] setImage:[UIImage imageNamed:@"sort_sx"] forState:UIControlStateNormal];
    }else if (sender.tag == 3){
        self.sidx = @"salesPrice";
        self.sort = @"desc";
        [self.arrPaixubtn[1] setImage:[UIImage imageNamed:@"sort_jx"] forState:UIControlStateNormal];
        [self.arrPaixubtn[2] setImage:[UIImage imageNamed:@"sort_nomal"] forState:UIControlStateNormal];
        sender.tag = 1;
    }else if (sender.tag == 4){
        sender.tag = 2;
        self.sidx = @"realSalesVolume";
        self.sort = @"desc";
        [self.arrPaixubtn[1] setImage:[UIImage imageNamed:@"sort_nomal"] forState:UIControlStateNormal];
        [self.arrPaixubtn[2] setImage:[UIImage imageNamed:@"sort_jx"] forState:UIControlStateNormal];
    }
    if(self.getPaixuBlock){
        self.getPaixuBlock(_sidx, _sort);
    }
}
-(SDCycleScrollView *)sycleview{
    if(!_sycleview){
      _sycleview= [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
           _sycleview.autoScrollTimeInterval = 4;
        _sycleview.localizationImageNamesGroup = @[@"banner01",@"banner01"];
        _sycleview.pageDotColor = [UIColor colorWithHexString:@"#ffffff"];
   [self addSubview:_sycleview];
//        _sycleview.layer.masksToBounds = YES;
//        _sycleview.layer.cornerRadius = CGFloatBasedI375(5);
           _sycleview.delegate = self;
    }
    return _sycleview;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backView];
    }
    return _backView;
}
-(NSMutableArray *)arrPaixubtn{
    if(!_arrPaixubtn){
        _arrPaixubtn =[[NSMutableArray alloc]init];
    }
    return _arrPaixubtn;
}
@end
