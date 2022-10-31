//
//  CodeInputView.h
//  LoadingView
//
//  Created by coolerting on 2018/8/8.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeModel : NSObject
@property(nonatomic,copy) NSString *number;
@property(nonatomic,assign) BOOL isSelected;
@end

typedef NS_ENUM(NSUInteger, cellType) {
    cellTypeNormal = 0,     //普通模式
    cellTypeSecurity,       //密文模式
};

@interface CodeCollectionViewCell : UICollectionViewCell
@property(nonatomic,assign) cellType type;
@property(nonatomic,strong) CodeModel *model;
@end

typedef NS_ENUM(NSUInteger, inputType) {
    inputTypeNormal = 0,
    inputTypeSecurity,
};

@protocol CodeInputViewDelegate;

@interface CodeInputView : UIView

@property(nonatomic,assign) inputType inputType;
@property(nonatomic,copy,readonly) NSString *numberText;
@property (nonatomic,weak) id<CodeInputViewDelegate> delegate;
@property (assign, nonatomic)BOOL isFirst;


- (instancetype)initWithFrame:(CGRect)frame Space:(CGFloat)space Margin:(CGFloat)margin Count:(NSInteger)count;
@end

@protocol CodeInputViewDelegate <NSObject>

@optional
/**
 完成输入时代理

 @param inputView 密码控件
 @param number 密码
 */
- (void)finishEnterCode:(CodeInputView *)inputView code:(NSString *)number;
/**
 开始输入时代理

 @param inputView 密码控件
 */
- (void)beginEnterCode:(CodeInputView *)inputView;
/**
 输入过程代理

 @param inputView 密码控件
 @param number 密码
 */
- (void)codeDuringEnter:(CodeInputView *)inputView code:(NSString *)number;
@end
