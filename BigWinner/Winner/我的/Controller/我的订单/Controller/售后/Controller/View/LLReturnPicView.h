//
//  LLReturnPicView.h
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLReturnPicView : UIView
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/
@property (nonatomic,assign) BOOL isEdits;/** class **/

@property (nonatomic,copy) void (^selectBlock)(NSArray *image,NSString *pic,CGFloat heights);/** <#class#> **/
@end

NS_ASSUME_NONNULL_END
