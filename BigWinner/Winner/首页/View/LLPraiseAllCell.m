//
//  LLPraiseAllCell.m
//  JuMei
//
//  Created by lijun L on 2019/12/17.
//  Copyright © 2019 lijun L. All rights reserved.
//
#define  widths (SCREEN_WIDTH-CGFloatBasedI375(60))/4
//#define  widths CGFloatBasedI375(80)
#import "LLPraiseAllCell.h"
#import "JJPhotoManeger.h"
#import "LEEStarRating.h"
@interface LLPraiseAllCell ()<UICollectionViewDelegate,UICollectionViewDataSource,JJPhotoDelegate>
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *timelable;
@property(nonatomic,strong)UILabel *sourcelable;
@property(nonatomic,strong)UILabel *delabel;
@property (nonatomic,strong) UIImageView *showimage;/** <#class#> **/
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout * collectionLayout;
@property(nonatomic,strong)UIView *backView;
@property (nonatomic,strong) LEEStarRating *starRateView;/** <#class#> **/

@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@end
@implementation LLPraiseAllCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    self.delabel.text = _model.content;
    _starRateView.currentScore = _model.star.floatValue;;
    self.timelable.text = _model.createTime;
    self.titlelable.text =_model.nickName.length<=0?@"无":_model.nickName;
    [self.showimage sd_setImageWithUrlString:FORMAT(@"%@",_model.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    NSString *images =  _model.images;

    if(images.length > 0){
        NSArray *da  = [images componentsSeparatedByString:@","];
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:da];
        self.collectionView.hidden = NO;
    }else{
        self.collectionView.hidden = YES;
    }
    [self.collectionView reloadData];
    [self setLayout];
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    
    [self.showimage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(40));
        make.width.offset(CGFloatBasedI375(40));
        make.top.offset(CGFloatBasedI375(10));
    }];
    [self.titlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.showimage.mas_top).mas_equalTo(CGFloatBasedI375(5));
//        make.height.offset(CGFloatBasedI375(20));
         make.left.equalTo(weakself.showimage.mas_right).mas_equalTo(CGFloatBasedI375(10));
     }];
    [self.starRateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titlelable.mas_right).offset(CGFloatBasedI375(10));
        make.top.equalTo(weakself.showimage.mas_top).offset(CGFloatBasedI375(5));
        make.width.offset(CGFloatBasedI375(150));
        make.height.offset(CGFloatBasedI375(19));
    }];
    [self.timelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showimage.mas_right).mas_equalTo(CGFloatBasedI375(10));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(5));
         }];
//    NSString *content = _model.comment_content.content;
    [self.delabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
         make.right.mas_equalTo(CGFloatBasedI375(-15));
//            make.height.mas_equalTo(_model.contentHeight);
//        make.height.mas_equalTo(40);
         make.top.equalTo(weakself.showimage.mas_bottom).offset(CGFloatBasedI375(12));
     }];

    NSString *images =  _model.images;

    if(images.length > 0){
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(CGFloatBasedI375(15));
             make.right.mas_equalTo(CGFloatBasedI375(-15));
//            make.height.mas_equalTo(_model.imageHeight);
            make.bottom.offset(-CGFloatBasedI375(10));

             make.top.equalTo(weakself.delabel.mas_bottom).offset(CGFloatBasedI375(10));
         }];
    
    }else{
        
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
         make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.offset(CGFloatBasedI375(0));
         make.top.equalTo(weakself.delabel.mas_bottom).offset(CGFloatBasedI375(10));
     }];
   
    }
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.right.offset(CGFloatBasedI375(-15));
        make.height.offset(CGFloatBasedI375(1));
        make.bottom.offset(CGFloatBasedI375(0));

                make.left.equalTo(weakself.titlelable.mas_left).mas_equalTo(CGFloatBasedI375(0));
           }];
}
static NSString *const LLPraisePicCellid = @"LLPraisePicCellid";


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLPraisePicCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLPraisePicCellid forIndexPath:indexPath];
    cell.imagestr =self.dataArr[indexPath.row];
    //添加图片cell点击事件
    cell.showimage.tag  =indexPath.row;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    [cell.showimage  addGestureRecognizer:singleTap];
    return cell;
    
}
- (void) tapProfileImage:(UIGestureRecognizer *)gestureRecognizer{
    [self endEditing:YES];
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    //点击放大查看
           LLPraisePicCell *cell = (LLPraisePicCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    NSString *problemImages;
    if([self.dataArr[index]  containsString:@"http"]){
        problemImages =[NSString stringWithFormat:@"%@",self.dataArr[index] ];
    }else{
        problemImages =[NSString stringWithFormat:@"%@%@",API_IMAGEHOST,self.dataArr[index] ];
    }
           if (!cell.BigImgView || !cell.BigImgView.image) {
               
               if([self.dataArr[index] isKindOfClass:[NSDictionary class]]){
                   NSDictionary *dic = self.dataArr[index];
                   [cell setBigImgViewWithImage:[self getImageFromURL:dic[@"img"]]];
               }else{
                   [cell setBigImgViewWithImage: [self getImageFromURL:problemImages]];
               }
           }
    NSLog(@"BigImgView == %@  problemImages == %@",cell.BigImgView,problemImages);
           JJPhotoManeger *mg = [JJPhotoManeger maneger];
           mg.delegate = self;
         [mg showNetworkPhotoViewer:@[cell.BigImgView] urlStrArr:@[problemImages] selecImageindex:index];
}
-(UIImage *) getImageFromURL:(NSString *)fileURL{
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
    
        return result;
    
}
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(widths, widths);
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatBasedI375(10);
    
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatBasedI375(10);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatBasedI375(10), CGFloatBasedI375(0),CGFloatBasedI375(10), CGFloatBasedI375(0));
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CGSize size = CGSizeMake(widths, widths);
        self.collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        //左右滑动
        self.collectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionLayout.itemSize = size;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        [_collectionView registerClass:[LLPraisePicCell class] forCellWithReuseIdentifier:LLPraisePicCellid];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
                _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = White_Color;
        [self  addSubview:_collectionView];
    }
    return _collectionView;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
