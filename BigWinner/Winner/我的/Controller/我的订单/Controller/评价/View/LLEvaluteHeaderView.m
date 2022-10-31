//
//  LLEvaluteHeaderView.m
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import "LLEvaluteHeaderView.h"
#import "LLTextView.h"
#define MAX_LIMIT_NUMS 200
@interface LLEvaluteHeaderView ()<UITextViewDelegate>

@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UILabel *goodsCountLabel;
@property (nonatomic,strong)UILabel *goodsPriceLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UILabel *evaluatelabel;
@property (nonatomic,strong)UIView *staView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)LLTextView *textView;
@property (nonatomic,strong) UILabel *countsLabel;
@end

@implementation LLEvaluteHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =[UIColor clearColor];
        self.start = @"5";
        [self createUI];
    }
    return self;
}
#define picBtnHeight (SCREEN_WIDTH-CGFloatBasedI375(80))/4
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.bottomView];
    
    
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsSpecLabel];
    [self.bottomView addSubview:self.goodsCountLabel];
    [self.bottomView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.goodsPriceLabel];
    [self.bottomView addSubview:self.line];
    [self.bottomView addSubview:self.evaluatelabel];
    [self.bottomView addSubview:self.staView];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.textView];
    [self.bottomView addSubview:self.countsLabel];
    [self.bottomView addSubview:self.picBtnView];
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(18));
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.right.mas_equalTo(CGFloatBasedI375(-40));
    }];
    [self.goodsSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(105));
    }];
//    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(CGFloatBasedI375(105));
//        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
//    }];
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(105));
    }];
    
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-13));
        make.centerY.mas_equalTo(self.goodsPriceLabel);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(109));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.evaluatelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(110));
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.staView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImgView.mas_bottom).offset(CGFloatBasedI375(20));
        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(CGFloatBasedI375(25+ 10) * 5);
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [starBtn setImage:[UIImage imageNamed:@"xing_red"] forState:UIControlStateNormal];
        starBtn.frame = CGRectMake(CGFloatBasedI375(25 + 10) * i, CGFloatBasedI375(12), CGFloatBasedI375(25), CGFloatBasedI375(25));
        starBtn.backgroundColor = [UIColor whiteColor];
        starBtn.tag = 100 + i;
        [starBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.staView addSubview:starBtn];
    }
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.staView.mas_bottom).offset(CGFloatBasedI375(20));

    }];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(56));
    }];
    
    [self.countsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(CGFloatBasedI375(5));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    [self.picBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(picBtnHeight);
        make.top.equalTo(self.textView.mas_bottom).offset(CGFloatBasedI375(8));
    }];
    [self.picBtnView addSubview:self.picView];
    
}
-(void)setFamodel:(LLMeOrderDetailModel *)famodel{
    _famodel  =famodel;
}
-(void)setModel:(LLappOrderListGoodsVos *)model{
    _model = model;
    
    [self.goodsImgView  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.goodsSpecLabel.text = FORMAT(@"%@",_model.specsValName);
    self.goodsNameLabel.text = _model.name;
    self.goodsPriceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    self.goodsCountLabel.text  = FORMAT(@"x%@",_model.goodsNum);
    if(_famodel.orderType.integerValue == 2){//惊喜红包  库存提货
        self.goodsPriceLabel.text = @"库存提货";
        self.goodsPriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
//    self.nameLabel1.text =_model.goods_name;
//
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.image) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    self.detailsLabel.text = FORMAT(@"%@",_model.goods_sku_name);
//    self.priceLabel.text =FORMAT(@"¥ %.2f ",_model.goods_amount.floatValue );
//    self.countNumsLabel.text =FORMAT(@"x %@ ",_model.num);
}
#pragma mark--starBtnClick
-(void)starBtnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    
    for (int i = 0; i < 5; i++) {
        UIButton *starBtn = [self.staView viewWithTag:100 + i];
        if (i <= index) {
            [starBtn setImage:[UIImage imageNamed:@"xing_red"] forState:UIControlStateNormal];
        }else{
            [starBtn setImage:[UIImage imageNamed:@"xing_gray"] forState:UIControlStateNormal];
        }
    }
    WS(weakself);
    weakself.start = FORMAT(@"%ld",index+1);
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputTableViewCell:index:content:)]){
        NSMutableDictionary *param= [NSMutableDictionary dictionary];
        [param setValue:weakself.titles forKey:@"title"];
        if(weakself.images.count > 0){
            [param setValue:weakself.images forKey:@"image"];
        }
        if(weakself.start.length > 0){
            [param setValue:weakself.start forKey:@"start"];
        }
        [param setValue:_model.goodsId forKey:@"goodsId"];
        [weakself.delegate inputTableViewCell:weakself index:weakself.index content:param];
        
    }
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), CGFloatBasedI375(10), SCREEN_WIDTH - CGFloatBasedI375(20),  CGFloatBasedI375(193+50+110))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}

