//
//  SignatureView.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureView : UIView

@property (nonatomic, readonly) BOOL    hasSignature;
@property (nonatomic, readonly) UIImage *signature;

- (void)moveSignatureIntoTrash;

- (void)changeSignatureViewIntoSignedStateWithSignaturePath:(NSString *)path;
- (void)changeSignatureViewIntoUnsignedState;

@end
