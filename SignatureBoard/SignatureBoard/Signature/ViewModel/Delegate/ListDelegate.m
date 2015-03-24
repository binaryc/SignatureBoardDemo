//
//  PeopleListDelegate.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "ListDelegate.h"
#import "ListDelegate+PeopleList.h"

#import "PeopleListCell.h"

#import "SignatureEntities.h"

@implementation ListDelegate
{
  NSArray             *_allKeys;
  NSMutableDictionary *_datasDict;
}

- (instancetype)initWithDataSource:(id)dataSource
{
  self = [super init];
  if (self) {
    _datasDict = [[NSDictionary dictionary] mutableCopy];
    [self handleDataSource:dataSource];
  }
  
  return self;
}

- (void)handleDataSource:(id)dataSource
{
  if ([dataSource isKindOfClass:[NSArray class]]) {
    [_datasDict setObject:dataSource forKey:@"Array"];
    _allKeys = [_datasDict allKeys];
  }
  else if ([dataSource isKindOfClass:[NSDictionary class]])
  {
    _datasDict = dataSource;
    _allKeys   = [dataSource allKeys];
  }
}

#pragma mark -
#pragma mark TableView Delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [_allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  id key = _allKeys[section];
  return [[_datasDict objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  UITableViewCell *cell = [self configPeopleCellAtIndexPath:indexPath inTableView:tableView];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self didSelectedPeopleCellAtIndexPath:indexPath inTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  id key = [_allKeys objectAtIndex:section];
  return [NSString stringWithFormat:@"%@",key];
}

#pragma mark -
#pragma mark Properties

- (NSArray *)allKeys
{
  return _allKeys;
}

- (NSDictionary *)datasDict
{
  return _datasDict;
}
@end
