//
//  PaintBrush.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/9.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "PaintBrush.h"

static inline CGPoint midPoint(CGPoint startP, CGPoint endP)
{
  return CGPointMake((startP.x + endP.x)/2, (startP.y + endP.y)/2);
}

@implementation PaintBrush

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self configSignaturePen];
  }
  
  return  self;
}

- (void)configSignaturePen
{
  self.lineCapStyle = kCGLineCapRound;
  self.penDrawColor = [UIColor blackColor];
  self.penLineWidth = 4.f;
}

#pragma mark -
#pragma mark Properties Method

- (void)setPenDrawColor:(UIColor *)penDrawColor
{
  _penDrawColor = penDrawColor;
  [_penDrawColor setStroke];
}

- (void)setPenLineWidth:(CGFloat)penLineWidth
{
  _penLineWidth = penLineWidth;
  self.lineWidth = penLineWidth;
}

#pragma mark -
#pragma Pen Graphic Method

- (void)startDrawAtPoint:(CGPoint)startPoint
{
  [self moveToPoint:startPoint];
}

- (void)graphicsRenderingFromPoint:(CGPoint)currentPoint toPoint:(CGPoint)endPoint
{
  [self addQuadCurveToPoint:midPoint(currentPoint, endPoint) controlPoint:currentPoint];
}

- (void)drawSignature
{
  [self strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
}

- (void)removeSignature
{
  [self removeAllPoints];
}

@end
