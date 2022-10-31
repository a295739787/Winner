//
//  LLShopCarHeadView.m
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import "LLShopCarHeadView.h"
@interface LLShopCarHeadView ()

@end
@implementation LLShopCarHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.mas_centerY);
        make.height.width.offset(CGFloatBasedI375(20));
    }];
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.selectButton.mas_right).offset(CGFloatBasedI375(8));
        make.centerY.equalTo(weakself.selectButton.mas_centerY);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
}

-(UIButton *)selectButton{
    if(!_selectButton){
        _selectButton = [UIButton buttonWithTitle:@"" atBackgroundNormalImageName:@"xz_gray" atBackgroundSelectedImageName:@"xz_red" atTarget:self atAction:nil];
        [_selectButton setEnlargeEdge:30];
        [self addSubview:self.selectButton];
    }
    return _selectButton;
}
-(void)clickSelectBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
     if ([self.delegate respondsToSelector:@selector(selectOrEditGoods:)]) {
         [self.delegate selectOrEditGoods:sender];
     }
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#443415"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"全选";
    }
    return _nameLabel1;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [[UIButton alloc]init];
        [_sureButton setTitle:@"管理" forState:UIControlStateNormal];
        [_sureButton setEnlargeEdge:30];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_sureButton setTitleColor:Black_Color forState:UIControlStateNormal];
        [self addSubview:self.sureButton];
    }
    return _sureButton;
}
@end
