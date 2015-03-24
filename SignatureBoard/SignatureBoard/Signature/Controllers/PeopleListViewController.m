//
//  PeopleListViewController.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/5.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "PeopleListViewController.h"

#import "PeopleListView.h"

#import "ListDelegate.h"

#import "SignatureEntities.h"
#import "EntitiesLogicHandler.h"

@interface PeopleListViewController ()

@property (nonatomic, strong) PeopleListView *peopleListView;
@property (nonatomic, strong) ListDelegate   *delegate;

@end

@implementation PeopleListViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setNavigationStyle];
  [self initialPeopleListViewDelegate];
  [self loadPeopleListView];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:YES];
}

- (void)setNavigationStyle
{
  [self setTitle:kPeopleListNavigationBarTitle];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  [self.navigationController setToolbarHidden:YES];
}

- (void)loadPeopleListView
{
  _peopleListView = [[PeopleListView alloc] initWithFrame:self.view.bounds];
  _peopleListView.peopleListTableView.delegate   = _delegate;
  _peopleListView.peopleListTableView.dataSource = _delegate;
  [self.view addSubview:_peopleListView];
  [_peopleListView.peopleListTableView reloadData];
}

- (void)initialPeopleListViewDelegate
{
  EntitiesLogicHandler *handler = [EntitiesLogicHandler getInstance];
  _delegate = [[ListDelegate alloc] initWithDataSource:handler.signaturePeoples];
}

@end
