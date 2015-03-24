//
//  UnsiginedStatus.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "UnsiginedStateModel.h"

#import "SignatureView.h"

#import "SignatureEntities.h"
#import "EntitiesLogicHandler.h"

#import "SignatureBoardStateManager.h"

@interface UnsiginedStateModel ()

@property (nonatomic, readonly) EntitiesLogicHandler *datasLogicHandler;
@property (nonatomic, readonly) SignatureBoardStateManager *stateManager;

@end

@implementation UnsiginedStateModel

- (void)saveSignature
{
  NSData *imageData = UIImagePNGRepresentation(self.signatureView.signature);
  NSString *path = [NSString stringWithFormat:@"%@/%@.png", signatureFolderPath(), self.signaturePeople.name];
  [imageData writeToFile:path atomically:YES];
  
  NSInteger index = [self.datasLogicHandler.signaturePeoples indexOfObject:self.signaturePeople];
  [self.datasLogicHandler peopleChangeIntoSignedStateAtIndex:index];
  [self.signatureView changeSignatureViewIntoSignedStateWithSignaturePath:path];
  [self.stateManager setState:SignatureBoardSignedState];
}

- (void)cleanSignature
{
  [self.signatureView moveSignatureIntoTrash];
//  NSInteger index = [self.datasLogicHandler.signaturePeoples indexOfObject:self.signaturePeople];
//  [self.datasLogicHandler peopleChangeIntoUnsignedStateAtIndex:index];
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
