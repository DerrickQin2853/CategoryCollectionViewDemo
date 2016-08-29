//
//  CategroyCell.m
//  CategroyCollectionView
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "CategroyCell.h"
@interface CategroyCell ()
@property(nonatomic, weak) UILabel *textLabel;
@end

@implementation CategroyCell
- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];

  if (self) {

    UILabel *textLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];

    textLabel.textAlignment = NSTextAlignmentCenter;

    textLabel.center =
        CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);

    _textLabel = textLabel;

    [self.contentView addSubview:textLabel];
  }

  return self;
}

- (void)setTitle:(NSString *)title {

  _title = title;

  _textLabel.text = title;
}

//-(void)setIsSelected:(BOOL)isSelected{
//
//    _isSelected = isSelected;
//
//    if (isSelected) {
//
//        _textLabel.textColor = [UIColor colorWithRed:1.0 green:0.0786
//        blue:0.2518 alpha:1.0];
//
//    }
//    else{
//
//        _textLabel.textColor = [UIColor blackColor];
//    }
//}

@end
