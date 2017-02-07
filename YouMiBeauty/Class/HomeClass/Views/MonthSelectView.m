//
//  MonthSelectView.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/24.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "MonthSelectView.h"
#import "DateCalenCollectionViewCell.h"

@interface MonthSelectView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)UICollectionView  * monthcollectionview;

@end
static NSString *const ID = @"dateCalenCollectionViewCellIdentifier";
@implementation MonthSelectView

-(id)initM_calenbarviewframe:(CGRect)frame
{
    if (!_monthSelectView) {
        
        _monthSelectView = [[MonthSelectView alloc] init];
        
    }
    self.monthSelectView.frame = frame;
    
    return self;
}

- (void)setData{

    [_datesource removeAllObjects];
    if (_dateFrom == EDateMonth) {
        
        _datesource = [NSMutableArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil];
        
    }else{
    
        for (int i = 1; i <= _dayOfMonthNum; i ++) {
            
            [self.datesource addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [_monthcollectionview reloadData];
    }
    
}
- (NSMutableArray *)datesource{

    if (!_datesource) {
        _datesource = [NSMutableArray array];
    }
    return _datesource;
}

- (void)creatCollectionview
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    if (_dateFrom == EDateMonth) {
    
        self.monthcollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.monthSelectView.frame.size.width,SCREEN_WIDTH/6) collectionViewLayout:layout];
    }else{
    
        self.monthcollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.monthSelectView.frame.size.width,SCREEN_WIDTH/7) collectionViewLayout:layout];
    }
    
    
    [self.monthcollectionview  setContentOffset:CGPointMake(self.monthSelectView.frame.size.width * self.offpage, 0)];//偏移量
    
    self.monthcollectionview.pagingEnabled = NO;
    self.monthcollectionview.delegate = self;
    self.monthcollectionview.dataSource = self;
    [self.monthcollectionview registerClass:[DateCalenCollectionViewCell class] forCellWithReuseIdentifier:ID];
    //==
    self.monthcollectionview.showsHorizontalScrollIndicator = NO;
    
    [self.monthSelectView addSubview:self.monthcollectionview];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _datesource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DateCalenCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];


    if (_dateFrom == EDateMonth) {
    
        [cell MonthLabel:indexPath comp:_comp number:_datesource[indexPath.row] fromType:0];
    }else{
    
        [cell MonthLabel:indexPath comp:_comp number:_datesource[indexPath.row] fromType:1];
    }
    
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dateFrom == EDateMonth) {
    
        return CGSizeMake(self.monthSelectView.frame.size.width/6, self.monthSelectView.frame.size.width/6);
    }
    return CGSizeMake(self.monthSelectView.frame.size.width/7, self.monthSelectView.frame.size.width/7);
    
}


- (void)getdatesource
{

    if (_dateFrom == EDateMonth) {
    
        if (_comp <= 6) {
            self.offpage = 0;
        }
        if (_comp > 6 && _comp <= 12) {
            
            self.offpage = 1;
        }
        
    }else{
    
        if (_comp <= 7) {
            self.offpage = 0;
        }
        if (_comp > 7 && _comp <= 14) {
            
            self.offpage = 1;
        }
        if (_comp > 14 && _comp <= 21) {
            
            self.offpage = 2;
        }
        if (_comp > 21 && _comp <= 28) {
            
            self.offpage = 3;
        }
        if (_comp > 28 && _comp <= 31) {
            
            self.offpage = 4;
        }
    }
    
    [self creatCollectionview];
    
//    [self.monthcollectionview reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _comp = indexPath.row+1;
    [collectionView reloadData];
    NSString * gobackDate = [NSString stringWithFormat:@"%ld",(indexPath.row + 1 )];

    if(_selectBlock){
    
        _selectBlock(gobackDate);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)setMcalenbarBGcolor:(UIColor *)McalenbarBGcolor
{
    self.monthcollectionview.backgroundColor = McalenbarBGcolor ;
    _McalenbarBGcolor = McalenbarBGcolor;
}



@end
