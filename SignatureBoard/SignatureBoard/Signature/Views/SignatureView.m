//
//  SignatureView.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "SignatureView.h"
#import "PaintBrush.h"

@implementation SignatureView
{
  PaintBrush  *_pen;
  
  UIView      *_signatureDrawContext;
  UIImageView *_signatureShowContext;
  
  CGFloat      _minX;
  CGFloat      _minY;
  CGFloat      _maxX;
  CGFloat      _maxY;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self layoutSignatureDrawContext];
    [self layoutSignatureShowContex];
  }
  
  return self;
}

#pragma mark -
#pragma mark Layout Subviews

- (void)layoutSignatureDrawContext
{
  _signatureDrawContext = [[UIView alloc] initWithFrame:self.bounds];
  _signatureDrawContext.userInteractionEnabled = YES;
  [self addSubview:_signatureDrawContext];
}

- (void)layoutSignatureShowContex
{
  _signatureShowContext = [[UIImageView alloc] initWithFrame:CGRectMake(60, 190, 200, 100)];
  _signatureShowContext.layer.borderColor = [UIColor redColor].CGColor;
  _signatureShowContext.layer.borderWidth = 3;
  [self addSubview:_signatureShowContext];
}

#pragma mark -
#pragma mark Properties

- (BOOL)hasSignature
{
  if (!_pen) {
    return NO;
  }
  
  return !_pen.isEmpty;
}

- (UIImage *)signature
{
  CGSize imageSize = CGSizeMake(_maxX - _minX, _maxY - _minY);
  
  BOOL isRetinaScreen = [UIScreen mainScreen].scale > 1;
  
  CGRect imageRect;
  
  if (isRetinaScreen) {
    imageRect = CGRectMake(2*_minX - 2 * _pen.penLineWidth,
                           2*_minY - 2 * _pen.penLineWidth,
                           2*imageSize.width + 2 * _pen.penLineWidth,
                           2*imageSize.height + 2 * _pen.penLineWidth);
  }
  else
  {
    imageRect = CGRectMake(_minX - _pen.penLineWidth,
                           _minY - _pen.penLineWidth,
                           imageSize.width + _pen.penLineWidth,
                           imageSize.height + _pen.penLineWidth);
  }
  
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
  [_pen drawSignature];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, imageRect);
  UIImage *subImage = [UIImage imageWithCGImage:imageRef scale:2 orientation:UIImageOrientationUp];
  
  _maxY = _minY = 0;
  _minX = _maxX = 0;
  
  return subImage;
}

#pragma mark -
#pragma mark Public

- (void)changeSignatureViewIntoSignedStateWithSignaturePath:(NSString *)path
{
  [self moveSignatureIntoTrash];
  [_signatureShowContext setImage:[UIImage imageWithContentsOfFile:path]];
  [self insertSubview:_signatureShowContext aboveSubview:_signatureDrawContext];
  _signatureDrawContext.userInteractionEnabled = NO;
}

- (void)changeSignatureViewIntoUnsignedState
{
  [self moveSignatureIntoTrash];
  [self insertSubview:_signatureDrawContext aboveSubview:_signatureShowContext];
  [_signatureShowContext setImage:nil];
  _signatureDrawContext.userInteractionEnabled = YES;
}

#pragma mark -
#pragma mark Create Signature

- (void)drawRect:(CGRect)rect
{
  [_pen drawSignature];
}

- (void)moveSignatureIntoTrash
{
  [_pen removeSignature];
  [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Touch Method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  
  if (touch.view != _signatureDrawContext) {
    return;
  }
  
  if (!_pen) {
    _pen = [[PaintBrush alloc] init];
  }
  
  CGPoint startPoint = [touch locationInView:self];
  [_pen startDrawAtPoint:startPoint];
  
  
  if (_minX == _maxX && _maxY == _minY) {
    _minX = _maxX = startPoint.x;
    _minY = _maxY = startPoint.y;
  }
  else
  {
    _minX = _minX > startPoint.x?startPoint.x:_minX;
    _maxX = _maxX < startPoint.x?startPoint.x:_maxX;
    _minY = _minY > startPoint.y?startPoint.y:_minY;
    _maxY = _maxY < startPoint.y?startPoint.y:_maxY;
  }
  
  
  
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  
  if (touch.view != _signatureDrawContext) {
    return;
  }
  
  CGPoint currentLocation = [touch locationInView:self];
  CGPoint previousLocation = [touch previousLocationInView:self];
  
  [_pen graphicsRenderingFromPoint:previousLocation toPoint:currentLocation];
  
  _minX = _minX > currentLocation.x?currentLocation.x:_minX;
  _maxX = _maxX < currentLocation.x?currentLocation.x:_maxX;
  _minY = _minY > currentLocation.y?currentLocation.y:_minY;
  _maxY = _maxY < currentLocation.y?currentLocation.y:_maxY;
  
  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self touchesMoved:touches withEvent:event];
}

@end
