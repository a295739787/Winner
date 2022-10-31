//
//  LLMapChoiceViewController.h
//  ShopApp
//
//  Created by lijun L on 2021/7/13.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLMapChoiceViewController : LMHBaseViewController
@property (nonatomic,assign) BOOL isShow;/** <#class#> **/

@property (nonatomic,assign) BOOL isChat;/** <#class#> **/
@property (nonatomic,copy) void(^choicePoi)(AMapPOI *poi);/** <#class#> **/
@property (nonatomic, copy) void (^sendCompletion)(CLLocationCoordinate2D aCoordinate, NSString *aAddress,NSString *details);
@end

NS_ASSUME_NONNULL_END
