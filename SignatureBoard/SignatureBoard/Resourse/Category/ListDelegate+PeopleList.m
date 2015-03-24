//
//  ListDelegate+PeopleList.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/6.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "ListDelegate+PeopleList.h"

#import "PeopleListCell.h"

#import "SignatureEntities.h"

#import "SignatureBoardStateManager.h"

@implementation ListDelegate (PeopleList)

- (PeopleListCell *)configPeopleCellAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
  static NSString *identifier = @"PeopleListCell";
  PeopleListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[PeopleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  id key = self.allKeys[indexPath.section];
  SignatureEntities *value = [[self.datasDict objectForKey:key] objectAtIndex:indexPath.row];
  cell.peopleName = value.name;
  cell.state = value.isSigned?PeopleSignedState:PeopleUnsignedState;
  
  return cell;
}

- (void)didSelectedPeopleCellAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
  id key = self.allKeys[indexPath.section];
  SignatureEntities *value = [[self.datasDict objectForKey:key] objectAtIndex:indexPath.row];
  
  SignatureBoardStateManager *manager = [SignatureBoardStateManager getInstance];
  manager.state = value.isSigned?SignatureBoardSignedState:SignatureBoardUnsignedState;
  [manager setSignaturePeople:value];
  
  [[NSNotificationCenter defaultCenter]
    postNotificationName:kPeopleCellSelectedNotificationName object:nil];
}

@end
