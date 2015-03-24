//
//  PeopleListDelegate.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListDelegate : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) NSArray      *allKeys;
@property (nonatomic, readonly) NSDictionary *datasDict;

- (instancetype)initWithDataSource:(id)dataSource;

@end
