//
//  PeopleListCell.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "PeopleListCell.h"

@implementation PeopleListCell
{
    UILabel *_peopleNameLabel;
    UILabel *_stateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      [self configCellStyle];
    }
    
    return self;
}

- (void)configCellStyle
{
    _peopleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _peopleNameLabel.textAlignment                             = NSTextAlignmentLeft;
    _peopleNameLabel.font                                      = [UIFont systemFontOfSize:16];
    _peopleNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_peopleNameLabel];
    
    _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _stateLabel.textAlignment                             = NSTextAlignmentRight;
    _stateLabel.font                                      = [UIFont systemFontOfSize:16];
    _stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_stateLabel];
  
    [self addLayoutConstraintsForContentLabel];
}

- (void)resetCellContentLabelFrame:(UILabel *)label
{
    CGSize boundingSize = CGSizeMake(CGFLOAT_MAX, self.height);
    CGRect labelFrame = [label.text boundingRectWithSize:boundingSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : _peopleNameLabel.font}
                                                 context:nil];

    label.frame = labelFrame;
}

- (void)addLayoutConstraintsForContentLabel
{
  NSString *peopleLabelConstraintsH = @"H:|-20-[_peopleNameLabel]";
  NSString *stateLabelConstraintsH = @"H:|[_stateLabel]-20-|";
  
  NSDictionary *peopleLabelViews = NSDictionaryOfVariableBindings(_peopleNameLabel);
  NSDictionary *stateLabelViews  = NSDictionaryOfVariableBindings(_stateLabel);
  
  NSArray *peopleLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:peopleLabelConstraintsH
                                                                            options:0
                                                                            metrics:nil
                                                                              views:peopleLabelViews];
  NSArray *stateLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:stateLabelConstraintsH
                                                                           options:0
                                                                           metrics:nil
                                                                             views:stateLabelViews];
  [self addConstraints:peopleLabelConstraints];
  [self addConstraints:stateLabelConstraints];
  
}

- (NSString *)stateName:(PeopleCellState)state
{
    NSString *stateName = @"";
    switch (state) {
      case PeopleUnsignedState:
        stateName = @"未签到";
        break;
      case PeopleSignedState:
        stateName = @"已签到";
        break;
      default:
        break;
    }
    
    return stateName;
}

#pragma mark -
#pragma mark Properties Method

- (void)setState:(PeopleCellState)state
{
    _state           = state;
    _stateLabel.text = [self stateName:state];
    [self resetCellContentLabelFrame:_stateLabel];
}

- (void)setPeopleName:(NSString *)peopleName
{
    _peopleName           = peopleName;
    _peopleNameLabel.text = peopleName;
    [self resetCellContentLabelFrame:_peopleNameLabel];
}

@end
