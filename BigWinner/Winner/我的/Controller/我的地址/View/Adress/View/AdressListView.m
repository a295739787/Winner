//
//  AdressListView.m
//  xkb
//
//  Created by YP on 2019/3/29.
//  Copyright © 2019年 刘文博. All rights reserved.
//

#import "AdressListView.h"
#import "AdressListTableView.h"
#import "AdressModel.h"

@interface AdressListView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contView;
@property (nonatomic,strong)UILabel *titLabel;
@property (nonatomic,strong)UIView *tableConView;
@property (nonatomic,strong)UIView *currentView;
@property (nonatomic,strong)AdressListTableView *privenceView;
@property (nonatomic,strong)AdressListTableView *cityView;
@property (nonatomic,strong)AdressListTableView *countyView;

@property (nonatomic,strong)NSString *provinceId;
@property (nonatomic,strong)NSString *cityId;
@property (nonatomic,strong)NSString *districtId;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *rsNo;
@property (nonatomic,strong)NSString *provinceName;
@property (nonatomic,strong)NSString *districtName;
@property (nonatomic,strong)NSString *cityName;

@end

@implementation AdressListView

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
    [self addSubview:self.contView];
    [self.contView addSubview:self.titLabel];
    [self.contView addSubview:self.tableConView];
    [self.contView addSubview:self.currentView];
    [self.tableConView addSubview:self.privenceView];
    [self.tableConView addSubview:self.cityView];
    [self.tableConView addSubview:self.countyView];
    
    
}
#pragma mark--tap
-(void)tap{
    WS(weakself);
    [UIView animateWithDuration:0.15 animations:^{
        weakself.contView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - CGFloatBasedI375(371));
    }];
    [self removeFromSuperview];
}
-(void)setType:(NSInteger)type{
    if (type == 0) {
//
        WS(weakself);
        [UIView animateWithDuration:0.15 animations:^{
            
             weakself.contView.frame = CGRectMake(0, CGFloatBasedI375(371), SCREEN_WIDTH, SCREEN_HEIGHT - CGFloatBasedI375(371));
        }];
    }
}
-(void)setDataArray:(NSArray *)dataArray{
    self.privenceView.dataArray = dataArray;
}
-(void)setIndex:(NSInteger)index{
    self.privenceView.index = index;
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.5;
        _bottomView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.numberOfTapsRequired = 1;
        [_bottomView addGestureRecognizer:tap];
    }
    return _bottomView;
}
-(UIView *)contView{
    if (!_contView) {
        _contView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - CGFloatBasedI375(371))];
        _contView.backgroundColor = [UIColor clearColor];
    }
    return _contView;
}
-(UILabel *)titLabel{
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(50))];
        _titLabel.text = @"所在地区";
        _titLabel.backgroundColor = [UIColor whiteColor];
        _titLabel.layer.cornerRadius = CGFloatBasedI375(8);
        _titLabel.font = AdaptedFontSize(14);
        _titLabel.textAlignment = NSTextAlignmentCenter;
        _titLabel.textColor = UIColorFromRGB(0x000000);
        _titLabel.layer.cornerRadius = CGFloatBasedI375(8);
        _titLabel.clipsToBounds = YES;
    }
    return _titLabel;
}
-(UIView *)tableConView{
    if (!_tableConView) {
        _tableConView = [[UIView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(45), SCREEN_WIDTH, SCREEN_HEIGHT - CGFloatBasedI375(371+45))];
        _tableConView.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < 3; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*CGFloatBasedI375(90), 0, CGFloatBasedI375(90), CGFloatBasedI375(20));
            if (i == 0) {
                [button setTitle:@"请选择" forState:UIControlStateNormal];
            }
            button.titleLabel.font = AdaptedFontSize(12);
            button.tag = i + 100;
            [button setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            [_tableConView addSubview:button];
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(25), SCREEN_WIDTH, CGFloatBasedI375(1))];
        line.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [_tableConView addSubview:line];
    }
    return _tableConView;
}
-(UIView *)currentView{
    if (!_currentView) {
        _currentView  = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(25), CGFloatBasedI375(70), CGFloatBasedI375(40), CGFloatBasedI375(2))];
        _currentView.backgroundColor = UIColorFromRGB(0x03A6FF);
    }
    return _currentView;
}
-(AdressListTableView *)privenceView{
    if (!_privenceView) {
        _privenceView = [[AdressListTableView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(30), CGFloatBasedI375(90), SCREEN_HEIGHT - CGFloatBasedI375(371+70))];
        WS(weakself);
        _privenceView.selectBlock = ^(NSDictionary *dict, NSInteger index) {
            if (index == 0) {
                
                weakself.provinceId = dict[@"id"];
                weakself.provinceName = dict[@"fullName"];
                
                UIButton *pBtn = [weakself.tableConView viewWithTag:100];
                [pBtn setTitle:weakself.provinceName forState:UIControlStateNormal];
                
                UIButton *cBtn = [weakself.tableConView viewWithTag:101];
                [cBtn setTitle:@"请选择" forState:UIControlStateNormal];
                
                UIButton *dBtn = [weakself.tableConView viewWithTag:102];
                [dBtn setTitle:@"" forState:UIControlStateNormal];
                
                weakself.cityView.dataArray = dict[@"appProvinceListVos"];
                weakself.countyView.dataArray = @[];
                weakself.cityView.index = 1;
            }
        };
    }
    return _privenceView;
}
-(AdressListTableView *)cityView{
    if (!_cityView) {
        _cityView = [[AdressListTableView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(90), CGFloatBasedI375(30), CGFloatBasedI375(90), SCREEN_HEIGHT - CGFloatBasedI375(371+70))];
        WS(weakself);
        _cityView.selectBlock = ^(NSDictionary *dict, NSInteger index) {
            if (index == 1) {
                weakself.cityId = dict[@"id"];
                weakself.cityName = dict[@"fullName"];
                
                UIButton *cBtn = [weakself.tableConView viewWithTag:101];
                [cBtn setTitle:weakself.cityName forState:UIControlStateNormal];
                
                UIButton *dBtn = [weakself.tableConView viewWithTag:102];
                [dBtn setTitle:@"请选择" forState:UIControlStateNormal];
                
                weakself.countyView.dataArray = dict[@"appProvinceListVos"];
                weakself.countyView.index = 2;
            }
        };
    }
    return _cityView;
}
-(AdressListTableView *)countyView{
    if (!_countyView) {
        _countyView = [[AdressListTableView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(90*2), CGFloatBasedI375(30), CGFloatBasedI375(90), CGFloatBasedI375(371+70))];
        WS(weakself);
        _countyView.selectBlock = ^(NSDictionary *dict, NSInteger index) {
            if (index == 2) {
                weakself.districtId = dict[@"id"];
                weakself.districtName = dict[@"fullName"];
                
                UIButton *dBtn = [weakself.tableConView viewWithTag:102];
                [dBtn setTitle:weakself.districtName forState:UIControlStateNormal];
                
                NSMutableDictionary *selelctDict = [[NSMutableDictionary alloc]init];
                [selelctDict setObject:weakself.districtId forKey:@"districtId"];
                [selelctDict setObject:weakself.districtName forKey:@"districtName"];
                [selelctDict setObject:weakself.provinceId forKey:@"provinceId"];
                [selelctDict setObject:weakself.provinceName forKey:@"provinceName"];
                [selelctDict setObject:weakself.cityId forKey:@"cityId"];
                [selelctDict setObject:weakself.cityName forKey:@"cityName"];
                
                [weakself removeFromSuperview];
                weakself.adressBlock(selelctDict);
            }
        };
    }
    return _countyView;
}


@end
