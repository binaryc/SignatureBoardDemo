//
//  SignatureViewController.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "SignatureViewController.h"

#import "SignatureBoardStateModel.h"

#import "SignatureView.h"

#import "SignatureBoardStateManager.h"

#import "SignatureEntities.h"

@interface SignatureViewController ()

@property (nonatomic, readwrite) SignatureBoardStateModel   *state;
@property (nonatomic, readonly ) SignatureBoardStateManager *stateManager;

@end

@implementation SignatureViewController
{
  SignatureView *_signatureContex;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  [self becomeObserver];
  [self loadUnsignedBoradContext];
}

- (void)dealloc
{
  [self resignObserver];
}

#pragma mark -
#pragma mark Layout Subviews

- (void)loadUnsignedBoradContext
{
  _signatureContex = [[SignatureView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:_signatureContex];
  [self.stateManager setSignatureView:_signatureContex];
}

#pragma mark -
#pragma mark Observer

- (void)becomeObserver
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(selectPeople)
                                               name:kPeopleCellSelectedNotificationName
                                             object:nil];
}

- (void)resignObserver
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kPeopleCellSelectedNotificationName
                                                object:nil];
}

- (void)selectPeople
{
  if (self.stateManager.state == SignatureBoardSignedState)
  {
    NSString *imageName = [NSString stringWithFormat:@"%@/%@.png",signatureFolderPath(), self.stateManager.signaturePeople.name];
    [_signatureContex changeSignatureViewIntoSignedStateWithSignaturePath:imageName];
  }
  else
  {
    [_signatureContex changeSignatureViewIntoUnsignedState];
  }
}

#pragma mark -
#pragma mark Properties Method

- (SignatureBoardStateManager *)stateManager
{
  return [SignatureBoardStateManager getInstance];
}

@end
