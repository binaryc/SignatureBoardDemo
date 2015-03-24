//
//  PeopleListView.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "PeopleListView.h"

#define kListViewRowHeight 44.0;

@interface PeopleListView ()

@property (nonatomic, readwrite) UITableView *peopleListTableView;

@end

@implementation PeopleListView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
      [self layoutListView];
  }
  
  return self;
}

- (void)layoutListView
{
  _peopleListTableView = [[UITableView alloc] initWithFrame:self.bounds
                                                      style:UITableViewStylePlain];
  
  _peopleListTableView.rowHeight = kListViewRowHeight;
  [self addSubview:_peopleListTableView];
}

@end
