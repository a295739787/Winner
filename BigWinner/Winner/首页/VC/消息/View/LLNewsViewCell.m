//
//  LLNewsViewCell.m
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import "LLNewsViewCell.h"
@interface LLNewsViewCell ()
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *delable;
@property(nonatomic,strong)UILabel *timelable;
@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIImageView *allowImage;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property(nonatomic,strong)UIView *redView;

@end

@implementation LLNewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(CGFloatBasedI375(10));
        make.bottom.right.mas_equalTo(-CGFloatBasedI375(10));
    }];
//    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(CGFloatBasedI375(14));
//        make.width.offset(CGFloatBasedI375(8));
//        make.height.offset(CGFloatBasedI375(8));
//        make.top.offset(CGFloatBasedI375(20));
//    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.redView.mas_right).offset(CGFloatBasedI375(6));
        make.right.offset(-CGFloatBasedI375(14));
//        make.centerY.equalTo(weakself.redView.mas_centerY);
        make.top.offset(CGFloatBasedI375(20));
        make.left.offset(CGFloatBasedI375(14));
    }];

    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(14));
        make.right.offset(-CGFloatBasedI375(14));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(15));
    }];
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(14));
        make.bottom.offset(-CGFloatBasedI375(10));
    }];
    [self.allowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.width.offset(CGFloatBasedI375(5.5));
        make.height.offset(CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
    }];
}

-(void)setListModel:(LLNewsListModel *)listModel{
    _listModel = listModel;
    if (!_listModel.isRead) {
        _allowImage.hidden = YES;
//        self.redView.hidden = YES;
//        [self.titlelable mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(CGFloatBasedI375(14));
//        }];
        if ([_listModel.type intValue] == 1) {
            _titlelable.attributedText = [self getAttribuStrWithStrings:@[@"ꔷ",@"系统消息"] colors:@[Main_Color,[UIColor colorWithHexString:@"#443415"]]];
//            _titlelable.text = @"系统消息";
        }else if ([_listModel.type intValue] == 2){
            //订单消息
//            _titlelable.text = @"订单消息";
            _titlelable.attributedText = [self getAttribuStrWithStrings:@[@"ꔷ",@"订单消息"] colors:@[Main_Color,[UIColor colorWithHexString:@"#443415"]]];

        }else{
            //配送消息
//            _titlelable.text = @"配送消息";
            _titlelable.attributedText = [self getAttribuStrWithStrings:@[@"ꔷ",@"配送消息"] colors:@[Main_Color,[UIColor colorWithHexString:@"#443415"]]];

        }
    }else{
        _allowImage.hidden = NO;
        if ([_listModel.type intValue] == 1) {
            _titlelable.attributedText = [self getAttribuStrWithStrings:@[@"",@"系统消息"] colors:@[Main_Color,[UIColor colorWithHexString:@"#443415"]]];
//            _titlelable.text = @"系统消息";
        }else if ([_listModel.type intValue] == 2){
            //订单消息
//            _titlelable.text = @"订单消息";
            _titlelable.attributedText = [self getAttribuStrWithStrings:@[@"",@"订单消息"] colors:@[Main_Color,[UIColor colorWithHexString:@"#443415"]]];

        }else{
            //配送消息
//            _titlelable.text = @"配送消息";
            _titlelable.attributedText = [self getAttribuStrWithStrings:@[@"",@"配送消息"] colors:@[Main_Color,[UIColor colorWithHexString:@"#443415"]]];

        }
//        self.redView.hidden = NO;
//        WS(weakself);
//        [self.titlelable mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakself.redView.mas_right).offset(CGFloatBasedI375(6));
//        }];

    }
    
 
    
    _delable.text = listModel.content;
    _timelable.text = listModel.createTime;
    
}


-(UIImageView *)allowImage{
    if (!_allowImage) {
        _allowImage = [[UIImageView alloc]init];
        _allowImage.userInteractionEnabled = YES;
        _allowImage.image =[UIImage imageNamed:@"more_gray"];
        [self.backView addSubview:self.allowImage];
    }
    return _allowImage;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"订单配送通知";
        _titlelable.textColor = [UIColor colorWithHexString:@"#443415"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        [self.backView addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}

-(UILabel *)delable{
    if(!_delable){
        _delable =[[UILabel alloc]init];
        _delable.text = @"您的订单号：202112021101已送出，预计今天18:53分送达；";
        _delable.textColor = [UIColor colorWithHexString:@"#666666"];
        _delable.textAlignment = NSTextAlignmentLeft;
        _delable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self.backView addSubview:self.delable];
        _delable.numberOfLines = 2;
    }
    return _delable;
}

-(UILabel *)timelable{
    if(!_timelable){
        _timelable =[[UILabel alloc]init];
        _timelable.text = @"2021-12-20 15:01:05";
        _timelable.textColor = [UIColor colorWithHexString:@"#999999"];
        _timelable.textAlignment = NSTextAlignmentLeft;
        _timelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.backView addSubview:self.timelable];
    }
    return _timelable;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatBasedI375(5);
    }
    return _backView;
}


- (UIView *)redView{
    if(!_redView){
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = [UIColor redColor];
        [self.backView addSubview:_redView];
        _redView.layer.masksToBounds = YES;
        _redView.layer.cornerRadius = CGFloatBasedI375(4);
    }
    return _redView;
}
@end
