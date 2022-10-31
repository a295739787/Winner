//
//  LLShowView.h
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLShowView : UIView
@property (nonatomic,assign) ShowViewState style;/** nss **/
@property(nonatomic,strong)UIImageView *showimage;
@property(nonatomic,strong)UILabel *titlelable;

@end

NS_ASSUME_NONNULL_END
