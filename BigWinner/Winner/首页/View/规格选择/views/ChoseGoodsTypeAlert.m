
//
//  ChoseGoodsTypeAlert.m
//  MeiXiangDao_iOS
//
//  Created by 澜海利奥 on 2017/9/26.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import "ChoseGoodsTypeAlert.h"
#import "ChoosTypeTableViewCell.h"
#import "GoodsTypeModel.h"
#import "Header.h"
#import "GoodsInfoView.h"
#import "CountView.h"
@interface ChoseGoodsTypeAlert ()
@property (nonatomic,strong) GoodsInfoView *goodsInfo;/** <#class#> **/
@property (nonatomic, copy) NSString *goodsSpecsPriceId;
@property (nonatomic, copy) NSString *goodsId;

@end
@implementation ChoseGoodsTypeAlert
{
    UIButton *sureButton;
    UIButton *shopButton;
    UIView *view;
    UIView *bgView;
    SizeAttributeModel *sizeModel;
    CountView *countView;
}

-(instancetype)initWithFrame:(CGRect)frame andHeight:(float)height {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明view
        view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        [self addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
        [view addGestureRecognizer:tap];
        //白色底view
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, height)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        
        //商品信息
        self.goodsInfo = [[GoodsInfoView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kSize(90))];
        [    self.goodsInfo.closeButton addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:    self.goodsInfo];
        
        sureButton = [JXUIKit buttonWithBackgroundColor:Main_Color titleColorForNormal:WhiteColor titleForNormal:@"立即购买" titleForSelete:nil titleColorForSelete:nil fontSize:18 font:nil];
        sureButton.tag=1;
        [sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:sureButton];
        sureButton.layer.masksToBounds = YES;
        sureButton.layer.cornerRadius = CGFloatBasedI375(18);
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-CGFloatBasedI375(15));
            make.width.offset((SCREEN_WIDTH-CGFloatBasedI375(15*2+CGFloatBasedI375(10)))/2);
            make.bottom.offset(-DeviceXTabbarHeigh(CGFloatBasedI375(6)));
            make.height.offset(CGFloatBasedI375(36));

        }];
        shopButton = [JXUIKit buttonWithBackgroundColor:[UIColor colorWithHexString:@"#F0EEEB"] titleColorForNormal:Black_Color titleForNormal:@"加入购物车" titleForSelete:nil titleColorForSelete:nil fontSize:18 font:nil];
        shopButton.layer.masksToBounds = YES;
        shopButton.tag=2;
        shopButton.layer.cornerRadius = CGFloatBasedI375(18);
        [shopButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:shopButton];
        [shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(CGFloatBasedI375(15));
            make.width.offset((SCREEN_WIDTH-CGFloatBasedI375(15*2+CGFloatBasedI375(10)))/2);
            make.bottom.offset(-DeviceXTabbarHeigh(CGFloatBasedI375(6)));
            make.height.offset(CGFloatBasedI375(36));

        }];
        [bgView addSubview:self.tableview];
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(CGFloatBasedI375(0));
            make.right.mas_equalTo(CGFloatBasedI375(0));
            make.top.equalTo(    self.goodsInfo.mas_bottom).offset(CGFloatBasedI375(8));
            make.bottom.equalTo(shopButton.mas_top).offset(-CGFloatBasedI375(8));

        }];
        countView = [[CountView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kSize(100))];
