//
//  LLSearchCell.m
//  Winner
//
//  Created by 廖利君 on 2022/3/12.
//

#import "LLSearchCell.h"
//CGFloat heightForCell = CGFloatBasedI375(30);

@implementation LLSearchCell
{
    CGFloat heightForCell ;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        heightForCell = CGFloatBasedI375(30);
//        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = CGFloatBasedI375(15);
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(CGFloatBasedI375(5));
        make.right.bottom.offset(-CGFloatBasedI375(5));

    }];
}
- (void)setKeyword:(NSString *)keyword {
    _keyword = keyword;
    self.nameLabel1.text = _keyword;
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
}

- (CGSize)sizeForCell {
    //宽度加 heightForCell 为了两边圆角。
    return CGSizeMake([self.nameLabel1 sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + heightForCell+20, heightForCell);
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
        _nameLabel1.textAlignment = NSTextAlignmentCenter;
        _nameLabel1.userInteractionEnabled = YES;
//        _nameLabel1.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
//        _nameLabel1.layer.masksToBounds = YES;
//        _nameLabel1.layer.cornerRadius = CGFloatBasedI375(15);
        [self addSubview:self.nameLabel1];
    }
    return _nameLabel1;
}

@end
