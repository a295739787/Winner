//
//  LLShowView.m
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import "LLShowView.h"
@interface LLShowView ()

@end
@implementation LLShowView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
    }
    return self;
}
-(void)setStyle:(ShowViewState)style{
    _style = style;
    [self setLayout:_style];
   
}
-(void)setLayout:(ShowViewState)style{
    WS(weakself);
    CGFloat withd =  CGFloatBasedI375(60);
    CGFloat heighs = CGFloatBasedI375(60);
    CGFloat x =  CGFloatBasedI375(10);
    CGFloat y =  CGFloatBasedI375(0);
    CGFloat yB = CGFloatBasedI375(0);
    if(style == ShowViewNormalState){
        withd = CGFloatBasedI375(60);
        heighs =CGFloatBasedI375(60);
        yB = -CGFloatBasedI375(10);
    }else if(style == ShowViewNormalImage24State){
        withd = CGFloatBasedI375(24);
        heighs =CGFloatBasedI375(24);
        x = CGFloatBasedI375(2);
        yB = -CGFloatBasedI375(10);
    }else if(style == ShowViewNormalImage40State){
        withd = CGFloatBasedI375(40);
        heighs =CGFloatBasedI375(40);
        x = CGFloatBasedI375(6);
        yB = -CGFloatBasedI375(10);
        y = CGFloatBasedI375(8);
    }
    
    
    [self.showimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(withd);
        make.height.offset(heighs);
        make.centerX.equalTo(weakself.mas_centerX);
        make.top.offset(x);

    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.showimage.mas_bottom).offset(y);
        make.height.offset(CGFloatBasedI375(14));
        make.right.offset(CGFloatBasedI375(-1));
        make.left.offset(CGFloatBasedI375(1));
//        make.bottom.offset(yB);

    }];
}
- (UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        _showimage.userInteractionEnabled =NO;
        [self addSubview:self.showimage];
    }
    return _showimage;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(11)];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.text = @"";
        _titlelable.textColor = [UIColor colorWithHexString:@"#443415"];
        [self addSubview:self.titlelable];
        _titlelable.adjustsFontSizeToFitWidth = YES;
    }
    return _titlelable;
}
@end
