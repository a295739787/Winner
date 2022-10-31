
//
//  GoodsInfoView.m
//  ChoseGoodsType
//
//  Created by 澜海利奥 on 2018/1/30.
//  Copyright © 2018年 江萧. All rights reserved.
//

#import "GoodsInfoView.h"
#import "Header.h"
#import "SizeAttributeModel.h"
@interface GoodsInfoView()
@property(nonatomic, strong)UIImageView *goodsImage;
@property(nonatomic, strong)UILabel *goodsTitleLabel;
@property(nonatomic, strong)UILabel *goodsCountLabel;
@property(nonatomic, strong)UILabel *goodsPriceLabel;
@property(nonatomic, strong)UILabel *goodsOldPricelable;
@end
@implementation GoodsInfoView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //商品图片
        _goodsImage = [[UIImageView alloc] init];
        _goodsImage.image = [UIImage imageNamed:@"1"];
        _goodsImage.contentMode =  UIViewContentModeScaleAspectFill;
        _goodsImage.clipsToBounds  = YES;
        [self addSubview:_goodsImage];
        [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-CGFloatBasedI375(15));
            make.left.offset(CGFloatBasedI375(15));
            make.height.mas_equalTo(CGFloatBasedI375(100));
            make.width.mas_equalTo(CGFloatBasedI375(100));
        }];
        //关闭按钮
        _closeButton = [JXUIKit buttonWithBackgroundColor:[UIColor whiteColor] imageForNormal:@"xzgg_close" imageForSelete:@"xzgg_close"];
        [self addSubview:_closeButton];
        [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(CGFloatBasedI375(15));
            make.right.offset(-CGFloatBasedI375(15));
            make.height.mas_equalTo(CGFloatBasedI375(20));
            make.width.mas_equalTo(CGFloatBasedI375(20));
        }];
        //标题
//        _goodsTitleLabel = [JXUIKit labelWithBackgroundColor:WhiteColor textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:0 fontSize:0 font:[UIFont systemFontOfSize:15] text:@"标题"];
//        [self addSubview:_goodsTitleLabel];
        WS(weakself);
        //价格
        _goodsPriceLabel = [JXUIKit labelWithBackgroundColor:WhiteColor textColor:KBtncol textAlignment:NSTextAlignmentLeft numberOfLines:0 fontSize:0 font:[UIFont systemFontOfSize:14] text:@"197"];
        [self addSubview:_goodsPriceLabel];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(CGFloatBasedI375(15));
            make.left.equalTo(weakself.goodsImage.mas_right).offset(CGFloatBasedI375(10));
        
        }];
        
        //原价
        _goodsOldPricelable =[[UILabel alloc]init];
        _goodsOldPricelable.text = @"¥0.00";
        _goodsOldPricelable.textColor =lightGray9999_Color;
        _goodsOldPricelable.textAlignment = NSTextAlignmentLeft;
        _goodsOldPricelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self addSubview:_goodsOldPricelable];
        [self.goodsOldPricelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.goodsPriceLabel.mas_centerY);
            make.left.equalTo(weakself.goodsPriceLabel.mas_right).offset(CGFloatBasedI375(10));
        }];
        
        //库存
        _goodsCountLabel = [JXUIKit labelWithBackgroundColor:WhiteColor textColor:[UIColor colorWithHexString:@"#CCCCCC"] textAlignment:NSTextAlignmentLeft numberOfLines:0 fontSize:0 font:[UIFont systemFontOfSize:CGFloatBasedI375(13)] text:@"库存"];
        [self addSubview:_goodsCountLabel];
        [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsPriceLabel.mas_bottom).offset(CGFloatBasedI375(5));
            make.left.equalTo(weakself.goodsImage.mas_right).offset(CGFloatBasedI375(5));
     
        }];
     
//        _goodsCountLabel.sd_layout.leftSpaceToView(_goodsImage, kSize(10)).rightSpaceToView(_closeButton, kSize(10)).heightIs(kSize(20)).topSpaceToView(_goodsPriceLabel, 0);
        
        
        
        //选择提示文字
        _promatLabel = [JXUIKit labelWithBackgroundColor:WhiteColor textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:0 fontSize:0 font:[UIFont systemFontOfSize:14] text:@""];
        [self addSubview:_promatLabel];
        [self.promatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsCountLabel.mas_bottom).offset(CGFloatBasedI375(5));
            make.left.equalTo(weakself.goodsImage.mas_right).offset(CGFloatBasedI375(5));
     
        }];
        
    }
    return self;
}
-(void)initData:(GoodsModel *)model
{
    _model = model;

    [_goodsImage sd_setImageWithUrlString:model.imageId];
    //[goodsImage sd_setImageWithURL:[NSURL URLWithString:[kThumbImageUrl stringByAppendingString:model.imageId]] placeholderImage:kDefaultImage];
    _goodsTitleLabel.text = model.title;
    _goodsCountLabel.text = [NSString stringWithFormat:@"库存：%@",model.totalStock];
    _goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@ ¥%@",model.priceSales,model.price.minOriginalPrice];
    NSMutableAttributedString *attritu = [[NSMutableAttributedString alloc]initWithString:_goodsPriceLabel.text];
    [attritu addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick), NSForegroundColorAttributeName: [UIColor lightGrayColor],NSBaselineOffsetAttributeName:@(0),
                             NSFontAttributeName: [UIFont systemFontOfSize:13]
                             } range:[_goodsPriceLabel.text rangeOfString:[NSString stringWithFormat:@"¥%@",model.price.minOriginalPrice]]];
    _goodsPriceLabel.attributedText = attritu;
    _goodsPriceLabel.attributedText = [self getAttribuStrWithStrings:@[@"¥",FORMAT(@"%.2f",model.priceSales.floatValue)] fonts:@[[UIFont systemFontOfSize:13],[UIFont boldFontWithFontSize:CGFloatBasedI375(16)]]];
    
    if(_model.scribingPrice.length  > 0){
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:FORMAT(@"￥%.2f",_model.scribingPrice.floatValue)];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,str.length)];
        self.goodsOldPricelable.attributedText = str;
    }
}

//根据选择的属性组合刷新商品信息
-(void)resetData:(SizeAttributeModel *)sizeModel
{
    //如果有图片就显示图片，没图片就显示默认图
    if (sizeModel.imageId.length>0) {
        [_goodsImage setImage:[UIImage imageNamed:sizeModel.imageId]];
    }else
        [_goodsImage setImage:[UIImage imageNamed:_model.imageId]];
    
    _goodsCountLabel.text = [NSString stringWithFormat:@"库存：%@",sizeModel.stock];
    _goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@ ¥%@",sizeModel.price,sizeModel.originalPrice];
    NSMutableAttributedString *attritu = [[NSMutableAttributedString alloc]initWithString:_goodsPriceLabel.text];
    [attritu addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick), NSForegroundColorAttributeName: [UIColor lightGrayColor],NSBaselineOffsetAttributeName:@(0),
                             NSFontAttributeName: [UIFont systemFontOfSize:13]
                             } range:[_goodsPriceLabel.text rangeOfString:[NSString stringWithFormat:@"¥%@",sizeModel.originalPrice]]];
    _goodsPriceLabel.attributedText = attritu;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
