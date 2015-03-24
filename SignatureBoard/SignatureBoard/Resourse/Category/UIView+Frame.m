//
//  UIView+Frame.m
//  NumberKeyBoardPopoverView
//
//  Created by Bin Chen on 15/1/29.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x
{
  return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x
{
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (CGFloat)y
{
  return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y
{
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)width
{
  return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width
{
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)height
{
  return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height
{
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

@end
