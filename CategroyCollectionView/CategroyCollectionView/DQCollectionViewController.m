//
//  DQCollectionViewController.m
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "CategroyBaseView.h"
#import "DQCollectionViewCell.h"
#import "DQCollectionViewController.h"
#import "DetailCategroyBaseView.h"

//分类栏高度
#define kCateBarH 40

@interface DQCollectionViewController () <DetailCellControllerDelegate>
@property(nonatomic, strong) NSArray *categroyArray;
@property(nonatomic, weak) CategroyBaseView *cateView;
@property(nonatomic, weak) DetailCategroyBaseView *detailView;
@property(nonatomic, weak) UIButton *coverView;
@end

static NSString *cellIndentifier = @"cellID";

@implementation DQCollectionViewController
//懒加载
- (NSArray *)categroyArray {
  if (!_categroyArray) {
    _categroyArray = @[
      @"cate1",
      @"cate2",
      @"cate3",
      @"cate4",
      @"cate5",
      @"cate6",
      @"cate7",
      @"cate8"
    ];
  }

  return _categroyArray;
}

- (instancetype)init {

  UICollectionViewFlowLayout *flowLayout =
      [[UICollectionViewFlowLayout alloc] init];
  //设置flowlayout属性
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  //减去状态条，tabbar，navigationbar的高度
  flowLayout.itemSize =
      CGSizeMake([UIScreen mainScreen].bounds.size.width,
                 [UIScreen mainScreen].bounds.size.height - 44 - 49 - 20);
  flowLayout.minimumLineSpacing = 0;
  flowLayout.minimumInteritemSpacing = 0;
  flowLayout.sectionInset = UIEdgeInsetsZero;

  self = [super initWithCollectionViewLayout:flowLayout];

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:[DQCollectionViewCell class]
          forCellWithReuseIdentifier:cellIndentifier];

  self.collectionView.showsHorizontalScrollIndicator = NO;
  self.collectionView.showsVerticalScrollIndicator = NO;
  self.collectionView.bounces = NO;

  [self setupCateView];
}

- (void)loadView {
  [super loadView];
  //设置高斯模糊：关闭
  self.navigationController.navigationBar.translucent = NO;
  self.tabBarController.tabBar.translucent = NO;
  //设置颜色
  self.collectionView.backgroundColor = [UIColor blueColor];
  self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
  self.tabBarController.tabBar.barTintColor = [UIColor cyanColor];
  //分页效果
  self.collectionView.pagingEnabled = YES;
    
  self.title = @"Demo";
}
/**
 *  设置分类栏
 */
- (void)setupCateView {

  //添加分类栏

  CategroyBaseView *cateView = [[CategroyBaseView alloc]
      initWithFrame:CGRectMake(0, 0, self.collectionView.bounds.size.width,
                               kCateBarH)];

  cateView.categroyArray = self.categroyArray;

  _cateView = cateView;

  cateView.indexChange = ^(NSInteger itemIndex) {

    NSIndexPath *indexPath =
        [NSIndexPath indexPathForItem:itemIndex inSection:0];

    //记得动画效果去掉
    [self.collectionView
        scrollToItemAtIndexPath:indexPath
               atScrollPosition:UICollectionViewScrollPositionLeft
                       animated:NO];

  };

  cateView.changeBtnClick = ^(UIButton *changeBtn, BOOL btnIsSelected,
                              NSIndexPath *indexPath) {

    if (btnIsSelected) {

      UIButton *coverView = [[UIButton alloc]
          initWithFrame:CGRectMake(
                            0, 40, [UIScreen mainScreen].bounds.size.width,
                            [UIScreen mainScreen].bounds.size.height - 40)];

      [coverView setBackgroundColor:[UIColor blackColor]];
      coverView.alpha = 0.45;
      [coverView addTarget:self
                    action:@selector(cancelDetailView)
          forControlEvents:UIControlEventTouchUpInside];
      _coverView = coverView;
      [self.view addSubview:coverView];

      DetailCategroyBaseView *detailView = [[DetailCategroyBaseView alloc]
          initWithFrame:CGRectMake(
                            0, 0, [UIScreen mainScreen].bounds.size.width, 80)];

      detailView.categroyArray = self.categroyArray;
      detailView.delegate = self;

      [self.view addSubview:detailView];

      _detailView = detailView;

      [detailView selectAtIndex:indexPath];

      [self.view bringSubviewToFront:_cateView];

      [UIView
          animateWithDuration:0.2
                   animations:^{
                     _detailView.frame = CGRectMake(
                         0, 40, [UIScreen mainScreen].bounds.size.width, 80);
                   }];
    } else {

      [_coverView removeFromSuperview];

      _coverView = nil;

      [self.view bringSubviewToFront:_cateView];

      [UIView animateWithDuration:0.2
          animations:^{
            _detailView.frame =
                CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, 80);

          }
          completion:^(BOOL finished) {

            [_detailView removeFromSuperview];

            _detailView = nil;

          }];
    }
  };

  [self.view addSubview:cateView];
}

- (void)cancelDetailView {

  [_cateView changeBtnClick:nil];
}

- (void)indexChange:(DetailCategroyBaseView *)detailCategroyBaseView
           andIndex:(NSInteger)itemIndex {

  [self.view bringSubviewToFront:_cateView];

  [UIView animateWithDuration:0.2
      animations:^{

        _detailView.transform = CGAffineTransformMakeTranslation(0, 0);

      }
      completion:^(BOOL finished) {

        [_detailView removeFromSuperview];

      }];

  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];

  //记得动画效果去掉
  [self.collectionView
      scrollToItemAtIndexPath:indexPath
             atScrollPosition:UICollectionViewScrollPositionLeft
                     animated:NO];

  [_cateView selectAtIndex:itemIndex];

  [_cateView changeBtnClick:nil];
}

/**
 *  collectionView结束滚动时
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

  //根据当前 contentoffset获得index

  CGFloat width = scrollView.contentSize.width / self.categroyArray.count;

  CGFloat offsetX = scrollView.contentOffset.x;

  NSInteger index = offsetX / width;
  //选择cateview的index
  [_cateView selectAtIndex:index];
}

#pragma mark-- 数据源方法
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
  DQCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier
                                                forIndexPath:indexPath];
  cell.labelText = self.categroyArray[indexPath.item];
  return cell;
}
@end
