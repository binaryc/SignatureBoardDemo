//
//  SignatureBoardStateManager.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/6.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SignatureView;
@class SignatureEntities;

typedef NS_ENUM(NSInteger, SignatureBoardState) {
  SignatureBoardUnsignedState = 0,
  SignatureBoardSignedState
};

@interface SignatureBoardStateManager : NSObject

@property (nonatomic, readwrite) SignatureBoardState state;

@property (nonatomic, strong) SignatureEntities *signaturePeople;
@property (nonatomic, strong) SignatureView     *signatureView;

- (void)saveSignature;
- (void)cleanSignature;

+ (instancetype)getInstance;

@end
