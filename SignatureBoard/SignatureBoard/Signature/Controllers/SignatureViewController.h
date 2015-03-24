//
//  SignatureViewController.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignatureBoardStateModel;

@interface SignatureViewController : UIViewController

@property (nonatomic, readonly) SignatureBoardStateModel *state;

@end
