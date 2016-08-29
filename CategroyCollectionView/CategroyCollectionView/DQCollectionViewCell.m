//
//  DQCollectionViewCell.m
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "DQCollectionViewCell.h"
@interface DQCollectionViewCell ()
@property(nonatomic, weak) UILabel *textlabel;
@end

@implementation DQCollectionViewCell
//重写init方法 生成UILabel
- (instancetype)initWithFrame:(CGRect)frame {

  if (self = [super initWithFrame:frame]) {

    UILabel *textlabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    textlabel.center = self.contentView.center;
    textlabel.textAlignment = NSTextAlignmentCenter;
    _textlabel = textlabel;
    self.contentView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:textlabel];
  }

  return self;
}
//重写set方法 给textlabel赋值
- (void)setLabelText:(NSString *)labelText {
  _labelText = labelText;

  _textlabel.text = labelText;
}

@end
