//
//  CategroyBaseView.h
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategroyBaseView : UIView
@property(nonatomic, strong) NSArray *categroyArray;
@property(nonatomic, weak) UIButton *changeButton;
@property(nonatomic, copy) void (^indexChange)(NSInteger);
@property(nonatomic, copy) void (^changeBtnClick)
    (UIButton *, BOOL, NSIndexPath *);
- (void)selectAtIndex:(NSInteger)index;
- (void)changeBtnClick:(UIButton *)changeBtn;
@end
