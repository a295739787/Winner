//
//  LLFeedbackInoutTableCell.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "LLFeedbackInoutTableCell.h"
#import "LLTextView.h"
#import "ImgCollectionViewCell.h"

#define MAX_LIMIT_NUMS 200

@interface LLFeedbackInoutTableCell ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong) UILabel *countsLabel;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLFeedbackInoutTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.textView];
    [self.bottomView addSubview:self.countsLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(44));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(56));
    }];
    
    [self.countsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(CGFloatBasedI375(5));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(120), SCREEN_WIDTH, CGFloatBasedI375(70))collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ImgCollectionViewCell class] forCellWithReuseIdentifier:@"ImgCollectionViewCell"];
    [self.bottomView addSubview:self.collectionView];
    
}

-(void)setType:(NSInteger)type{
    
    if (type == 0) {
        self.backgroundColor = [UIColor whiteColor];
        _textView.myPlaceholder = @"请填写您的问题描述";
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
        
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(CGFloatBasedI375(120));
            make.height.mas_equalTo(CGFloatBasedI375(70));
        }];
        
    }else{
        self.backgroundColor = [UIColor clearColor];
        _textView.myPlaceholder = @"请填写您的评价内容";
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(CGFloatBasedI375(10));
            make.right.mas_equalTo(CGFloatBasedI375(-10));
        }];
        
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(CGFloatBasedI375(10));
            make.right.mas_equalTo(CGFloatBasedI375(-10));
            make.top.mas_equalTo(CGFloatBasedI375(120));
            make.height.mas_equalTo(CGFloatBasedI375(70));
        }];
    }
}

-(void)setIndexSection:(NSInteger)indexSection{
    _indexSection = indexSection;
}

-(void)setSelectPhotos:(NSMutableArray *)selectPhotos{
    _selectPhotos = selectPhotos;
    [_dataArray removeAllObjects];
    for (int i = 0; i < selectPhotos.count; i++) {
        [_dataArray addObject:selectPhotos[i]];
    }
    [_collectionView reloadData];
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}

#pragma mark--UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count <= 3) {
        return self.dataArray.count+1;
    }
    return self.dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"ImgCollectionViewCell";
    
    ImgCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.indexRow = indexPath.row;
    if (indexPath.row == self.dataArray.count) {
        cell.index = 0;
        cell.img = nil;
    }else{
        cell.index = 1;
        cell.img = self.dataArray[indexPath.row];
    }
    WS(weakself);
    cell.deleteBlock = ^(NSInteger index) {
        [weakself.dataArray removeObjectAtIndex:index];
//        weakself.deleteImgBlock(index);
        if (weakself.updateImgArrayBlock) {
            weakself.updateImgArrayBlock(index, weakself.indexSection);
        }
        [weakself.collectionView reloadData];
    };
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGFloatBasedI375(70), CGFloatBasedI375(70));
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArray.count) {
        self.openBlock(_indexSection);
    }else{
        
//        HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
//        browser.isFullWidthForLandScape = YES;
//        browser.isNeedLandscape = YES;
//        browser.currentImageIndex = (int)indexPath.row;
//        browser.imageArray = self.dataArray;
//
//        [browser show];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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
        if (self.inputBlock) {
            self.inputBlock(text,_indexSection);
        }
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

    if(self.inputBlock) {
        self.inputBlock(textView.text,_indexSection);
    }
    if(self.delegate){
        self.titles =textView.text;
        NSMutableDictionary *param= [NSMutableDictionary dictionary];
        [param setValue:self.titles forKey:@"title"];
        if(self.images.length > 0){
            [param setValue:self.images forKey:@"image"];
        }
        if(self.start.length > 0){
            [param setValue:self.start forKey:@"start"];
        }
        [self.delegate inputTableViewCell:self index:_index content:param];
        
    }
    self.countsLabel.text = [NSString stringWithFormat:@"%ld/%d",existTextNum,MAX_LIMIT_NUMS];
}

-(void)setIndex:(NSIndexPath *)index{
    _index = index;
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"反馈内容";
    }
    return _titleLabel;
}
-(LLTextView *)textView{
    if (!_textView) {
        _textView = [[LLTextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _textView.myPlaceholder = @"请填写您的问题描述";
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
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