#pragma mark--lazy
-(UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc]init];
        _goodsImgView.backgroundColor = [UIColor redColor];
    }
    return _goodsImgView;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        _goodsNameLabel.textColor = UIColorFromRGB(0x443415);
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _goodsNameLabel.text = @"大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒";
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}
-(UILabel *)goodsSpecLabel{
    if (!_goodsSpecLabel) {
        _goodsSpecLabel = [[UILabel alloc]init];
        _goodsSpecLabel.textColor = UIColorFromRGB(0x999999);
        _goodsSpecLabel.textAlignment = NSTextAlignmentLeft;
        _goodsSpecLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsSpecLabel.text = @"1支装(500ML)";
    }
    return _goodsSpecLabel;
}
-(UILabel *)goodsCountLabel{
    if (!_goodsCountLabel) {
        _goodsCountLabel = [[UILabel alloc]init];
        _goodsCountLabel.textColor = UIColorFromRGB(0x999999);
        _goodsCountLabel.textAlignment = NSTextAlignmentRight;
        _goodsCountLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsCountLabel.text = @"X1";
    }
    return _goodsCountLabel;
}
- (UIView *)picBtnView{
    if(!_picBtnView){
        _picBtnView = [[UIView alloc]init];
  
    }
    return _picBtnView;
}
-(UILabel *)goodsPriceLabel{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc]init];
        _goodsPriceLabel.textColor = UIColorFromRGB(0x443415);
        _goodsPriceLabel.textAlignment = NSTextAlignmentCenter;
        _goodsPriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _goodsPriceLabel.text = @"149.00";
    }
    return _goodsPriceLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x443415);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"¥";
    }
    return _noteLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

-(UILabel *)evaluatelabel{
    if (!_evaluatelabel) {
        _evaluatelabel = [[UILabel alloc]init];
        _evaluatelabel.textColor = UIColorFromRGB(0x443415);
        _evaluatelabel.textAlignment = NSTextAlignmentLeft;
        _evaluatelabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _evaluatelabel.text = @"商品评价";
    }
    return _evaluatelabel;
}
-(UIView *)staView{
    if (!_staView) {
        _staView = [[UIView alloc]init];
        _staView.backgroundColor = [UIColor whiteColor];
    }
    return _staView;
}