//        countView.countTextField.delegate = self;
//        countView.backgroundColor = Red_Color;
        [countView.addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [countView.reduceButton addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
        [countView.textFieldDownButton addTarget:self action:@selector(tfresignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
        self.tableview.tableFooterView = countView;
//        self.tableview.sd_layout.leftSpaceToView(bgView, 0).rightSpaceToView(bgView, 0).topSpaceToView(goodsInfo, 0).bottomSpaceToView(sureButton, 0);
    }
    return self;
}
-(void)setStatus:(RoleStatus)status{
    _status = status;
    WS(weakself);
    if(_status == RoleStatusRedBag || _status == RoleStatusStockPeisong){
        shopButton.hidden = YES;
        [sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo(-CGFloatBasedI375(15));
            make.left.mas_equalTo(CGFloatBasedI375(15));
            make.height.mas_equalTo(CGFloatBasedI375(36));
            make.bottom.offset(-DeviceXTabbarHeigh(CGFloatBasedI375(6)));
         }];
        if(_status == RoleStatusStockPeisong){
            [sureButton setTitle:@"立即采购" forState:UIControlStateNormal];
        }
    }
}
#pragma mark - methods
-(void)hideView
{
    [self tfresignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^
     {
        bgView.centerY = bgView.centerY+CGRectGetHeight(bgView.frame);
        
    } completion:^(BOOL fin){
        [self removeFromSuperview];
        
    }];
    
}
//
-(void)showView
{
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^
     {
        bgView.centerY = bgView.centerY-CGRectGetHeight(bgView.frame);
        
    } completion:^(BOOL fin){}];
}
-(void)initData:(GoodsModel *)model
{
    _model = model;
    self.goodsId = model.goodsNo;
    [self.goodsInfo initData:model];
    NSString *name = @"件";
    if(_model.status  == RoleStatusRedBag || _model.status  == RoleStatusStore||_model.status  == RoleStatusStockPeisong){
        name = @"瓶";
    }
    if(_model.status  == RoleStatusRedBag){
        countView.countlabel.text = FORMAT(@"单次限%ld%@",_model.purchaseRestrictions,name);
    }else if(_model.status  == RoleStatusStore){
        countView.countlabel.text = @"";
//        countView.countlabel.text = FORMAT(@"单次限%@%@",_model.totalStock,name);
    }else{
        countView.countlabel.text = FORMAT(@"单次限999%@",name);
    }
    
    [_dataSource removeAllObjects];
    //传入数据源创建多个属性
    [_dataSource addObjectsFromArray:model.itemsList];
    //此方法必须在_dataSource赋值后方可调用
    if(_model.status == RoleStatusStockPeisong){
        self.stock = model.totalStock.integerValue;
    }else{
       [self reloadGoodsInfo];
    }
    [self.tableview reloadData];
}
-(void)reloadGoodsInfo
{
    for (GoodsTypeModel *model in _dataSource) {
        if (model.selectIndex<0) {
            self.goodsInfo.promatLabel.text =[NSString stringWithFormat:@"请选择%@",model.typeName];
            break;
        }
    }
    //每次选择规格后将置灰情况恢复
    for (int i = 0; i<_model.itemsList.count; i++) {
        GoodsTypeModel *type = _model.itemsList[i];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int j = 0; j<type.typeArray.count; j++) {
            [arr addObject:@"1"];
        }
        type.enableArray = arr;
        [self.tableview reloadData];
    }
//    NSArray *dic = [self getSizeStr];
    NSString *str= @"";
    NSString *strID = @"";
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableDictionary *datas = [NSMutableDictionary dictionary];
    for (GoodsTypeModel *model in _dataSource) {
        if (model.selectIndex>=0) {
            NSDictionary *dic = model.typeArray[model.selectIndex];
            [datas setValue:dic[@"id"] forKey:@"id"];
            if ([dic[@"name"] length] == 0) {
                str = dic[@"name"];
                strID = dic[@"id"];
            }else{
               str = [NSString stringWithFormat:@"%@、%@",str,dic[@"name"]];
                strID = [NSString stringWithFormat:@"%@,%@",strID,dic[@"id"]];

            }
           
        }
    }
    //根据已选规格，查找库存为0的规格组合，将按钮置灰，如不需要可注释掉
//    [self setEnableSize:str];
    NSLog(@"用户选择的属性是：%@  strID== %@",str,strID);
    sizeModel = nil;
    self.goodsInfo.promatLabel.text = [NSString stringWithFormat:@"已选%@",str];
    strID = [strID substringWithRange:NSMakeRange(1,strID.length-1)];

    [self getSkuDatas:strID];
    //遍历属性组合列表找出符合的属性，修改价格和库存等信息
    for (SizeAttributeModel *model in _model.sizeAttribute) {
        if ([model.value isEqualToString:str]) {
            sizeModel = model;
            if ([countView.countTextField.text intValue]>[sizeModel.stock intValue]) {
                countView.countTextField.text = [NSString stringWithFormat:@"%d",[sizeModel.stock intValue]];
            }else if ([countView.countTextField.text intValue]<[sizeModel.stock intValue])
            {
                if ([countView.countTextField.text intValue] == 0) {
                    countView.countTextField.text = @"1";
                }
            }
            self.goodsInfo.promatLabel.text = [NSString stringWithFormat:@"已选%@",model.value];
            [self.goodsInfo resetData:model];
            return;
        }
    }
    //没找到匹配的，显示默认数据
    [self.goodsInfo initData:_model];
}
-(void)getSkuDatas:(NSString *)ids{
    for (GoodsTypeModel *model in _dataSource) {
        if (model.selectIndex<0) {
//            [JXUIKit showErrorWithStatus:[NSString stringWithFormat:@"请选择%@",model.typeName]];
            return;
        }
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:ids forKey:@"ids"];
    if(ids.length <= 0){
        return;;
    }
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappgoodgetGoodsSpecsPrice,ids) method:GET params:param isToken:NO success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.goodsInfo.promatLabel.text = [NSString stringWithFormat:@"已选%@",data[@"specsValName"]];
        GoodsModel *skuModel = [[GoodsModel alloc] init];
        skuModel.imageId = [NSString stringWithFormat:@"%@",data[@"image"]];
        skuModel.totalStock =  [NSString stringWithFormat:@"%@",data[@"stock"]];
        skuModel.priceSales = [NSString stringWithFormat:@"%@",data[@"salesPrice"]];
        self.stock = [[NSString stringWithFormat:@"%@",data[@"stock"]] integerValue];
        NSLog(@"stock == %ld",    self.stock);
