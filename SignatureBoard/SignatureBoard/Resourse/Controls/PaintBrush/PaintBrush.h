//
//  PaintBrush.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/9.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintBrush : UIBezierPath

@property (nonatomic, strong) UIColor *penDrawColor;
@property (nonatomic, assign) CGFloat  penLineWidth;

- (void)startDrawAtPoint:(CGPoint)startPoint;
- (void)graphicsRenderingFromPoint:(CGPoint)currentPoint toPoint:(CGPoint)endPoint;

- (void)drawSignature;
- (void)removeSignature;

@end
