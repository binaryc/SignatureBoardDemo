//
//  PeopleListCell.h
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PeopleCellState) {
  PeopleUnsignedState,
  PeopleSignedState
};

@interface PeopleListCell : UITableViewCell

@property (nonatomic, assign) PeopleCellState state;
@property (nonatomic, copy  ) NSString        *peopleName;

@end
