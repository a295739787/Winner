//
//  LLAddrssTableView.m
//  ShopApp
//
//  Created by lijun L on 2021/7/13.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLAddrssTableView.h"
#import "LLocationCell.h"


static NSString *const LLocationCellid = @"LLocationCell";
@interface LLAddrssTableView ()

@property (nonatomic, strong) UIImageView *  selectImageView;
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/

@end

@implementation LLAddrssTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = White_Color;
        UIView * view = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:view];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPicker)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [view addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:self.searchBarView];
        [self addSubview:self.tableView];

    }
    return self;
}


-(void)cancelPicker{
    
    self.top = SCREEN_HEIGHT ;
    self.hidden = YES;
}

-(UITableView*)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 60, SCREEN_WIDTH-30, CGFloatBasedI375(350)) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.userInteractionEnabled = YES;
        [_tableView registerClass:[LLocationCell class] forCellReuseIdentifier:LLocationCellid];
    }
    [_tableView draCirlywithColor:nil andRadius:10.f];

    return _tableView ;
}

-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setArray:(NSArray *)array{
    _array = array;
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:_array];
    _selectIndex = 0 ;
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  59;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:LLocationCellid];
    if( [self.dataArr isKindOfClass:[AMapTip class]]){
        AMapTip *poi = [self.dataArr objectAtIndex:indexPath.row];
        cell.titleLabel.text = poi.name;
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        cell.titleLabel.textColor = [UIColor HexString:@"333333"];
        cell.selectImageView.hidden = YES;
        cell.subLabel.text = poi.address;
    }else{
    AMapPOI * poi = [self.dataArr objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = poi.name;
    cell.titleLabel.font = [UIFont systemFontOfSize:15];
    cell.titleLabel.textColor = [UIColor HexString:@"333333"];
    cell.selectImageView.hidden = YES;
    cell.subLabel.text = poi.address;
    }
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectIndex = indexPath.row;
    
    if( [self.dataArr isKindOfClass:[AMapTip class]]){
        AMapTip *tip = [self.dataArr objectAtIndex:indexPath.row];
        AMapPOI * poi  =  [[AMapPOI alloc]init];
        poi.name = tip.name;
        if(self.choicePoi){
            self.choicePoi(poi);
        }
    }else{
    if(self.choicePoi){
        self.choicePoi(self.dataArr[indexPath.row]);
    }
    }
    [tableView reloadData];
}
-(UISearchBar*)searchBarView{
    if (!_searchBarView) {
        _searchBarView = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 40)];
        _searchBarView.searchBarStyle = UISearchBarStyleDefault;
        self.searchBarView.backgroundColor = BG_Color;
                _searchBarView.placeholder = @"搜索";
        self.searchBarView.layer.masksToBounds = YES;
        self.searchBarView.layer.cornerRadius = CGFloatBasedI375(8);
//        self.searchBarView.alpha = 0.3;
        UITextField *textfield = [_searchBarView valueForKey:@"searchField"];
        textfield.backgroundColor  =BG_Color;
        textfield.textColor =[UIColor blackColor] ;
        [textfield setValue:[UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)] forKeyPath:@"placeholderLabel.font"];
        [textfield setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
           textfield.placeholder = @"搜索";
        
        [textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];



    }
    return _searchBarView;
}
- (void) textFieldDidChange:(UITextField*) textfield {
    if(self.textblock){
        self.textblock(textfield.text);
    }
}
@end
