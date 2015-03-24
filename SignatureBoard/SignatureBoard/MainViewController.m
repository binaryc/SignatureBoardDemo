//
//  MainViewController.m
//  SignatureBoard
//
//  Created by Bin Chen on 15/2/2.
//  Copyright (c) 2015年 touchDream. All rights reserved.
//

#import "MainViewController.h"
#import "SignatureViewController.h"
#import "PeopleListViewController.h"

#import "SignatureBoardStateManager.h"
#import "PDFGenerator.h"

#import "DocumentInteractionDelegate.h"

static inline NSString *selectorsString(int index);
static inline UIBarButtonSystemItem toolBarSystemItem(int index);

@interface MainViewController ()

@property (nonatomic, assign) BOOL isSelectedPeople;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self initFolders];
  [self becomeObserver];
  [self layoutNavigationBarStyle];
  [self layoutToolBarStyle];
  [self layoutViewStyle];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:NO];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
  [self resignObserver];
}

#pragma mark -
#pragma mark Observer Notification

- (void)becomeObserver
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(selectPeople)
                                               name:kPeopleCellSelectedNotificationName
                                             object:nil];
}

- (void)resignObserver
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kPeopleCellSelectedNotificationName
                                                object:nil];
}

- (void)selectPeople
{
  if ([self.navigationController.topViewController
       isKindOfClass:[PeopleListViewController class]])
  {
    [self.navigationController popViewControllerAnimated:YES];
  }
  
  if (!_isSelectedPeople) {
    [self layoutSignatureViewController];
    _isSelectedPeople = YES;
  }
}

#pragma mark -
#pragma mark Initial Folders

- (void)initFolders
{
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  
  BOOL isImageFolderExist = [fileManager fileExistsAtPath:signatureFolderPath()];
  if (!isImageFolderExist) {
    [fileManager createDirectoryAtPath:signatureFolderPath()
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
  }
  
  BOOL isPDFFolderExist = [fileManager fileExistsAtPath:pdfFolderPath()];
  if (!isPDFFolderExist) {
    [fileManager createDirectoryAtPath:pdfFolderPath()
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
  }
  
}

#pragma mark -
#pragma mark Layout Subviews

- (void)layoutViewStyle
{
  _isSelectedPeople = NO;
  [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)layoutNavigationBarStyle
{
  self.title = kSignatureBoardNavigationBarTitle;

  UIBarButtonItem *selectPeopleRightItem = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                 target:self
                                                                 action:@selector(pushPeopleListViewController)];
  self.navigationItem.rightBarButtonItem = selectPeopleRightItem;
  
}

- (void)layoutToolBarStyle
{
  self.navigationController.toolbarHidden = NO;
  
  NSMutableArray *items = [NSMutableArray array];

  for (int i = 0; i < 5; i++) {
    SEL selector = NSSelectorFromString(selectorsString(i));
    UIBarButtonItem *toolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:toolBarSystemItem(i)
                                                                                 target:self
                                                                                 action:selector];
    [items addObject:toolBarItem];
  }

  self.toolbarItems  = items;
  
}

- (void)layoutSignatureViewController
{
  self.automaticallyAdjustsScrollViewInsets = YES;
  SignatureViewController *signatureController = [[SignatureViewController alloc] init];
  [self addChildViewControllerAndChildView:signatureController];
}

#pragma mark -
#pragma mark NavigationBarItem Action

- (void)pushPeopleListViewController
{
  PeopleListViewController *peopleListController = [[PeopleListViewController alloc] init];
  [self.navigationController pushViewController:peopleListController animated:YES];
}

#pragma mark -
#pragma mark ToolBarItem Action

- (void)saveSignature
{
  [[SignatureBoardStateManager getInstance] saveSignature];
}

- (void)cleanSignature
{
  [[SignatureBoardStateManager getInstance] cleanSignature];
}

- (void)moreOperations
{
  NSFileManager *fileManager = [[NSFileManager alloc] init];
  NSArray *imageFiles = [fileManager contentsOfDirectoryAtPath:signatureFolderPath() error:nil];
  
  NSString *condition = @"SELF CONTAINS '.png'";
  NSPredicate *predicate = [NSPredicate predicateWithFormat:condition];
  NSArray *fileNames = [imageFiles filteredArrayUsingPredicate:predicate];
  
  if (fileNames && fileNames.count > 0) {
    NSMutableArray *images = [NSMutableArray array];
    [fileNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", signatureFolderPath(), obj]];
      [images addObject:image];
    }];
    
    [PDFGenerator createPDFFileAtPath:[NSString stringWithFormat:@"%@/signature.pdf", pdfFolderPath()]
                           withImages:images];
  }
  
}

@end

static inline NSString *selectorsString(int index)
{
  NSArray *selectorStrings = @[@"saveSignature", @"", @"cleanSignature", @"", @"moreOperations"];
  return selectorStrings[index];
}

static inline UIBarButtonSystemItem toolBarSystemItem(int index)
{
  UIBarButtonSystemItem systemItem;
  switch (index) {
    case 0:
      systemItem = UIBarButtonSystemItemSave;
      break;
    case 1:
      systemItem = UIBarButtonSystemItemFlexibleSpace;
      break;
    case 2:
      systemItem = UIBarButtonSystemItemCancel;
      break;
    case 3:
      systemItem = UIBarButtonSystemItemFlexibleSpace;
      break;
    case 4:
      systemItem = UIBarButtonSystemItemAction;
    break;
    default:
    break;
  }
  return systemItem;
}