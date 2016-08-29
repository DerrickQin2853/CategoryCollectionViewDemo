//
//  CategroyBaseView.m
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "CategroyBaseView.h"
#import "CategroyCell.h"
//下标高度
#define kIndicatorH 3
//选项cell宽度
#define kItemSizeW 55

@interface CategroyBaseView () <UICollectionViewDataSource,
                                UICollectionViewDelegate>

@property(nonatomic, assign) BOOL btnIsClicked;
@property(nonatomic, weak) UIView *indictorView;
@property(nonatomic, weak) UICollectionView *cateView;
@property(nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

static NSString *cateCellReuseId = @"cateCell";

@implementation CategroyBaseView

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];

  if (self) {

    self.backgroundColor = [UIColor whiteColor];

    [self setupBaseView:frame];

    [self setupButton:frame];

    [self setupCollectionView:frame];

    [self setupIndictor:frame];
  }

  return self;
}

/**
 *  添加底层View
 *
 *  @param frame
 */
- (void)setupBaseView:(CGRect)frame {

  UIView *baseView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];

  UILabel *textLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(25, frame.size.height * 0.5 - 12.5, 120, 25)];

  textLabel.text = @"All Categroies";

  textLabel.font = [UIFont systemFontOfSize:13];

  textLabel.textColor = [UIColor darkGrayColor];

  [baseView addSubview:textLabel];

  baseView.backgroundColor =
      [UIColor colorWithRed:0.9444 green:0.9444 blue:0.9444 alpha:1.0];

  [self addSubview:baseView];
}
/**
 *  添加下拉按钮
 *
 *  @param frame
 */
- (void)setupButton:(CGRect)frame {

  UIButton *changeBtn = [[UIButton alloc]
      initWithFrame:CGRectMake(frame.size.width - frame.size.height, 0,
                               frame.size.height, frame.size.height)];

  UIImage *image = [UIImage imageNamed:@"explore_board_indicator"];

  UIImageView *btnImageView = [[UIImageView alloc] initWithImage:image];

  btnImageView.frame = CGRectMake(0, 0, changeBtn.bounds.size.width * 0.25,
                                  changeBtn.bounds.size.height * 0.25);

  btnImageView.center = CGPointMake(changeBtn.bounds.size.width * 0.5,
                                    changeBtn.bounds.size.height * 0.5);

  btnImageView.contentMode = UIViewContentModeScaleAspectFit;

  [changeBtn setBackgroundColor:[UIColor whiteColor]];

  _changeButton = changeBtn;

  [changeBtn addSubview:btnImageView];
  //添加点击触发事件
  [changeBtn addTarget:self
                action:@selector(changeBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];

  [self addSubview:changeBtn];
}

/**
 *  添加collectionView
 *
 *  @param frame
 */
- (void)setupCollectionView:(CGRect)frame {

  UICollectionViewFlowLayout *flowLayout =
      [[UICollectionViewFlowLayout alloc] init];

  flowLayout.itemSize = CGSizeMake(kItemSizeW, frame.size.height - kIndicatorH);

  flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

  flowLayout.minimumLineSpacing = 0;

  flowLayout.minimumInteritemSpacing = 0;

  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

  UICollectionView *cateView = [[UICollectionView alloc]
             initWithFrame:CGRectMake(0, 0,
                                      frame.size.width - frame.size.height,
                                      frame.size.height)
      collectionViewLayout:flowLayout];

  cateView.backgroundColor = [UIColor whiteColor];

  cateView.showsVerticalScrollIndicator = NO;

  cateView.showsHorizontalScrollIndicator = NO;

  cateView.bounces = NO;

  cateView.dataSource = self;

  cateView.delegate = self;

  _cateView = cateView;

  [self addSubview:cateView];

  [cateView registerClass:[CategroyCell class]
      forCellWithReuseIdentifier:cateCellReuseId];
}

- (void)setupIndictor:(CGRect)frame {

  UIView *indictorView = [[UIView alloc]
      initWithFrame:CGRectMake(0, frame.size.height - kIndicatorH, kItemSizeW,
                               kIndicatorH)];

  indictorView.backgroundColor =
      [UIColor colorWithRed:1.0 green:0.0786 blue:0.2518 alpha:1.0];

  _indictorView = indictorView;

  [_cateView addSubview:indictorView];
}

/**
 *  按钮触发事件
 *
 *  @param changeBtn
 */
- (void)changeBtnClick:(UIButton *)changeBtn {
  //记录按钮状态
  _btnIsClicked = !_btnIsClicked;

  UIImageView *imageView = _changeButton.subviews.lastObject;
  //旋转
  imageView.transform = _btnIsClicked ? CGAffineTransformMakeRotation(M_PI)
                                      : CGAffineTransformMakeRotation(0);

  if (_btnIsClicked) {

    _cateView.hidden = YES;

    [_changeButton setBackgroundColor:[UIColor colorWithRed:0.9444
                                                      green:0.9444
                                                       blue:0.9444
                                                      alpha:1.0]];

  } else {
    [_changeButton setBackgroundColor:[UIColor whiteColor]];

    _cateView.hidden = NO;
  }

  if (_changeBtnClick) {

    _changeBtnClick(_changeButton, _btnIsClicked, _selectedIndexPath);
  }
}

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

  CategroyCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:cateCellReuseId
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

  [UIView animateWithDuration:0.2
                   animations:^{

                     CGRect currentRect = _indictorView.frame;

                     currentRect.origin.x = kItemSizeW * indexPath.item;

                     _indictorView.frame = currentRect;
                   }];

  if (_indexChange) {

    _indexChange(indexPath.item);
  }

  [_cateView
      scrollToItemAtIndexPath:indexPath
             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                     animated:YES];
}

- (void)selectAtIndex:(NSInteger)index {

  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];

  [self collectionView:_cateView didSelectItemAtIndexPath:indexPath];
}

@end