//        _backView.backgroundColor = [UIColor redColor];
        [self addSubview:_backView];
    }
    return _backView;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(15)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.text = @"";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
    }
    return _titlelable;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (LEEStarRating*)starRateView
{
    if (_starRateView == nil) {
        _starRateView = [[LEEStarRating alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-CGFloatBasedI375(135), CGFloatBasedI375(10), CGFloatBasedI375(100), CGFloatBasedI375(30))];
        _starRateView.checkedImage = [UIImage imageNamed:@"xing_red"];
        _starRateView.uncheckedImage = [UIImage imageNamed:@"xing_gray"];
        [self addSubview:self.starRateView];
    }
    return _starRateView;
}
-(UILabel *)timelable{
    if(!_timelable){
        _timelable = [[UILabel alloc]init];
        _timelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _timelable.textAlignment = NSTextAlignmentRight;
        _timelable.text = @"";
        _timelable.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:self.timelable];
    }
    return _timelable;
}
-(UILabel *)delabel{
    if(!_delabel){
        _delabel = [[UILabel alloc]init];
        _delabel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(15)];
        _delabel.textAlignment = NSTextAlignmentLeft;
        _delabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:self.delabel];
        _delabel.numberOfLines = 2;
    }
    return _delabel;
}
-(UILabel *)sourcelable{
    if(!_sourcelable){
        _sourcelable = [[UILabel alloc]init];
        _sourcelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _sourcelable.textAlignment = NSTextAlignmentRight;
        _sourcelable.text = @"来自 海仙水产（东圃店）";
        _sourcelable.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:self.sourcelable];

    }
    return _sourcelable;
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_lineView];
    }
    return _lineView;
}

-(UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        [self addSubview:_showimage];
        _showimage.image = [UIImage imageNamed:morenPic];
        _showimage.layer.masksToBounds = YES;
        _showimage.layer.cornerRadius = CGFloatBasedI375(20);
    }
    return _showimage;
    
}
@end
@interface LLPraisePicCell ()

@end
@implementation LLPraisePicCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    [self.showimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.top.bottom.right.offset(CGFloatBasedI375(0));
    }];
}
-(void)setImagestr:(NSString *)imagestr{
    _imagestr = imagestr;
    [self.showimage sd_setImageWithUrlString:FORMAT(@"%@",_imagestr) placeholderImage:[UIImage imageNamed:morenpic]];
}
-(UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        [self addSubview:_showimage];
        _showimage.layer.masksToBounds = YES;
        _showimage.layer.cornerRadius = CGFloatBasedI375(5);
        _showimage.userInteractionEnabled = YES;
    }
    return _showimage;
    
}
/** 查看大图 */
- (void)setBigImgViewWithImage:(UIImage *)img{
    if (_BigImgView) {
        //如果大图正在显示，还原小图
        _BigImgView.frame = self.showimage.frame;
        _BigImgView.image = img;
    }else{
        _BigImgView = [[UIImageView alloc] initWithImage:img];
        _BigImgView.frame = self.showimage.frame;
        [self insertSubview:_BigImgView atIndex:0];
    }
    _BigImgView.contentMode = UIViewContentModeScaleToFill;
}

@end
