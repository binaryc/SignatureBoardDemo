//
//  UIViewController+ChildViewController.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "UIViewController+ChildViewController.h"

@implementation UIViewController (ChildViewController)

- (void)addChildViewControllerAndChildView:(UIViewController *)childViewController
{
  [self addChildViewController:childViewController];
  [self.view addSubview:childViewController.view];
}

- (void)removeOwnControllerAndViewFromParentViewController
{
  [self removeFromParentViewController];
  [self.view removeFromSuperview];
}

@end
