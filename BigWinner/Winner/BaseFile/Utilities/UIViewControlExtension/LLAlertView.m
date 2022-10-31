//
//  LLAlertView.m
//  Wisdomfamily
//
//  Created by libj on 2019/5/17.
//  Copyright © 2019 lijun L. All rights reserved.
//

#import "LLAlertView.h"


@interface LLAlertView ()

@property ( nonatomic, strong ) UIView * mskView;
@property ( nonatomic, strong ) UIView * cntView;
@property ( nonatomic, strong ) UILabel * titleLabel;
@property ( nonatomic, strong ) UILabel * messageLabel;
@property ( nonatomic, strong ) UIButton * ensureBtn;
@property ( nonatomic, strong ) UIButton * canceBtn;
@property ( nonatomic, strong ) UIView * vSepLine;
@property ( nonatomic, strong ) UIView * hSepLine;

@property ( nonatomic, strong ) UIImageView * hintImageView;
@property ( nonatomic, copy ) void(^ensureBlock)( NSString * res );
@property ( nonatomic, copy ) void(^cancelBlock)(void);
@property ( nonatomic, copy ) void(^clickBtnBlock)(NSInteger index);

@end

@implementation LLAlertView

+ (void)showWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray <NSString *>*)actionTitles inController:(UIViewController *)vc complete:(ClickCompleteBlock)cb{
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSInteger i = 0; i < actionTitles.count; i++) {
        NSString *atitle = actionTitles[i];
        UIAlertAction * action =[UIAlertAction actionWithTitle:atitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cb(i);
        }];
        [alertView addAction:action];
    }
    
    [vc presentViewController:alertView animated:YES completion:nil];
}




+ ( void ) showWithTitle:(NSString *) title
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock {
    
    //    [self showWithTitle:title ensureTitle:ensure cancelTitle:cancel ensureBlock:ensureBlock cancelBlock:nil];
    [self showWithTitle:nil message:title ensureTitle:ensure cancelTitle:cancel hintImageViewName:nil alertViewType:AlertView_TwoButton ensureBlock:ensureBlock cancelBlock:nil];
    
}



+ ( void ) showWithTitle:(NSString *) title
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock
             cancelBlock:( void(^)(void) ) cancelBlock {
    
    LLAlertView * alertView = [[LLAlertView alloc] init];
    alertView.titleLabel.text = title;
    [alertView.canceBtn setTitle:cancel forState:UIControlStateNormal];
    [alertView.ensureBtn setTitle:ensure forState:UIControlStateNormal];
    alertView.ensureBlock = ensureBlock;
    alertView.cancelBlock = cancelBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    [alertView.ensureBtn setTitleColor:[UIColor colorWithHexString:@"#DB2A21"] forState:UIControlStateNormal];

    CGAffineTransform origin = alertView.transform;
    alertView.cntView.transform = CGAffineTransformScale(alertView.cntView.transform, 0.6, 0.6);
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        alertView.cntView.transform = CGAffineTransformScale(origin, 1.1, 1.1);
        alertView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
            
            alertView.cntView.transform = origin;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}


