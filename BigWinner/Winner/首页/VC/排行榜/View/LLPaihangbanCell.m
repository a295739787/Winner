//
//  LLPaihangbanCell.m
//  Winner
//
//  Created by 廖利君 on 2022/3/14.
//

#import "LLPaihangbanCell.h"
@interface LLPaihangbanCell ()
@property (nonatomic,strong) UILabel *titlelable ;/** <#class#> **/
@property (nonatomic,strong) UILabel *detailsLabel ;/** class **/
@property (nonatomic,strong) UIImageView *showimage;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showBackimage;/** <#class#> **/

@end
@implementation LLPaihangbanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.width.height.offset(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.showBackimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.label.mas_right).offset(CGFloatBasedI375(9));
        make.width.offset(CGFloatBasedI375(42));
        make.height.offset(CGFloatBasedI375(36));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.showimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.showBackimage.mas_centerX);
        make.width.offset(CGFloatBasedI375(30));
        make.height.offset(CGFloatBasedI375(30));
        make.centerY.equalTo(weakself.showBackimage.mas_centerY);
    }];
    [self.titlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showBackimage.mas_right).offset(CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.contentView.mas_centerY);

    }];
    [self.detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    
    _showimage.layer.masksToBounds = YES;
    _showimage.layer.cornerRadius = CGFloatBasedI375(10);
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    self.titlelable.text = _model.nickName;
    self.detailsLabel.text = FORMAT(@"%@点",_model.spotNum);
    [self.showimage  sd_setImageWithUrlString:FORMAT(@"%@",_model.headIcon) placeholderImage:[UIImage imageNamed:@"headimages"]];

}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
        _titlelable.text = @"吴*雷";
    }
    return _titlelable;
}
-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _detailsLabel.textColor =Main_Color;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.detailsLabel];
        _detailsLabel.text = @"204555点";
    }
    return _detailsLabel;
}
-(UIImageView *)showBackimage{
    if (!_showBackimage) {
        _showBackimage = [[UIImageView alloc]init];
        _showBackimage.userInteractionEnabled = YES;
        _showBackimage.image =[UIImage imageNamed:@"photo_bg1"];
        [self.contentView addSubview:self.showBackimage];
    }
    return _showBackimage;
}
-(UIImageView *)showimage{
    if (!_showimage) {
        _showimage = [[UIImageView alloc]init];
        _showimage.userInteractionEnabled = YES;
        _showimage.image =[UIImage imageNamed:allowimageGray];
        [self.showBackimage addSubview:self.showimage];
    }
    return _showimage;
}

-(UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc]init];
        _label.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _label.textColor =BlackTitleFont443415;
        _label.userInteractionEnabled = YES;
        _label.adjustsFontSizeToFitWidth = YES;
        _label.layer.masksToBounds = YES;
        _label.layer.cornerRadius = CGFloatBasedI375(10);
        _label.layer.borderColor=[[UIColor colorWithHexString:@"#443415"]CGColor];
        _label.layer.borderWidth = 0.5f;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        _label.text = @"1";
    }
    return _label;
}
@end
@interface LLPaihangbanHeadView ()
@property (nonatomic,strong) UILabel *titlelable ;/** <#class#> **/
@property (nonatomic,strong) UILabel *detailsLabel ;/** class **/
@property (nonatomic,strong) UIImageView *showimage;/** <#class#> **/
@property (nonatomic,strong) UIView *backView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showBackimage;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showlitterimage;/** <#class#> **/

@end
@implementation LLPaihangbanHeadView


#pragma mark ============= 头部 =============

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
 
    [self.showBackimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(CGFloatBasedI375(0));

    }];
    [self.showimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.width.offset(CGFloatBasedI375(7));
        make.height.offset(CGFloatBasedI375(8));
        make.centerY.equalTo(weakself.showBackimage.mas_centerY);
    }];
    [self.titlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showimage.mas_right).offset(CGFloatBasedI375(3));
        make.centerY.equalTo(weakself.showimage.mas_centerY);

    }];
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.showBackimage.mas_centerX);
        make.width.offset(CGFloatBasedI375(100));
        make.height.offset(CGFloatBasedI375(40));
        make.centerY.equalTo(weakself.showBackimage.mas_centerY);
    }];
    [self.showlitterimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.width.offset(CGFloatBasedI375(18));
        make.height.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
    [self.detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showlitterimage.mas_right).offset(CGFloatBasedI375(3));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = Main_Color;
        _titlelable.text = @"top100";
        [self.showBackimage addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
    }
    return _titlelable;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =BlackTitleFont443415;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview:self.detailsLabel];
        _detailsLabel.text = @"实时排行";

    }
    return _detailsLabel;
}
-(UIImageView *)showlitterimage{
    if (!_showlitterimage) {
        _showlitterimage = [[UIImageView alloc]init];
        _showlitterimage.userInteractionEnabled = YES;
        _showlitterimage.image =[UIImage imageNamed:@"icon_phb"];
        [self.backView addSubview:self.showlitterimage];
    }
    return _showlitterimage;
}
-(UIImageView *)showBackimage{
    if (!_showBackimage) {
        _showBackimage = [[UIImageView alloc]init];
        _showBackimage.userInteractionEnabled = YES;
        _showBackimage.image =[UIImage imageNamed:@"ssph_bg"];
        [self addSubview:self.showBackimage];
    }
    return _showBackimage;
}
-(UIImageView *)showimage{
    if (!_showimage) {
        _showimage = [[UIImageView alloc]init];
        _showimage.userInteractionEnabled = YES;
        _showimage.image =[UIImage imageNamed:@"hot"];
        [self.showBackimage addSubview:self.showimage];
    }
    return _showimage;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        [self.showBackimage addSubview:_backView];
    }
    return _backView;;
}
@end
