//
//  SignedStatu.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "SignedStateModel.h"

#import "SignatureView.h"

#import "SignatureEntities.h"
#import "EntitiesLogicHandler.h"

#import "SignatureBoardStateManager.h"

@interface SignatureBoardStateModel ()

@property (nonatomic, readonly) EntitiesLogicHandler *datasLogicHandler;
@property (nonatomic, readonly) SignatureBoardStateManager *stateManager;

@end

@implementation SignedStateModel

- (void)saveSignature
{
//  NSInteger index = [self.datasLogicHandler.signaturePeoples indexOfObject:self.signaturePeople];
//  [self.datasLogicHandler peopleChangeIntoSignedStateAtIndex:index];
  return;
}

- (void)cleanSignature
{
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  NSString *path = [NSString stringWithFormat:@"%@/%@.png", signatureFolderPath(), self.signaturePeople.name];
  
  if ([fileManager fileExistsAtPath:path]) {
    [fileManager removeItemAtPath:path error:nil];
  }
  
  NSInteger index = [self.datasLogicHandler.signaturePeoples indexOfObject:self.signaturePeople];
  [self.datasLogicHandler peopleChangeIntoUnsignedStateAtIndex:index];
  [self.signatureView changeSignatureViewIntoUnsignedState];
  [self.stateManager setState:SignatureBoardUnsignedState];
}

- (EntitiesLogicHandler *)datasLogicHandler
{
  return [EntitiesLogicHandler getInstance];
}

- (SignatureBoardStateManager *)stateManager
{
  return [SignatureBoardStateManager getInstance];
}

@end
