//
//  ImgCollectionViewCell.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "ImgCollectionViewCell.h"

@interface ImgCollectionViewCell ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UIImageView *noImgView;
@property (nonatomic,strong)UIButton *deleteBtn;

@end

@implementation ImgCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.imgView];
    [self.imgView addSubview:self.noImgView];
    [self addSubview:self.deleteBtn];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.noImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgView);
        make.centerX.mas_equalTo(self.imgView);
        make.width.mas_equalTo(CGFloatBasedI375(50));
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(20));
        make.width.mas_equalTo(CGFloatBasedI375(20));
    }];
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (index == 0) {
        _noImgView.hidden = NO;
        _deleteBtn.hidden = YES;
    }else{
        _noImgView.hidden = YES;
        _deleteBtn.hidden = NO;
    }
}
-(void)setImg:(UIImage *)img{
    if (_index == 0) {
        _imgView.image = nil;
    }else{
        _imgView.image = img;
    }
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
}
#pragma mark--deleteBtnClick
-(void)deleteBtnClick:(UIButton *)btn{
    self.deleteBlock(_indexRow);
}

#pragma mark--lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}
-(UIImageView *)noImgView{
    if (!_noImgView) {
        _noImgView = [[UIImageView alloc]init];
        _noImgView.backgroundColor = [UIColor whiteColor];
        _noImgView.image = [UIImage imageNamed:@"sctp"];
    }
    return _noImgView;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = [UIColor clearColor];
        [_deleteBtn setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


@end
