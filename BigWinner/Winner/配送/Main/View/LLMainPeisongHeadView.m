//
//  LLMainPeisongHeadView.m
//  Winner
//
//  Created by 廖利君 on 2022/3/4.
//

#import "LLMainPeisongHeadView.h"

@implementation LLMainPeisongHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(11));
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(-CGFloatBasedI375(0));
    }];
    [self.namelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(-CGFloatBasedI375(0));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(6));
 
    }];
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.textColor = [UIColor colorWithHexString:@"#666666"];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}
-(UILabel *)namelable{
    if(!_namelable){
        _namelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#666666"] textAlignment:NSTextAlignmentCenter numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@""];
        [self addSubview:self.namelable];
    }
    return _namelable;
}
@end
