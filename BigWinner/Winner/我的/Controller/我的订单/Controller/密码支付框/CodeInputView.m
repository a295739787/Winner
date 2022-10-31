//
//  CodeInputView.m
//  LoadingView
//
//  Created by coolerting on 2018/8/8.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import "CodeInputView.h"

@interface CodeCollectionViewCell()
@property(nonatomic,strong) UILabel *codeLabel;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) UIView *securityPoint;
@property(nonatomic,strong) CABasicAnimation *animation;
@end

@implementation CodeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *codeLabel = [[UILabel alloc]initWithFrame:self.contentView.bounds];
        codeLabel.textColor = UIColor.blackColor;
        codeLabel.textAlignment = NSTextAlignmentCenter;
        codeLabel.adjustsFontSizeToFitWidth = YES;
        codeLabel.layer.backgroundColor = UIColor.whiteColor.CGColor;
        codeLabel.layer.cornerRadius = frame.size.width / 10;
        codeLabel.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        codeLabel.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [self.contentView addSubview:codeLabel];
        _codeLabel = codeLabel;
        
        UIView *securityPoint = [[UIView alloc]init];
        securityPoint.layer.backgroundColor = UIColor.darkGrayColor.CGColor;
        securityPoint.layer.cornerRadius = frame.size.width / 6;
        [self.contentView addSubview:securityPoint];
        _securityPoint = securityPoint;
        [securityPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.height.width.mas_equalTo(frame.size.width / 3);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        lineView.layer.cornerRadius = 2 / [UIScreen mainScreen].scale;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.height.mas_equalTo(frame.size.height * 2 / 4);
            make.width.mas_equalTo(4 / [UIScreen mainScreen].scale);
        }];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.duration = 0.5;
        animation.fromValue = @0;
        animation.toValue = @1;
        animation.repeatCount = MAXFLOAT;
        animation.autoreverses = YES;
        _animation = animation;
    }
    return self;
}

- (void)setModel:(CodeModel *)model
{
    _model = model;
    if (_type == cellTypeNormal) {
        _codeLabel.text = model.number;
        _securityPoint.hidden = YES;
    }
    else
    {
        if (![model.number isEqualToString:@""]) {
            _securityPoint.hidden = NO;
        }
        else
        {
            _securityPoint.hidden = YES;
        }
    }
    
    if (model.isSelected) {
        _lineView.hidden = NO;
        [_lineView.layer addAnimation:_animation forKey:@"animation"];
    }
    else
    {
        _lineView.hidden = YES;
        [_lineView.layer removeAllAnimations];
    }
}
@end

@implementation CodeModel

@end

@interface CodeInputView()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) NSMutableArray *codeArray;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) CGFloat count;
@property(nonatomic,assign) NSInteger space;
@property(nonatomic,assign) CGFloat margin;
@end

@implementation CodeInputView

- (instancetype)initWithFrame:(CGRect)frame Space:(CGFloat)space Margin:(CGFloat)margin Count:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {

        CGFloat height = (frame.size.width - margin * (count - 1) - 2 * space) / count;
        if (frame.size.height < height + margin * 2) {
            height = frame.size.height - margin * 2;
            space = (frame.size.width - height * count - margin * (count - 1)) / 2;
        }
        
        _count = count;
        _margin = margin;
        _space = space;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height + 2 * margin);
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(height, height);
        layout.sectionInset = UIEdgeInsetsMake(margin, space, margin, space);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = margin;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.whiteColor;
        [collectionView registerClass:[CodeCollectionViewCell class] forCellWithReuseIdentifier:@"codeCell"];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
        textField.delegate = self;
        [self addSubview:textField];
        _textField = textField;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        _codeArray = [NSMutableArray array];
        for (int i = 0; i < count; i ++) {
            CodeModel *model = [CodeModel new];
            model.number = @"";
            model.isSelected = NO;
            [_codeArray addObject:model];
        }
    }
    return self;
}

- (void)keyboardWillBeHiden:(NSNotification *)noti
{
    for (CodeModel *model in _codeArray) {
        model.isSelected = NO;
    }
    [_collectionView reloadData];
}

- (void)valueChanged:(UITextField *)textField
{
    if (textField.text.length != 0) {
        NSString *lastCharacter = [textField.text substringWithRange:NSMakeRange(textField.text.length - 1, 1)];
        BOOL isNumber = [self isPureInt:lastCharacter];
        if (!isNumber) {
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
            return;
        }
    }
    
    if (textField.text.length <= _count) {
        for (CodeModel *subModel in _codeArray) {
            subModel.number = @"";
            subModel.isSelected = NO;
        }
        for (int i = 0; i < textField.text.length; i++) {
            CodeModel *model = _codeArray[i];
            model.number = [textField.text substringWithRange:NSMakeRange(i, 1)];
            model.isSelected = NO;
        }
        [self reloadData];
    }
    else
    {
        textField.text = [textField.text substringToIndex:_count];
    }
    
    _numberText = textField.text;
    
    if (_numberText.length >= _count) {
        [self resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(finishEnterCode:code:)]) {
            [_delegate finishEnterCode:self code:_numberText];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(codeDuringEnter:code:)]) {
            [_delegate codeDuringEnter:self code:_numberText];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(beginEnterCode:)]) {
        [_delegate beginEnterCode:self];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _codeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"codeCell" forIndexPath:indexPath];
    switch (_inputType) {
        case inputTypeNormal:
            cell.type = cellTypeNormal;
            break;
        case inputTypeSecurity:
            cell.type = cellTypeSecurity;
        default:
            break;
    }
    cell.model = _codeArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_textField becomeFirstResponder];
    [self reloadData];
}

- (void)reloadData
{
    for (CodeModel *model in _codeArray) {
        if ([model.number isEqualToString:@""]) {
            model.isSelected = YES;
            break;
        }
    }
    [_collectionView reloadData];
}

- (BOOL)resignFirstResponder
{
    
    if (_numberText.length < _count) {
        return NO;
    }
    [_textField resignFirstResponder];
    return YES;
}
-(void)setIsFirst:(BOOL)isFirst{
    _isFirst = isFirst;
    if (_isFirst == YES) {
        [_textField becomeFirstResponder];
    }else{
        [_textField resignFirstResponder];
    }
}

- (BOOL)isPureInt:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
@end
