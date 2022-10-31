//
//  LLShareView.h
//  ShopApp
//
//  Created by lijun L on 2021/4/7.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^shareButton)(NSInteger tagindex,NSString *content);

@interface LLShareView : UIView
@property (nonatomic,copy) shareButton block;
@property (nonatomic,assign) SSDKPlatformType Platform;
@property (nonatomic,assign) BOOL isBao;/** <#class#> **/
@property (nonatomic,copy) NSString *imageUrl;/** <#class#> **/
@property (nonatomic,copy) NSString *linkUrl;/** <#class#> **/
@property (nonatomic,copy) NSString *nameUrl;/** <#class#> **/
@property (nonatomic,copy) NSString *oldpriceStr;/** <#class#> **/
@property (nonatomic,copy) NSString *priceStr;/** <#class#> **/
@property (nonatomic,copy) NSString *notice;/** <#class#> **/
@property (nonatomic,assign) BOOL isVite;/** <#class#> **/

- (void)showActionSheetView;
- (void)hideActionSheetView;
@end

NS_ASSUME_NONNULL_END