- (LLReturnPicView *)picView{
    if(!_picView){
        _picView = [[LLReturnPicView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-CGFloatBasedI375(50), CGFloatBasedI375(65))];
        WS(weakself);
        _picView.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(inputTableViewCell:index:content:)]){
                NSMutableDictionary *param= [NSMutableDictionary dictionary];
                weakself.images = image;
                [param setValue:weakself.titles forKey:@"title"];
                if(image.count > 0){
                    [param setValue:image forKey:@"image"];
                }
                if(weakself.start.length > 0){
                    [param setValue:weakself.start forKey:@"start"];
                }
                [param setValue:weakself.model.goodsId forKey:@"goodsId"];
                [weakself.delegate inputTableViewCell:weakself index:weakself.index content:param];
                
            }
            if((image.count > 4 &&  image.count < 8) || image.count ==4 ){
                weakself.picView.height = picBtnHeight+picBtnHeight+10;
                [weakself.picBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.offset(picBtnHeight+picBtnHeight+10);
                }];
                weakself.bottomView.height = picBtnHeight+CGFloatBasedI375(30)+CGFloatBasedI375(193+50+110);
            }else if(image.count >= 8){
                weakself.picView.height = picBtnHeight+picBtnHeight+picBtnHeight+30;
                [weakself.picBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.offset(picBtnHeight+picBtnHeight+picBtnHeight+30);
                }];
                weakself.bottomView.height = picBtnHeight*3+CGFloatBasedI375(30)+CGFloatBasedI375(193+50+110);
            }else{
                weakself.picView.height = picBtnHeight;
                [weakself.picBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.offset(picBtnHeight);
                }];
                weakself.bottomView.height = CGFloatBasedI375(193+50+110);
            }
            UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:weakself.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

           CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
           cornerRadiusLayer.frame = weakself.bottomView.bounds;
            cornerRadiusLayer.path = cornerRadiusPath.CGPath;
            weakself.bottomView.layer.mask = cornerRadiusLayer;
        };
    }
    return _picView;
}

#pragma mark -限制描述输入字数(最多不超过200个字)
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //不支持系统表情的输入
    if ([[textView textInputMode] primaryLanguage]==nil||[[[textView textInputMode] primaryLanguage]isEqualToString:@"emoji"]) {
        return NO;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange =NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < MAX_LIMIT_NUMS) {
//            self.contentBlock(text);
            return YES;
        }else{
            return NO;
        }
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen =MAX_LIMIT_NUMS - comcatstr.length;
    if (caninputlen >=0){
//        if (self.inputBlock) {
//            self.inputBlock(text,_indexSection);
//        }
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length >0){
            NSString *s =@"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }else{
                __block NSInteger idx =0;
                __block NSString  *trimString =@"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
                                          if (idx >= rg.length) {
                                              *stop =YES;//取出所需要就break，提高效率
                                              return ;
                                          }
                                          trimString = [trimString stringByAppendingString:substring];
                                          idx++;
                                      }];
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
//            self.contentBlock(text);
            self.countsLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }
        
        self.countsLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        
        return NO;
    }
}
#pragma mark -显示当前可输入字数/总字数
- (void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >MAX_LIMIT_NUMS){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        [textView setText:s];
    }
    //不让显示负数

  
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputTableViewCell:index:content:)]){
        self.titles =textView.text;
        NSMutableDictionary *param= [NSMutableDictionary dictionary];
        [param setValue:self.titles forKey:@"title"];
        if(self.images.count > 0){
            [param setValue:self.images forKey:@"image"];
        }
        if(self.start.length > 0){
            [param setValue:self.start forKey:@"start"];
        }
        [param setValue:_model.goodsId forKey:@"goodsId"];
        [self.delegate inputTableViewCell:self index:_index content:param];
        
    }
    self.countsLabel.text = [NSString stringWithFormat:@"%ld/%d",existTextNum,MAX_LIMIT_NUMS];
}

-(void)setIndex:(NSIndexPath *)index{
    _index = index;
}

#pragma mark--lazy

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titleLabel.text = @"评价内容";
    }
    return _titleLabel;
}
-(LLTextView *)textView{
    if (!_textView) {
        _textView = [[LLTextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _textView.myPlaceholder = @"请填写您的评价内容";
        _textView.myPlaceholderColor = UIColorFromRGB(0x999999);
    }
    return _textView;
}
-(UILabel *)countsLabel{
    if(!_countsLabel){
        _countsLabel =[[UILabel alloc]init];
        _countsLabel.text = @"0/200";
        _countsLabel.textColor = UIColorFromRGB(0xCCCCCC );
        _countsLabel.textAlignment = NSTextAlignmentRight;
        _countsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _countsLabel;
}
@end
