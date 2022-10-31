//
//  LLMoreImageView.h
//  LLPensionProject
//
//  Created by lijun L on 2019/7/12.
//  Copyright © 2019年 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLMoreImageView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) UILabel *contentLabel;/**内容  **/
@property (nonatomic,strong) NSArray *picPathStringsArray;/** <#class#> **/
@property (nonatomic,assign) CGFloat heights;/** <#class#> **/
@property (nonatomic,strong) NSArray *data;/** <#class#> **/
- (CGFloat)setupPicUrlArray:(NSArray *)picUrlArray;
@property (nonatomic, strong) NSArray *picUrlArray;//缩略图URL
//@property (nonatomic, strong) NSArray *picOriArray;//原图url
@property (nonatomic, strong) NSArray *picSingleUrlArray;//缩略图URL
@property (nonatomic,copy) void(^refreshHeight)(CGFloat heights);/** <#class#> **/
@property (nonatomic,strong) NSIndexPath *indexs;/** <#class#> **/

@property (nonatomic,assign) NSInteger circle_type;/** <#class#> **/
@property (nonatomic,assign) CGFloat singleHeight;/** <#class#> **/
@property (nonatomic,assign) BOOL isPraise;/** <#class#> **/
- (instancetype)initWithWidth:(CGFloat)width;
@property (strong, nonatomic) AVPlayerItem* videoItem;

@property (strong, nonatomic) AVPlayer* videoPlayer;

@property (strong, nonatomic) AVPlayerLayer* avLayer;


@end

