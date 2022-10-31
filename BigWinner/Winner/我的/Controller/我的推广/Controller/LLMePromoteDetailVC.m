//
//  LLMePromoteDetailVC.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLMePromoteDetailVC.h"
#import "XLPageViewController.h"
#import "LLPromiteListController.h"

@interface LLMePromoteDetailVC ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray *vcArr;
@property (nonatomic,strong)NSMutableArray *listArray;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation LLMePromoteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.customNavBar.title = @"推广佣金明细";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _listArray = [[NSMutableArray alloc]initWithObjects:@"全部",@"已结算",@"待结算", nil];
    _vcArr = [[NSMutableArray alloc] init];
    for (int i = 0; i <  _listArray.count; i++) {

        LLPromiteListController *listView = [[LLPromiteListController alloc]init];
        listView.userId = self.userId;
        listView.status = i;
        if(_status > 0){
            listView.status = _status;
        }else{
            listView.status = i;
        }
        [_vcArr addObject:listView];
    }
    
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题间距
    config.titleSpace = 100;
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
    
    
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:config];
    self.pageViewController.view.frame = CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT -  SCREEN_top - SCREEN_Bottom - CGFloatBasedI375(40));
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.selectedIndex  =_status;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    LLPromiteListController *vc = [[LLPromiteListController alloc] init];
    vc.userId = self.userId;
    vc.status = index;
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
