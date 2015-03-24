//
//  SignatureBoardStatus.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SignatureView;
@class SignatureEntities;

@protocol SignatureOperations <NSObject>

- (void)saveSignature;
- (void)cleanSignature;

@end

@interface SignatureBoardStateModel : NSObject<SignatureOperations>

@property (nonatomic, strong) SignatureEntities *signaturePeople;
@property (nonatomic, strong) SignatureView     *signatureView;

@end



