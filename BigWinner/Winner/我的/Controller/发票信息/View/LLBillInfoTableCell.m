//
//  LLBillInfoTableCell.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLBillInfoTableCell.h"

@interface LLBillInfoTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)UIImageView *editImgView;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLBillInfoTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.personalLabel];
    [self.contentView addSubview:self.editImgView];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.editImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.height.mas_equalTo(CGFloatBasedI375(16));
    }];
    
    [self.personalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-40));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.bottom.mas_equalTo(CGFloatBasedI375(-10));
        make.right.mas_equalTo(CGFloatBasedI375(-40));
    }];
    
    self.personalLabel.hidden = YES;
    self.titleLabel.hidden = YES;
    self.numberLabel.hidden = YES;
    
}
-(void)setListModel:(LLBillModel *)listModel{
    
    if ([listModel.headerType intValue] == 1) {
        
        self.numberLabel.hidden = YES;
        self.titleLabel.hidden = YES;
        self.personalLabel.hidden = NO;
        
        _personalLabel.text = listModel.invoiceHeader;
        
    }else{
        self.numberLabel.hidden = NO;
        self.titleLabel.hidden = NO;
        self.personalLabel.hidden = YES;
    
        _titleLabel.text = listModel.invoiceHeader;
        NSString *unitTaxNo = [listModel.unitTaxNo length] <= 0  ? @"000000" : listModel.unitTaxNo;
        _numberLabel.text = unitTaxNo;
        
    }
}

#pragma mark--editBtnClick
-(void)editBtnClick:(UIButton *)btn{
    
}

#pragma mark--
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UILabel *)personalLabel{
    if (!_personalLabel) {
        _personalLabel = [[UILabel alloc]init];
        _personalLabel.textColor = UIColorFromRGB(0x443415);
        _personalLabel.textAlignment = NSTextAlignmentLeft;
        _personalLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _personalLabel;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0x666666);
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _numberLabel.text = @"91440101MA5CPXKA2K";
    }
    return _numberLabel;
}
-(UIImageView *)editImgView{
    if (!_editImgView) {
        _editImgView = [[UIImageView alloc]init];
        _editImgView.backgroundColor = [UIColor whiteColor];
        _editImgView.image = [UIImage imageNamed:@"bjdz"];
    }
    return _editImgView;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

@end




@interface LLBillInfoContentTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLBillInfoContentTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.textField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(100));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(100));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    if (indexRow == 0) {
        _textField.hidden = YES;
        _contentLabel.hidden = NO;
    }else{
        _textField.hidden = NO;
        _contentLabel.hidden = YES;
    }
    
    if (indexRow == 2) {
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
}

#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    
    if (self.editorInvoceBlock) {
        self.editorInvoceBlock(_indexRow, textField.text);
    }
}
-(void)setContentStr:(NSString *)contentStr{
    _textField.text = contentStr;
    
    if (_indexRow == 0) {
        _contentLabel.text = [contentStr intValue] == 1 ? @"增值税电子普通发票" : @"增值税专用发票";
    }
}

#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColorFromRGB(0x443415);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _contentLabel.text = @"增值税电子普通发票";
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end



@interface LLBIllBudinessSpecialTableCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *nextImg;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLBIllBudinessSpecialTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.textField];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.nextImg.mas_left).offset(CGFloatBasedI375(-10));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(CGFloatBasedI375(100));
    }];
    
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    if (indexRow == 0 || indexRow == 7) {
        _textField.hidden = YES;
        _contentLabel.hidden = NO;
        _nextImg.hidden = NO;

        if (indexRow == 7) {
            _contentLabel.text = @"请选择发票收件地址";
            _contentLabel.textColor = UIColorFromRGB(0x999999);
        }else{
            _contentLabel.text = @"增值税专用发票";
            _contentLabel.textColor = UIColorFromRGB(0x443415);
        }

    }else{
        _textField.hidden = NO;
        _contentLabel.hidden = YES;
        _nextImg.hidden = YES;
    }
    
    if (indexRow == 5 || indexRow == 6) {
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
}
-(void)setTypeStr:(NSString *)typeStr{
    _textField.text = typeStr;
    
    if (_indexRow == 0) {
        _contentLabel.text = [typeStr intValue] == 1 ? @"增值税电子普通发票" : @"增值税专用发票";
    }
}

#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    if (self.editorInvoceBlock) {
        self.editorInvoceBlock(_indexRow, textField.text);
    }
}
#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColorFromRGB(0x443415);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _contentLabel;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
}


@end




@interface LLBillDetailTableViewCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *nextImg;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLBillDetailTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.nextImg];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.textField];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.nextImg.mas_left).offset(CGFloatBasedI375(-10));
        make.left.mas_equalTo(CGFloatBasedI375(100));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(100));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
}
-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    if (indexRow == 6) {
        _textField.hidden = YES;
        _contentLabel.hidden = NO;
        _nextImg.hidden = NO;

        if (indexRow == 6) {
            _contentLabel.text = @"请选择发票收件地址";
            _contentLabel.textColor = UIColorFromRGB(0x999999);
        }

    }else{
        _textField.hidden = NO;
        _contentLabel.hidden = YES;
        _nextImg.hidden = YES;
    }
    
    if (indexRow == 5 || indexRow == 6) {
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
}
-(void)setTypeStr:(NSString *)typeStr{
    _textField.text = typeStr;
    if (_indexRow == 6) {
        _contentLabel.textColor = UIColorFromRGB(0x443415);
        _contentLabel.text = typeStr;
    }
}

#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    if (self.editorInvoceBlock) {
        self.editorInvoceBlock(_indexRow, textField.text);
    }
}
#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _titleLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColorFromRGB(0x443415);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
}


@end

