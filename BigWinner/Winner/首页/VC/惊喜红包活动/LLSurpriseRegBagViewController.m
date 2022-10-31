//
//  LLGoodYoujuViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/3/25.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLSurpriseRegBagViewController.h"
#import "LLMainReusableView.h"
#import "LLMainCell.h"
#import "LLNewsViewController.h"
#import "LLSurpriseRegBagSureOrderViewController.h"
#import "LLSurpriseRegBagRecordViewController.h"
#define  heights CGFloatBasedI375(260)
#define  widths (SCREEN_WIDTH-CGFloatBasedI375(20))/2
static NSString *const LLMainCellid = @"LLMainCell";
static NSString *const LLMainReusableViewid = @"LLMainReusableView";
static NSString *const footerCollectionIdentifier = @"footerCollection";
@interface LLSurpriseRegBagViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout * collectionLayout;
@property (nonatomic,strong) UIImageView *showImage ;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/

@end

@implementation LLSurpriseRegBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    self.customNavBar.title = @"惊喜红包活动";
    [self.customNavBar wr_setRightButtonWithTitle:@"购买记录" titleColor:BlackTitleFont443415];
    WS(weakself);
    self.customNavBar.onClickRightButton = ^{
        if([UserModel sharedUserInfo].token.length <= 0){
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [dele loginVc];
            return ;
        }
        LLSurpriseRegBagRecordViewController *vc = [[LLSurpriseRegBagRecordViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    [self setLayout];
//    [self.customNavBar wr_setRightButtonWithImages:@[[UIImage imageNamed:@"sopcharyou"],[UIImage imageNamed:@"shareyou"]]];
    [self getDatas];
}
-(void)header{
    self.page = 1;
    [self getDatas];
}
-(void)footer{
    self.page ++;
    [self getDatas];
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"" forKey:@"keyword"];
    [param setValue:@"Sort" forKey:@"sidx"];
    [param setValue:@"asc" forKey:@"sort"];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:@(self.page) forKey:@"currentPage"];

    [XJHttpTool post:FORMAT(@"%@",L_apiappredgoodsgetRedGoodsList) method:GET params:param isToken:NO success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        if(self.page == 1){
            [self.dataArr removeAllObjects];
         }
        NSArray *list = data[@"list"];
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];        if(list.count < 10 ){
            self.collectionView.mj_footer.hidden = YES;
            [self.collectionView.mj_footer resetNoMoreData];
        }else{
            self.collectionView.mj_footer.hidden = NO;
        }

        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

-(void)setLayout{
    WS(weakself);
//    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(CGFloatBasedI375(0));
//        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(0));
//        make.bottom.offset(CGFloatBasedI375(0));
//        make.right.offset(CGFloatBasedI375(0));
//
//    }];


    
    [self.view addSubview:self.collectionView];
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"jxhb_bg"].CGImage;
    layer.anchorPoint = CGPointZero;
    layer.bounds = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    CGRect rect = layer.frame;
    rect.origin.y = 0;
    layer.frame = rect;
    [self.collectionView.layer addSublayer:layer];
    layer.zPosition = -5;
    //    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.offset(CGFloatBasedI375(0));
    //        make.top.mas_equalTo(CGFloatBasedI375(0));
    //        make.bottom.offset(CGFloatBasedI375(0));
    //        make.right.offset(CGFloatBasedI375(0));
    //
    //    }];
   
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLMainCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLMainCellid forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatBasedI375(10);
    
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatBasedI375(10);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatBasedI375(10), CGFloatBasedI375(10),CGFloatBasedI375(10), CGFloatBasedI375(10));
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
    [headerView addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(CGFloatBasedI375(80));
            make.right.top.offset(CGFloatBasedI375(0));
    
        }];
    return headerView;

}
//根据文字大小计算不同item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((SCREEN_WIDTH-CGFloatBasedI375(30))/2, CGFloatBasedI375(252));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
    vc.status = RoleStatusRedBag;
    LLGoodModel *model = self.dataArr[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
//    LLSurpriseRegBagSureOrderViewController *vc = [[LLSurpriseRegBagSureOrderViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
          layout.scrollDirection = UICollectionViewScrollDirectionVertical;
          layout.minimumLineSpacing = 0;
          layout.minimumInteritemSpacing = 0;

          _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight) collectionViewLayout:layout];
          _collectionView.tag = 11;
          _collectionView.dataSource = self;
          _collectionView.delegate = self;
//          _collectionView.bounces = NO;
//          _collectionView.alwaysBounceHorizontal = YES;
//          _collectionView.alwaysBounceVertical = NO;
//          _collectionView.showsHorizontalScrollIndicator = NO;
//          _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(200));
//        layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(50));
        [_collectionView registerClass:[LLMainCell class] forCellWithReuseIdentifier:LLMainCellid];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:footerCollectionIdentifier];
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
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.image = [UIImage imageNamed:@"jxhb_bg"];
        _showImage.userInteractionEnabled = YES;
        [self.view addSubview:self.showImage];
    }
    return _showImage;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _sureButton;
}
-(void)clickTap:(UIButton *)sender{
    LLWebViewController *vc = [[LLWebViewController alloc]init];
    vc.isHiddenNavgationBar = YES;
    vc.htmlStr = @"AppRedActivityRule";
    vc.name = @"惊喜红包活动";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
