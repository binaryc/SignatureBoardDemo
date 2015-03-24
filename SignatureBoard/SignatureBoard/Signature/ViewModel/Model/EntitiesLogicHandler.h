//
//  EntitiesLogicHandler.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/8.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntitiesLogicHandler : NSObject

@property (nonatomic, readonly) NSArray *signaturePeoples;

- (void)peopleChangeIntoSignedStateAtIndex:(NSInteger)index;
- (void)peopleChangeIntoUnsignedStateAtIndex:(NSInteger)index;

+ (instancetype)getInstance;

@end
