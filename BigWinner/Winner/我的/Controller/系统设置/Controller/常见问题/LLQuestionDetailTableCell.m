//
//  LLQuestionDetailTableCell.m
//  Winner
//
//  Created by YP on 2022/2/19.
//

#import "LLQuestionDetailTableCell.h"

@interface LLQuestionDetailTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;

@end

@implementation LLQuestionDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    WS(weakself);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(44));
        make.top.mas_equalTo(CGFloatBasedI375(5));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(CGFloatBasedI375(5));
    }];
    
}
-(void)setListModel:(QuestionModel *)listModel{
    
    _titleLabel.text = listModel.title;
    _contentLabel.text = listModel.content;
}

#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _titleLabel.numberOfLines=0;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColorFromRGB(0x666666);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _contentLabel.numberOfLines=0;
    }
    return _contentLabel;
}

@end
