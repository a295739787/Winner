//
//  FWRBaseTableViewCell.m
//  FindWorker
//
//  Created by libj on 2019/7/27.
//  Copyright © 2019 zhiqiang meng. All rights reserved.
//

#import "FWRBaseTableViewCell.h"

@implementation FWRBaseTableViewCell

#pragma mark - Cell生命周期
/** 0 init 带参数初始化  */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(CGFloatBasedI375(15));
            make.right.offset(CGFloatBasedI375(-15));
            make.height.offset(CGFloatBasedI375(1));
            make.bottom.offset(CGFloatBasedI375(0));
            
        }];
    }
    return self;
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self addSubview:_lineView];
    }
    return _lineView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
