//
//  DetailCategroyBaseView.m
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "CategroyCell.h"
#import "DetailCategroyBaseView.h"
#import "DetailCell.h"

@interface DetailCategroyBaseView () <UICollectionViewDelegate,
                                      UICollectionViewDataSource>
@property(nonatomic, weak) UICollectionView *detailCateView;
@property(nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

static NSString *detailCateCellReuseId = @"detailCateCell";

@implementation DetailCategroyBaseView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    [self setupCollectionViewWithFrame:frame];
  }
  return self;
}

- (void)setupCollectionViewWithFrame:(CGRect)frame {
  UICollectionViewFlowLayout *flowLayout =
      [[UICollectionViewFlowLayout alloc] init];

  flowLayout.itemSize =
      CGSizeMake(frame.size.width / (8 * 0.5), frame.size.height / 2);

  flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

  flowLayout.minimumLineSpacing = 0;

  flowLayout.minimumInteritemSpacing = 0;

  //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

  UICollectionView *detailCateView =
      [[UICollectionView alloc] initWithFrame:frame
                         collectionViewLayout:flowLayout];

  detailCateView.backgroundColor = [UIColor whiteColor];

  detailCateView.showsVerticalScrollIndicator = NO;

  detailCateView.showsHorizontalScrollIndicator = NO;

  detailCateView.bounces = NO;

  detailCateView.dataSource = self;

  detailCateView.delegate = self;

  _detailCateView = detailCateView;

  [self addSubview:detailCateView];

  [detailCateView registerClass:[DetailCell class]
      forCellWithReuseIdentifier:detailCateCellReuseId];
}

- (void)selectAtIndex:(NSIndexPath *)indexPath {

  _selectedIndexPath = indexPath;
}

#pragma mark--数据源方法
- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {

  return self.categroyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  DetailCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:detailCateCellReuseId
                                forIndexPath:indexPath];

  NSString *title = self.categroyArray[indexPath.item];

  cell.title = title;

  if (indexPath.item == _selectedIndexPath.item) {

    cell.isSelected = YES;

  } else {
    cell.isSelected = NO;
  }

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  CategroyCell *selectedCell = (CategroyCell *)[collectionView
      cellForItemAtIndexPath:_selectedIndexPath];

  selectedCell.isSelected = NO;

  CategroyCell *cell =
      (CategroyCell *)[collectionView cellForItemAtIndexPath:indexPath];

  cell.isSelected = YES;

  _selectedIndexPath = indexPath;

  if ([self.delegate respondsToSelector:@selector(indexChange:andIndex:)]) {

    [self.delegate indexChange:self andIndex:indexPath.item];
  }
}

@end
