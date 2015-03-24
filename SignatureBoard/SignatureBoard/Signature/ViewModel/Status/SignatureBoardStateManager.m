//
//  SignatureBoardStateManager.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/6.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "SignatureBoardStateManager.h"

#import "SignatureBoardStateModel.h"
#import "UnsiginedStateModel.h"
#import "SignedStateModel.h"

#import "SignatureEntities.h"

#import "SignatureView.h"

@implementation SignatureBoardStateManager
{
  SignatureBoardStateModel *_stateModel;
  UnsiginedStateModel      *_unSignedStateModel;
  SignedStateModel         *_signedStateModel;
}

#pragma mark -
#pragma mark Initial Method

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self loadAllStates];
  }
  
  return self;
}

- (void)loadAllStates
{
  _stateModel         = [[SignatureBoardStateModel alloc] init];
  _signedStateModel   = [[SignedStateModel alloc] init];
  _unSignedStateModel = [[UnsiginedStateModel alloc] init];
}

#pragma mark -
#pragma mark Public Method

- (void)saveSignature
{
  [_stateModel saveSignature];
}

- (void)cleanSignature
{
  [_stateModel cleanSignature];
}

#pragma mark -
#pragma mark Properties Method

- (void)setSignaturePeople:(SignatureEntities *)signaturePeople
{
  _signaturePeople                    = signaturePeople;
  _signedStateModel.signaturePeople   = signaturePeople;
  _unSignedStateModel.signaturePeople = signaturePeople;
}

- (void)setSignatureView:(SignatureView *)signatureView
{
  _signatureView                    = signatureView;
  _signedStateModel.signatureView   = signatureView;
  _unSignedStateModel.signatureView = signatureView;
}

- (void)setState:(SignatureBoardState)state
{
  _state = state;
  [self switchState:state];
}

- (void)switchState:(SignatureBoardState)state
{
  switch (state) {
    case SignatureBoardSignedState:
      _stateModel = _signedStateModel;
      break;
    case SignatureBoardUnsignedState:
      _stateModel = _unSignedStateModel;
      break;
    default:
      break;
  }
}

#pragma mark -
#pragma mark Singleton Method

static id instance = nil;

+ (instancetype)getInstance
{
  if (!instance) {
    @synchronized(self)
    {
      if (!instance) {
        instance = [[self alloc] init];
      }
    }
  }
  
  return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
  if (!instance) {
    @synchronized(self)
    {
      if (!instance) {
        instance = [super allocWithZone:zone];
      }
    }
  }

  return instance;
}

- (instancetype)copy
{
  return self;
}

@end