#warning 2018.9.18
/**
 两个按钮 有标题 title 标题 message 副标题 ensure 确定按钮文字 cancel 取消按钮文字
 @param title 标题
 @param message 副标题
 @param ensure 确定按钮文字
 @param cancel 取消按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock {
    [self showWithTitle:title message:message ensureTitle:ensure cancelTitle:cancel hintImageViewName:nil alertViewType:AlertView_TwoButton ensureBlock:ensureBlock cancelBlock:nil];
}
/**
 两个按钮 有标题 title 标题 message 副标题 ensure 确定按钮文字 cancel 取消按钮文字 cancelBlock 取消事件
 @param title 标题
 @param message 副标题
 @param ensure 确定按钮文字
 @param cancel 取消按钮文字
 @param ensureBlock 确定事件 Block
 @param cancelBlock 取消事件 cancelBlock
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock
             cancelBlock:( void(^)(void) ) cancelBlock {
    [self showWithTitle:title message:message ensureTitle:ensure cancelTitle:cancel hintImageViewName:nil alertViewType:AlertView_TwoButton ensureBlock:ensureBlock cancelBlock:cancelBlock];
}

/**
 只有一个按钮 有标题 title 标题 message 副标题 ensure 确定按钮文字
 @param title 标题
 @param message 副标题
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock {
    [self showWithTitle:title message:message ensureTitle:ensure cancelTitle:nil hintImageViewName:nil alertViewType:AlertView_OneButton ensureBlock:ensureBlock cancelBlock:nil];
}

/**
 只有一个按钮 无标题  message 副标题 ensure 确定按钮文字
 @param message 副标题
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithMessage:(NSString *) message
               ensureTitle:(NSString *) ensure
               ensureBlock:( void(^)( NSString * res ) ) ensureBlock {
    [self showWithTitle:nil message:message ensureTitle:ensure cancelTitle:nil hintImageViewName:nil alertViewType:AlertView_OneButton ensureBlock:ensureBlock cancelBlock:nil];
}

/**
 只有一个按钮和图片 message 副标题 imgName 图片名 ensure 确定按钮文字
 @param message 副标题
 @param imgName 图片名
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithMessage:(NSString *) message
         hintImageViewName:(NSString *) imgName
               ensureTitle:(NSString *) ensure
               ensureBlock:( void(^)( NSString * res ) ) ensureBlock {
    [self showWithTitle:nil message:message ensureTitle:ensure cancelTitle:nil hintImageViewName:imgName alertViewType:AlertView_OneButtonAndImage ensureBlock:ensureBlock cancelBlock:nil];
}

/**
 只有一个按钮和图片 title 标题 message 副标题 imgName 图片名 ensure 确定按钮文字
 @param message 副标题
 @param imgName 图片名
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
       hintImageViewName:(NSString *) imgName
             ensureTitle:(NSString *) ensure
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock {
    [self showWithTitle:title message:message ensureTitle:ensure cancelTitle:nil hintImageViewName:imgName alertViewType:AlertView_OneButtonAndImage ensureBlock:ensureBlock cancelBlock:nil];
}
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
       hintImageViewName:(NSString *) imgName
           alertViewType:(AlertViewType) type
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock
             cancelBlock:( void(^)(void) ) cancelBlock {
    LLAlertView * alertView = [[LLAlertView alloc] init];
    [alertView initWithAlertViewType:type];
    alertView.titleLabel.text = title;
    alertView.messageLabel.text = message;
    alertView.hintImageView.image = [UIImage imageNamed:imgName];
    [alertView.canceBtn setTitle:cancel forState:UIControlStateNormal];
    [alertView.ensureBtn setTitle:ensure forState:UIControlStateNormal];
    alertView.ensureBlock = ensureBlock;
    alertView.cancelBlock = cancelBlock;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 4;//行间距
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithFontSize:13], NSParagraphStyleAttributeName:paragraphStyle};//字体大小 行间距  颜色
    alertView.messageLabel.attributedText = [[NSAttributedString alloc]initWithString:message attributes:attributes];
    
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    CGAffineTransform origin = alertView.transform;
    alertView.cntView.transform = CGAffineTransformScale(alertView.cntView.transform, 0.6, 0.6);
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        alertView.cntView.transform = CGAffineTransformScale(origin, 1.1, 1.1);
        alertView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
            
            alertView.cntView.transform = origin;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}



+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray<NSString *> *)btnTitles clickBtn:(void (^)(NSInteger index))clickBtnBlock{
    
    
    LLAlertView * alertView = [[LLAlertView alloc] init];
    alertView.titleLabel.text = title;
    alertView.messageLabel.text = message;
    alertView.clickBtnBlock = clickBtnBlock;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 4;//行间距
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithFontSize:13], NSParagraphStyleAttributeName:paragraphStyle};//字体大小 行间距  颜色
    alertView.messageLabel.attributedText = [[NSAttributedString alloc]initWithString:message attributes:attributes];
    [alertView initWithAlertViewBtnTitles:btnTitles];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    CGAffineTransform origin = alertView.transform;
    alertView.cntView.transform = CGAffineTransformScale(alertView.cntView.transform, 0.6, 0.6);
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        alertView.cntView.transform = CGAffineTransformScale(origin, 1.1, 1.1);
        alertView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
            
            alertView.cntView.transform = origin;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}


- ( void ) ensureBtnDidClicked:(UIButton *) sender {
    
    self.ensureBlock(@"");
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        self.cntView.transform = CGAffineTransformScale(self.cntView.transform, 0.6, 0.6);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- ( void ) cancelBtnDidClicked:(UIButton *) sender {
    
    if(self.cancelBlock != nil){
        self.cancelBlock();
    }
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        self.cntView.transform = CGAffineTransformScale(self.cntView.transform, 0.6, 0.6);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void) tapHideView {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        self.cntView.transform = CGAffineTransformScale(self.cntView.transform, 0.6, 0.6);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void) btnDidClicked:(UIButton *)sender {
    if(self.clickBtnBlock != nil){
        self.clickBtnBlock(sender.tag-1000);
    }
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        self.cntView.transform = CGAffineTransformScale(self.cntView.transform, 0.6, 0.6);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark
#pragma mark
#pragma mark -- 生命周期
- ( instancetype ) init {
    
    self = [super init];
    if( self ){
        
        [self setBaseAttribute];
        
    }
    return self;
}

- (void) initWithAlertViewType:(AlertViewType) type {
    if (type == AlertView_TwoButton) {
        [self setupSubviews];
        [self setupSubviewsLayout];
    }else if (type == AlertView_OneButton) {
        [self setupSubviewsOneButton];
        [self setupSubviewsLayoutOneButton];
    }else if (type == AlertView_OneButtonAndImage) {
        [self setupSubviewsOneButtonAndImge];
        [self setupSubviewsLayoutOneButtonAndImage];
    }
}


- (void) initWithAlertViewBtnTitles:(NSArray *) titles {
    
    [self addSubview:self.mskView];
    [self addSubview:self.cntView];
    [self.cntView addSubview:self.titleLabel];
    [self.cntView addSubview:self.messageLabel];
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [self.mskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cntView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset((53));
        make.right.equalTo(self.mas_right).offset(CGFloatBasedI375(-53));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.cntView.mas_top).offset(CGFloatBasedI375(33));
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(45));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(45));
        make.centerX.equalTo(self.cntView);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(16));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(16));
        make.centerX.equalTo(self.cntView);
        make.bottom.equalTo(self.cntView.mas_bottom).offset(-(CGFloatBasedI375(44)*titles.count+ CGFloatBasedI375(13)));
    }];
    
    UIButton *lastButton;
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:0];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithFontSize:15];
        [button addTarget:self action:@selector(btnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.cntView addSubview:button];
        button.tag = i+1000;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastButton) {
                make.top.equalTo(lastButton.mas_bottom).offset(CGFloatBasedI375(0));
            }else{
                make.top.equalTo(self.messageLabel.mas_bottom).offset(CGFloatBasedI375(13));
            }
            make.left.right.equalTo(self.cntView);
            make.height.mas_equalTo(CGFloatBasedI375(44));
        }];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#3F3F3F"];
        lineView.alpha = 0.05;
        [self.cntView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cntView);
            make.height.equalTo(@1);
            make.top.equalTo(button.mas_top);
        }];
        lastButton = button;
    }
    
}

- ( void ) setBaseAttribute {
    self.cntView.backgroundColor = [UIColor whiteColor];
}

- ( void ) setupSubviews {
    
    [self addSubview:self.mskView];
    [self addSubview:self.cntView];
    [self.cntView addSubview:self.titleLabel];
    [self.cntView addSubview:self.canceBtn];
    [self.cntView addSubview:self.ensureBtn];

    [self.cntView addSubview:self.vSepLine];
    [self.cntView addSubview:self.hSepLine];
    [self.cntView addSubview:self.messageLabel];
}
- ( void ) setupSubviewsOneButton {
    
    [self addSubview:self.mskView];
    [self addSubview:self.cntView];
    [self.cntView addSubview:self.titleLabel];
    [self.cntView addSubview:self.messageLabel];
    [self.cntView addSubview:self.ensureBtn];
    [self.cntView addSubview:self.hSepLine];
    
}
- ( void ) setupSubviewsOneButtonAndImge {
    
    [self addSubview:self.mskView];
    [self addSubview:self.cntView];
    [self.cntView addSubview:self.hintImageView];
    [self.cntView addSubview:self.titleLabel];
    [self.cntView addSubview:self.messageLabel];
    [self.cntView addSubview:self.ensureBtn];
    [self.cntView addSubview:self.hSepLine];
    
}
- ( void ) setupSubviewsLayout {
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [self.mskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cntView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset((53));
        make.right.equalTo(self.mas_right).offset(CGFloatBasedI375(-53));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.cntView.mas_top).offset(CGFloatBasedI375(20));
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(10));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(10));
        make.centerX.equalTo(self.cntView);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(16));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(16));
        make.centerX.equalTo(self.cntView);
    }];
    [self.hSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.messageLabel.mas_bottom).offset(CGFloatBasedI375(13));
        make.bottom.equalTo(self.cntView.mas_bottom).offset(CGFloatBasedI375(-44));
        make.left.right.equalTo(self.cntView);
        make.height.equalTo(@1);
    }];
    
    [self.vSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hSepLine);
        make.width.equalTo(@1);
        make.top.equalTo(self.hSepLine.mas_bottom);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.canceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
  
        make.left.bottom.equalTo(self.cntView);
        make.right.equalTo(self.vSepLine.mas_left);
        make.height.equalTo(self.vSepLine);
    }];
    
    [self.ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self.cntView);
        make.left.equalTo(self.vSepLine.mas_right);
        make.height.equalTo(self.vSepLine);
    }];
    
}
- ( void ) setupSubviewsLayoutOneButton {
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [self.mskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cntView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(CGFloatBasedI375(53));
        make.right.equalTo(self.mas_right).offset(CGFloatBasedI375(-53));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.cntView.mas_top).offset(CGFloatBasedI375(20));
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(10));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(10));
        make.centerX.equalTo(self.cntView);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(16));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(16));
        make.centerX.equalTo(self.cntView);
    }];
    [self.hSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.messageLabel.mas_bottom).offset(CGFloatBasedI375(13));
        make.bottom.equalTo(self.cntView.mas_bottom).offset(CGFloatBasedI375(-44));
        make.left.right.equalTo(self.cntView);
        make.height.equalTo(@1);
    }];
    [self.ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.cntView);
        make.height.equalTo(@44);
    }];
    
}

- ( void ) setupSubviewsLayoutOneButtonAndImage {
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [self.mskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cntView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(CGFloatBasedI375(53));
        make.right.equalTo(self.mas_right).offset(CGFloatBasedI375(-53));
        make.centerY.equalTo(self);
    }];
    
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.cntView.mas_top).offset(CGFloatBasedI375(15));
        make.centerX.equalTo(self.cntView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(10));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(10));
        make.centerX.equalTo(self.cntView);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.cntView).offset(CGFloatBasedI375(16));
        make.right.equalTo(self.cntView).offset(-CGFloatBasedI375(16));
        make.centerX.equalTo(self.cntView);
    }];
    [self.hSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.messageLabel.mas_bottom).offset(CGFloatBasedI375(13));
        make.bottom.equalTo(self.cntView.mas_bottom).offset(CGFloatBasedI375(-44));
        make.left.right.equalTo(self.cntView);
        make.height.equalTo(@1);
    }];
    [self.ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.cntView);
        make.height.equalTo(@44);
    }];
    
}


#pragma mark
#pragma mark
#pragma mark -- subviews create
- ( UIView * ) mskView {
    
    if( !_mskView ){
        _mskView = [[UIView alloc] init];
        _mskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideView)];
        [_mskView addGestureRecognizer:tap];
    }
    return _mskView;
}

- ( UIView * ) cntView {
    
    if( !_cntView ){
        _cntView = [[UIView alloc] init];
        _cntView.backgroundColor = [UIColor whiteColor];
        _cntView.layer.masksToBounds = YES;
        _cntView.layer.cornerRadius  = 13;
    }
    return _cntView;
}

- ( UILabel * ) titleLabel {
    
    if( !_titleLabel ){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldFontWithFontSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 1000;
        _titleLabel.textAlignment = 1;
//        _titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-CGFloatBasedI375(80);
    }
    return _titleLabel;
}
- ( UILabel * ) messageLabel {
    
    if( !_messageLabel ){
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont fontWithFontSize:13];
        _messageLabel.textColor = [UIColor colorWithHexString:@"#030303"];
        _messageLabel.numberOfLines = 1000;
        _messageLabel.textAlignment = 1;
//        _messageLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width-CGFloatBasedI375(80);
    }
    return _messageLabel;
}
- ( UIButton * ) ensureBtn {
    if ( !_ensureBtn ) {
        _ensureBtn = [UIButton buttonWithType:0];
        [_ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_ensureBtn setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:UIControlStateNormal];
        _ensureBtn.titleLabel.font = [UIFont fontWithFontSize:15 fontWeight:UIFontWeightHeavy];
        [_ensureBtn addTarget:self action:@selector(ensureBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_ensureBtn setTitleColor:[UIColor colorWithHexString:@"#DB2A21"] forState:UIControlStateNormal];

    }
    return _ensureBtn;
}

- ( UIButton * ) canceBtn {
    if ( !_canceBtn ) {
        _canceBtn = [UIButton buttonWithType:0];
        [_canceBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_canceBtn setTitleColor:[UIColor HexString:@"007AFF"] forState:UIControlStateNormal];
        _canceBtn.titleLabel.font = [UIFont fontWithFontSize:15 fontWeight:UIFontWeightHeavy];
        [_canceBtn addTarget:self action:@selector(cancelBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canceBtn;
}

- ( UIView * ) vSepLine {
    
    if ( !_vSepLine ) {
        _vSepLine = [[UIView alloc] init];
        _vSepLine.backgroundColor = [UIColor HexString:@"3F3F3F"];
        _vSepLine.alpha = 0.05;
    }
    return _vSepLine;
}


- ( UIView * ) hSepLine {
    
    if ( !_hSepLine ) {
        _hSepLine = [[UIView alloc] init];
        _hSepLine.backgroundColor = [UIColor HexString:@"3F3F3F"];
        _hSepLine.alpha = 0.05;
    }
    return _hSepLine;
}

- (UIImageView *)hintImageView {
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
        _hintImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _hintImageView;
}


@end
