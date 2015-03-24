//
//  UIViewController+ChildViewController.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ChildViewController)

- (void)addChildViewControllerAndChildView:(UIViewController *)childViewController;
- (void)removeOwnControllerAndViewFromParentViewController;

@end
