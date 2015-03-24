//
//  ListDelegate+PeopleList.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/6.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "ListDelegate.h"

@class PeopleListCell;

@interface ListDelegate (PeopleList)

- (PeopleListCell *)configPeopleCellAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;
- (void)didSelectedPeopleCellAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

@end
