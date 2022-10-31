//
//  LLMeDeliverOrderController.m
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import "LLMeDeliverOrderController.h"
#import "XLPageViewController.h"
#import "LLMeDeliverListVC.h"
#import "LLTabbarPeisongViewController.h"
@interface LLMeDeliverOrderController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray *vcArr;
@property (nonatomic,strong)NSMutableArray *listArray;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation LLMeDeliverOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self creatbackbtn];
    
    self.disableDragBack = YES;
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.payui){
            LLTabbarPeisongViewController *thirdVC=  [[LLTabbarPeisongViewController alloc]init];
            thirdVC.selectedIndex = 1;
            [UIApplication sharedApplication ].delegate.window.rootViewController =  thirdVC;
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
}

-(void)creatbackbtn{
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.payui == YES){
            LLTabbarViewController *va = [[LLTabbarViewController alloc]init];
            va.selectedIndex = 4;
            [UIApplication sharedApplication].keyWindow.rootViewController = va;
            
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"我的订单";
    
    _listArray = [[NSMutableArray alloc]initWithObjects:@"全部",@"待发货",@"待收货",@"已完成", nil];
    _vcArr = [[NSMutableArray alloc] init];
    for (int i = 0; i <  _listArray.count; i++) {

        LLMeDeliverListVC *listView = [[LLMeDeliverListVC alloc]init];
        listView.orderStatus = i;
        [_vcArr addObject:listView];
    }
    
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题间距
    config.titleSpace = 60;
    //标题选中颜色
    config.titleSelectedColor = UIColorFromRGB(0xD40006);
    //标题选中字体
    config.titleSelectedFont = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    //标题正常颜色
    config.titleNormalColor = UIColorFromRGB(0x666666);
    //标题正常字体
    config.titleNormalFont = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    //隐藏动画线条
    config.shadowLineHidden = NO;
    //分割线颜色
    config.separatorLineColor = [UIColor clearColor];
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    config.titleViewStyle = XLPageTitleViewStyleBasic;
    
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT -  SCREEN_top - SCREEN_Bottom);
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.selectedIndex = self.index;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    LLMeDeliverListVC *vc = [[LLMeDeliverListVC alloc] init];
    return vc;
}
- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.listArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.listArray.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    
    _currentIndex = index;
    NSLog(@"切换到了：%@",self.listArray[index]);
}


@end
