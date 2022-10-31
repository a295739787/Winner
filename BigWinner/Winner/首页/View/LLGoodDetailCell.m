//
//  LLGoodDetailCell.m
//  Winner
//
//  Created by mac on 2022/2/15.
//

#import "LLGoodDetailCell.h"

@implementation LLGoodDetailCell

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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);

    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.width.mas_equalTo(CGFloatBasedI375(40));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.allowimage.mas_left).offset(-CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(.5));
    }];
    
    [self.allowimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(17.5));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
}
-(UIImageView *)allowimage{
    if(!_allowimage){
        _allowimage = [[UIImageView alloc]init];
        [self.contentView addSubview:_allowimage];
        _allowimage.image = [UIImage imageNamed:allowimageGray];
    }
    return _allowimage;
    
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:self.titlelable];
        _titlelable.text = @"规格";
    }
    return _titlelable;
}
-(UILabel *)delable{
    if(!_delable){
        _delable = [[UILabel alloc]init];
        _delable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _delable.textAlignment = NSTextAlignmentLeft;
        _delable.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.delable];
        _delable.text = @"请选择";
    }
    return _delable;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
@implementation LLGoodPicCell

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
        self.backgroundColor = White_Color;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self setLayout];
        self.headImage = [[UIImageView alloc] init];
        self.headImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.headImage];
        self.headImage.contentMode=UIViewContentModeScaleAspectFill;
        self.headImage.clipsToBounds=YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headImage.frame = self.contentView.frame;
}
/** 查看大图 */
- (void)setBigImgViewWithImage:(UIImage *)img{
    if (_BigImgView) {
        //如果大图正在显示，还原小图
        _BigImgView.frame = self.headImage.frame;
        _BigImgView.image = img;
    }else{
        _BigImgView = [[UIImageView alloc] initWithImage:img];
        _BigImgView.frame = self.headImage.frame;
        [self insertSubview:_BigImgView atIndex:0];
    }
    _BigImgView.contentMode = UIViewContentModeScaleToFill;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    [self.headImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.right.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(20));
        make.top.offset(CGFloatBasedI375(0));
    }];
}
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc]init];
        _headImage.userInteractionEnabled = YES;
        _headImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.headImage];
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickSave:)];
        [_headImage addGestureRecognizer:longTap];
    }
    return _headImage;
}
-(void)clickSave:(UILongPressGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateBegan) {
        // 保存图片到相册
        UIImageView *images =(UIImageView *)tap.view;
        UIImageWriteToSavedPhotosAlbum(images.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }else {
    }
    
}
#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo
{
    NSString*message =@"提示";
    if(!error) {
        message =@"成功保存到相册";
        [MBProgressHUD showSuccess:message];
    }
}
@end
