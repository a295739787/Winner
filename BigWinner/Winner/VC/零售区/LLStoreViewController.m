//
//  LLGoodYoujuViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/3/25.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLStoreViewController.h"
#import "LLStoreReusableView.h"
#import "LLMainCell.h"
#import "LLNewsViewController.h"
#import "LLStorePaySuccessViewController.h"
#import "LLStoreSureOrderViewController.h"
#import "LLGoodDetailViewController.h"
#import "LLSearchViewController.h"
#import "SuspensionAssistiveTouch.h"
#import "LLShopCarViewController.h"
#define  heights CGFloatBasedI375(260)
#define  widths (SCREEN_WIDTH-CGFloatBasedI375(20))/2
static NSString *const LLMainCellid = @"LLMainCell";
static NSString *const LLMainReusableViewid = @"LLMainReusableView";
static NSString *const footerCollectionIdentifier = @"footerCollection";
@interface LLStoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout * collectionLayout;
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic, copy) NSString *sidx;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic,assign) NSInteger page;/** class **/
@property (nonatomic,strong) NSMutableArray *picArr;/** <#class#> **/
@property (nonatomic,strong) SuspensionAssistiveTouch *assistiveTouch;/** <#class#> **/

@end

@implementation LLStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.sidx = @"Sort";
    self.sort = @"asc";
    self.customNavBar.title = @"零售区";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"search"]];
    WS(weakself);
    self.customNavBar.onClickRightButton = ^{
        LLSearchViewController *vc = [[LLSearchViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    [self setLayout];
    [self getDatas:YES];
    [self getBannerDatas];
//    [self.customNavBar wr_setRightButtonWithImages:@[[UIImage imageNamed:@"sopcharyou"],[UIImage imageNamed:@"shareyou"]]];
}
-(void)header{
    self.collectionView.mj_footer.hidden = NO;
    self.page = 1;
    [self getDatas:NO];
    [self getBannerDatas];
}
-(void)footer{
    self.page ++;
    [self getDatas:NO];
}
-(void)getBannerDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    [XJHttpTool post:FORMAT(@"%@",L_apiappgoodsgetGoodsCarousel) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSArray *data = responseObj[@"data"];
        [self.picArr removeAllObjects];
        [self.picArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
-(void)getDatas:(BOOL)isload{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"" forKey:@"keyword"];
    [param setValue:self.sidx forKey:@"sidx"];
    [param setValue:self.sort forKey:@"sort"];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:@(self.page) forKey:@"currentPage"];
    if(isload){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [XJHttpTool post:FORMAT(@"%@",L_apiappgoodsgetGoodsList) method:GET params:param isToken:NO success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];
        NSLog(@"list == %@",list);
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        if(self.page ==1){
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:list]];
        if(data.count < 10 ){
            self.collectionView.mj_footer.hidden = YES;
            [self.collectionView.mj_footer resetNoMoreData];
        }else{
            self.collectionView.mj_footer.hidden = NO;
        }
     
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

-(void)setLayout{
    WS(weakself);
    
    [self.view addSubview:self.collectionView];
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"home_bg"].CGImage;
    layer.anchorPoint = CGPointZero;
    layer.bounds = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    CGRect rect = layer.frame;
    rect.origin.y = 0;
    layer.frame = rect;
    [self.collectionView.layer addSublayer:layer];
    layer.zPosition = -5;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(0));
        make.bottom.offset(CGFloatBasedI375(-0));
        make.right.offset(CGFloatBasedI375(0));

    }];
    
    _assistiveTouch = [[SuspensionAssistiveTouch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-CGFloatBasedI375(70), SCREEN_HEIGHT-DeviceXTabbarHeigh(130), CGFloatBasedI375(63),CGFloatBasedI375(63))];
    NSLog(@" == %@",_assistiveTouch.showimage);
    _assistiveTouch.showimage.userInteractionEnabled = YES;
    _assistiveTouch.showimage.image  = [UIImage imageNamed:@"gwcccc"];
    [self.view addSubview:_assistiveTouch];
    [self.view insertSubview:_assistiveTouch aboveSubview:self.collectionView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestzujiForUrl)];
    [ _assistiveTouch.showimage addGestureRecognizer:tap];
}
-(void)requestzujiForUrl{
    if([UserModel sharedUserInfo].token.length <= 0){
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele loginVc];
        return ;
    }
    LLShopCarViewController *vc = [[LLShopCarViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
          }
    return self.dataArr.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLMainCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLMainCellid forIndexPath:indexPath];
    cell.model =_dataArr[indexPath.row];
    cell.redlable.hidden = YES;
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if(section == 1){
        return CGFloatBasedI375(10);
    }
    return CGFloatBasedI375(0);
    
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(section == 1){
        return CGFloatBasedI375(10);
    }
    return CGFloatBasedI375(0);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if(section == 1){
        return UIEdgeInsetsMake(CGFloatBasedI375(10), CGFloatBasedI375(10),CGFloatBasedI375(10), CGFloatBasedI375(10));
    }
    return UIEdgeInsetsMake(CGFloatBasedI375(0), CGFloatBasedI375(0),CGFloatBasedI375(0), CGFloatBasedI375(0));
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WS(weakself);
    if (kind == UICollectionElementKindSectionHeader) { //头部视图
        LLStoreReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:LLMainReusableViewid forIndexPath:indexPath];
        headerView.getPaixuBlock = ^(NSString * _Nonnull sidx, NSString * _Nonnull sort) {
            weakself.page = 1;
            weakself.sidx = sidx;
            weakself.sort = sort;
            [weakself getDatas:YES];
        };
        return headerView;
    } else { //脚部视图
        LLStoreFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
        footerView.datas = self.picArr.mutableCopy;
//        footerView.model = self.model;
      return footerView;
    }

}
//根据文字大小计算不同item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((SCREEN_WIDTH-CGFloatBasedI375(30))/2, CGFloatBasedI375(252));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(44));
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(175));
    }
    return CGSizeZero;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
    vc.status = RoleStatusStore;
    LLGoodModel *model =  _dataArr[indexPath.row];
    vc.ID = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat itermSpace = 0;
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//          layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//          layout.minimumLineSpacing = itermSpace;
//          layout.minimumInteritemSpacing = itermSpace;
//        layout.sectionInset = UIEdgeInsetsMake(itermSpace, itermSpace, itermSpace, itermSpace);
//        layout.sectionHeadersPinToVisibleBounds = YES;
          _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
          _collectionView.tag = 11;
          _collectionView.dataSource = self;
          _collectionView.delegate = self;
//          _collectionView.bounces = NO;
//          _collectionView.alwaysBounceHorizontal = YES;
//          _collectionView.alwaysBounceVertical = NO;
//          _collectionView.showsHorizontalScrollIndicator = NO;
//          _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#DEDCD5"];
//        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(175+44));
//        layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(50));
        [_collectionView registerClass:[LLMainCell class] forCellWithReuseIdentifier:LLMainCellid];
        [_collectionView registerClass:[LLStoreReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LLMainReusableViewid];
        [_collectionView registerClass:[LLStoreFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier];
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _collectionView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _collectionView.mj_footer = footer;
        adjustsScrollViewInsets_NO(_collectionView, self);
    }
    return _collectionView;
}


-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)picArr{
    if(!_picArr){
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}
@end
