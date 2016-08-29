//
//  DetailCategroyBaseView.h
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailCategroyBaseView;

@protocol DetailCellControllerDelegate <NSObject>

@optional
- (void)indexChange:(DetailCategroyBaseView *)detailCategroyBaseView
           andIndex:(NSInteger)itemIndex;
@end

@interface DetailCategroyBaseView : UIView
@property(nonatomic, strong) NSArray *categroyArray;
@property(nonatomic, weak) id<DetailCellControllerDelegate> delegate;
- (void)selectAtIndex:(NSIndexPath *)indexPath;
@end
