//
//  LLSearchViewController.m
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import "LLSearchViewController.h"
#import "LLSearchCell.h"
#import "LLSearchHistoryModel.h"
#import "LLMainCell.h"
#import "LLSearchResultViewController.h"
static NSString *const LLMainCellid = @"LLMainCell";
static NSString *const LLSearchCellid = @"LLSearchCell";
@interface LLSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout * collectionLayout;
@property (nonatomic,strong) NSMutableArray *historyArray;/** <#class#> **/
@property(nonatomic,strong)UITextField *titlelable;
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property(nonatomic,strong)UIImageView *backImage;
@property (nonatomic, copy) NSString *content;
@property (nonatomic,assign) BOOL isSearch;/** class **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/

@end

@implementation LLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyArray = [[LLSearchHistoryModel shareInstance] getSearchHistoryMArray];
    self.isSearch = YES;
    [self setLayout];
}
-(void)setLayout{
    WS(weakself);
    CGFloat orY = CGFloatBasedI375(25);
    if([NSString isPhoneXxxx]){
        orY += CGFloatBasedI375(40);
    }
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top);
        make.left.bottom.right.mas_equalTo(0);
    }];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orY);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.left.mas_equalTo(CGFloatBasedI375(62));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.backImage.mas_centerY);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(50));
        make.right.mas_equalTo(-CGFloatBasedI375(0));
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(11));
        make.top.bottom.mas_equalTo(CGFloatBasedI375(0));
        make.right.equalTo(weakself.sureButton.mas_left).equalTo(-5);
    }];
}
-(void)clickRecult{
    [self saveHistoryAdjustLocation:  self.titlelable.text ];
}
- (void) textFieldDidChange:(id) sender {
    UITextField *textField = (UITextField *)sender;
    NSLog(@"textField == %@",textField.text);
    self.content = textField.text;
    if(self.content.length > 0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }else{
        self.collectionView.backgroundColor = White_Color;
        self.isSearch = YES;
        [self.collectionView reloadData];
    }
}
- (void)saveHistoryAdjustLocation:(NSString *)searchText {
    if(searchText.length > 0){
    [self.historyArray containsObject:searchText] ? ([self.historyArray removeObject:searchText]) : nil;
    [self.historyArray insertObject:searchText atIndex:0];
    [[LLSearchHistoryModel shareInstance] saveSearchItemHistory];
        [self getDatas];
//        LLSearchResultViewController *vc = [[LLSearchResultViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.content forKey:@"keyword"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    [XJHttpTool post:FORMAT(@"%@",L_apiappgoodsgetGoodsList) method:GET params:param isToken:NO success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        self.isSearch = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.isSearch){
        return self.historyArray.count;;
    }
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.isSearch){
        LLSearchCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLSearchCellid forIndexPath:indexPath];
        cell.keyword= self.historyArray[indexPath.row];
        return cell;
    }
    LLMainCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLMainCellid forIndexPath:indexPath];
    cell.model= self.dataArr[indexPath.row];
    cell.redlable.hidden = YES;
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 10);
}


//根据文字大小计算不同item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(_isSearch){
    LLSearchCell *cell=(LLSearchCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:LLSearchCellid forIndexPath:indexPath];
    return [cell sizeForCell];
    }
        return  CGSizeMake((SCREEN_WIDTH-CGFloatBasedI375(30))/2, CGFloatBasedI375(252));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_isSearch){
        self.content = self.historyArray[indexPath.row];
        [self getDatas];
    }else{
        LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
        vc.status = RoleStatusMainDetails;
        LLGoodModel *model =  self.dataArr[indexPath.row];
        vc.ID = model.goodsId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
          layout.scrollDirection = UICollectionViewScrollDirectionVertical;
          layout.minimumLineSpacing = 0;
          layout.minimumInteritemSpacing = 0;
          _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
          _collectionView.tag = 11;
          _collectionView.dataSource = self;
          _collectionView.delegate = self;
          _collectionView.bounces = NO;
          _collectionView.alwaysBounceHorizontal = YES;
          _collectionView.alwaysBounceVertical = NO;
          _collectionView.showsHorizontalScrollIndicator = NO;
          _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[LLSearchCell class] forCellWithReuseIdentifier:LLSearchCellid];
        [_collectionView registerClass:[LLMainCell class] forCellWithReuseIdentifier:LLMainCellid];
        [self.view addSubview:_collectionView];
        adjustsScrollViewInsets_NO(self.collectionView, self);
    }
    return _collectionView;
}
-(NSMutableArray *)historyArray{
    if(!_historyArray){
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}
-(UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]init];
        _backImage.userInteractionEnabled = YES;
        _backImage.layer.masksToBounds = YES;
        _backImage.layer.cornerRadius = CGFloatBasedI375(15);
        _backImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.view addSubview:self.backImage];
    }
    return _backImage;
}

-(UITextField *)titlelable{
    if(!_titlelable){
        _titlelable =[[UITextField alloc]init];
        _titlelable.placeholder = @"搜索商品名称 ";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(11)];
        [self.backImage addSubview:self.titlelable];
        [_titlelable addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _titlelable;
}


-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"搜索" forState:UIControlStateNormal];
        _sureButton.backgroundColor = Main_Color;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = CGFloatBasedI375(15);
        [_sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [_sureButton addTarget:self action:@selector(clickRecult) forControlEvents:UIControlEventTouchUpInside];
        [self.backImage addSubview:self.sureButton];
    }
    return _sureButton;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
