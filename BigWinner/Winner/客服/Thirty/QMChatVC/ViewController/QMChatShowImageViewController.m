//
//  QMChatShowImageViewController.m
//  IMSDK
//
//  Created by lishuijiao on 2020/10/19.
//

#import "QMChatShowImageViewController.h"

@interface QMChatShowImageViewController () <UIAlertViewDelegate,UINavigationControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation QMChatShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];

    self.bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.bgScrollView.backgroundColor = [UIColor blackColor];
    self.bgScrollView.maximumZoomScale = 2.0;
    self.bgScrollView.minimumZoomScale = 1.0;
    self.bgScrollView.decelerationRate = 0.5;
    self.bgScrollView.delegate = self;
    [self.view addSubview:self.bgScrollView];
    
    self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    if ([self.picType isEqualToString:@"0"]) {
        NSString * filePath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",self.picName];
        self.bigImageView.image = [UIImage imageWithContentsOfFile:filePath];
    }else {
        [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:self.picName] placeholderImage:self.image];
    }
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    UILongPressGestureRecognizer * pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.bigImageView addGestureRecognizer:pressGestureRecognizer];
    self.bigImageView.userInteractionEnabled = YES;
    [self.bigImageView addGestureRecognizer:gestureRecognizer];
    [self.bgScrollView addSubview:self.bigImageView];
}

-(void)listenOrientationDidChange {
    self.bigImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

//长按保存图片
- (void)longPressAction:(UILongPressGestureRecognizer *)pressGestureRecognizer {
    if (pressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"title.prompt", nil) message:NSLocalizedString(@"title.savePicture", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"button.cancel", nil) otherButtonTitles:NSLocalizedString(@"button.sure", nil), nil];
        [alertView show];
    }
}

//保存图片代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if ([self.picType isEqualToString:@"0"]) {
            NSString * filePath = [NSString stringWithFormat:@"%@/%@/%@/%@",NSHomeDirectory(),@"Documents",@"SaveFile",self.picName];
            UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:filePath], nil, nil, nil);
        }else {
            NSURL * url = [NSURL URLWithString:self.picName];
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            NSOperationQueue * queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);
            }];
        }
    }
}

//返回
- (void)tapAction {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigImageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}

- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (self.bgScrollView.frame.size.width > self.bgScrollView.contentSize.width) ? ((self.bgScrollView.frame.size.width - self.bgScrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (self.bgScrollView.frame.size.height > self.bgScrollView.contentSize.height) ? ((self.bgScrollView.frame.size.height - self.bgScrollView.contentSize.height) * 0.5) : 0.0;
    self.bigImageView.center = CGPointMake(self.bgScrollView.contentSize.width * 0.5 + offsetX, self.bgScrollView.contentSize.height * 0.5 + offsetY);
}


@end