//                countView.countlabel.text = FORMAT(@"单次限%ld%@", self.stock,@"");

        self.goodsSpecsPriceId =[NSString stringWithFormat:@"%@",data[@"id"]];
        [self.goodsInfo initData:skuModel];
    } failure:^(NSError * _Nonnull error) {
        self.goodsSpecsPriceId = @"";
    }];
}
-(void)setEnableSize:(NSString *)choseSizeStr
{
    //用、分割成已选规格数组
    NSArray *choseAttArr = [choseSizeStr componentsSeparatedByString:@"、"];
    //遍历所有规格组合，与已选规格进行匹配
    for (SizeAttributeModel *model in _model.sizeAttribute) {
        NSArray *attArr = [model.value componentsSeparatedByString:@"、"];
        //记录各个规格匹配情况
        NSMutableArray *containsArr = [[NSMutableArray alloc] init];
        //统计规格匹配个数
        int count=0;
        for (NSString *att in attArr) {
            if ([choseAttArr containsObject: att]) {
            //规格一致设为1，不一致设为0，比如已选规格XL、黑色，与XL、黑色、2016的匹配情况就是@[@"1",@"1",@"0"]，后边通过遍历找到@“0”，就能够确定哪个规格没选
                [containsArr addObject:@"1"];
                count++;
            }else
                [containsArr addObject:@"0"];
        }
    //当规格选项还差一个的时候才能确定完整组合对应的库存，进行置灰，比如3个规格，已选2个，当count规格匹配数量为2时，说明当前组合就是已选的2个规格跟未选的那个规格的组合，如果该组合库存为零，就可以置灰
        if (count == attArr.count-1&&[model.stock isEqualToString:@"0"]) {
            //遍历当前规格匹配情况数组
            for (int i = 0; i<containsArr.count; i++) {
                //如果匹配情况为0，则表示这个规格没被选中，可根据这个规格所在顺序，从这个规格的所有情况中找到它，如@[@"1",@"1",@"0"]，标识第三个规格没选，并且其中“2016”这个选项库存为0
                if ([[containsArr objectAtIndex:i] isEqualToString:@"0"]) {
                    GoodsTypeModel *type = _model.itemsList[i];
                    //记录第三个规格所有选项是否置灰情况
                    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:type.enableArray];
                    //遍历未选规格的所有选项
                    for (int j = 0; j<type.typeArray.count; j++) {
                        //找到“2016”这个选项，禁用置灰设为0，不匹配的不做更改
                        if ([[attArr objectAtIndex:i] isEqualToString:[type.typeArray objectAtIndex:j]]) {
                            [arr replaceObjectAtIndex:j withObject:@"0"];
                        }
                    }
                    //重置未选规格的置灰情况数组
                    type.enableArray = arr;
                    //刷新规格列表
                    [self.tableview reloadData];
                }
            }
        }
    }
}
//点击确定
-(void)sure:(UIButton *)sender
{
    if(self.stock <= 0){
        [JXUIKit showErrorWithStatus:@"库存不足"];
        return;;
    }
    if(_model.status == RoleStatusStockPeisong){
        if(self.selectSize){
            self.selectSize(self.goodsId, countView.countTextField.text, self.goodsSpecsPriceId,sender.tag,self.stock, self.goodsInfo.promatLabel.text);
        }
        if(sender.tag == 1){
            [self hideView];
        }
        return;;
    }
    for (GoodsTypeModel *model in _dataSource) {
        if (model.selectIndex<0) {
            [JXUIKit showErrorWithStatus:[NSString stringWithFormat:@"请选择%@",model.typeName]];
            return;
        }
    }
    if (_dataSource.count == 0) {
        //该商品无规格
        [JXUIKit showErrorWithStatus:@"该商品无规格"];
        [self hideView];
        return;
    }
    if(self.selectSize){
        self.selectSize(self.goodsId, countView.countTextField.text, self.goodsSpecsPriceId,sender.tag,self.stock, self.goodsInfo.promatLabel.text);
    }
    if(sender.tag == 1){
        [self hideView];
    }
    //判断库存
//    if ([sizeModel.stock intValue]>0) {
//        if (self.selectSize) {
//            sizeModel.count = countView.countTextField.text;
//            self.selectSize(sizeModel);
//        }
//        [self hideView];
//    }else
//    {
//        [JXUIKit showErrorWithStatus:@"该规格商品暂无库存无法加入购物车"];
//    }
    
}
-(NSArray *)getSizeStr
{
    //拼接属性字符串
    NSString *str=@"";
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableDictionary *datas = [NSMutableDictionary dictionary];
    for (GoodsTypeModel *model in _dataSource) {
        if (model.selectIndex>=0) {
            NSDictionary *dic = model.typeArray[model.selectIndex];
            [datas setValue:dic[@"id"] forKey:@"id"];
//            if ([dic[@"name"] length] == 0) {
//                str = dic[@"name"];
//            }else{
//                str = [NSString stringWithFormat:@"%@、%@",str,dic[@"name"]];
//            }
            [datas setValue:dic[@"name"] forKey:@"name"];
            [temp addObject:datas.mutableCopy];
        }
    }
    return temp.mutableCopy;
}
#pragma mark-数量加减
-(void)add
{
    int count =[countView.countTextField.text intValue];
    count++;
    NSLog(@"count == %d  purchaseRestrictions ==%ld",count, _model.purchaseRestrictions);
    if(_model.status  == RoleStatusRedBag){
        if(count >  _model.purchaseRestrictions){
            
            return;;
        }
    }
    if(_model.status  == RoleStatusStore){
        if(count >  self.stock){
            [JXUIKit showWithString:@"库存不足"];
            return;;
        }
    }
//    self.countlabel.text = [NSString stringWithFormat:@"%ld", count];
    countView.countTextField.text = [NSString stringWithFormat:@"%d",count];

    //如果有选好的属性就根据选好的属性库存判断，没选择就按总库存判断，数量不能超过库存
//    if (sizeModel) {
//        if (count <[sizeModel.stock intValue]) {
//            countView.countTextField.text = [NSString stringWithFormat:@"%d",count+1];
//        }
//    }else
//    {
//        if (count < [_model.totalStock intValue]) {
//
//        }
//    }
    
}
-(void)reduce
{
    int count =[countView.countTextField.text intValue];
    NSLog(@"countsss == %d  ",count);
    count --;
    if (count <= 0) {
        return;
    }
    countView.countTextField.text = [NSString stringWithFormat:@"%d",count];

}
#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.tableview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int count =[countView.countTextField.text intValue];
    if (sizeModel) {
        if (count >[sizeModel.stock intValue]) {
            [JXUIKit showWithString:@"数量超出库存"];
            countView.countTextField.text = sizeModel.stock;
        }
    }else
    {
        if (count > [_model.totalStock intValue]) {
            [JXUIKit showWithString:@"数量超出库存"];
            countView.countTextField.text = _model.totalStock;
            
        }
    }
}
-(void)tfresignFirstResponder
{
    self.tableview.contentOffset = CGPointMake(0, 0);
    [countView.countTextField resignFirstResponder];
}
#pragma mark - tavdelegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ChoosTypeTableViewCell";
    ChoosTypeTableViewCell *cell = [[ChoosTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    cell.modelBig = _model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GoodsTypeModel *model = _dataSource[indexPath.row];
    tableView.rowHeight=[cell setData:model];
    MJWeakSelf
    cell.selectButton = ^(int selectIndex) {
        [weakSelf reloadGoodsInfo];
    };
    return cell;
    
}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
        _tableview.sectionHeaderHeight = 0;
        _tableview.backgroundColor = WhiteColor;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _dataSource = [[NSMutableArray alloc] init];
    
        
        
    }
    return _tableview;
}
-(void)dealloc
{
    NSLog(@"dddddd");
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
