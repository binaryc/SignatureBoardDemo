//
//  EntitiesLogicHandler.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/8.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "EntitiesLogicHandler.h"

#import "SignatureEntities.h"

@interface EntitiesLogicHandler ()

@property (nonatomic, readwrite) NSMutableArray *peoples;

@end

@implementation EntitiesLogicHandler

#pragma mark -
#pragma mark Public Method

- (void)peopleChangeIntoSignedStateAtIndex:(NSInteger)index
{
  SignatureEntities *entity = self.signaturePeoples[index];
  entity.isSigned = YES;
}

- (void)peopleChangeIntoUnsignedStateAtIndex:(NSInteger)index
{
  SignatureEntities *entity = self.signaturePeoples[index];
  entity.isSigned = NO;
}

#pragma mark -
#pragma mark Properties Method

- (NSArray *)signaturePeoples
{
  if (!_peoples || _peoples.count == 0) {
    [self loadSignaturePeoples];
  }
  return _peoples;
}

- (void)loadSignaturePeoples
{
  if (!_peoples) {
    _peoples = [[NSArray array] mutableCopy];
  }
  for (int i = 0; i < 4; i++) {
    SignatureEntities *entity = [[SignatureEntities alloc] init];
    entity.name = [NSString stringWithFormat:@"张三 %d", i+ 1];
    entity.isSigned = NO;
    
    [_peoples addObject:entity];
  }
}


#pragma mark -
#pragma mark Singleton

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
