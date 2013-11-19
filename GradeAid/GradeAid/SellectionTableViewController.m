//
//  SellectionTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SellectionTableViewController.h"

static CGFloat const cellHeight = 49.f;
static CGFloat const tableWidth = 320.f;

@interface SellectionTableViewController ()

@end

@implementation SellectionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize) sizeForNumberOfObjects:(NSInteger)nrOfObjects
{
    int rows = (nrOfObjects > 7) ? 7 : nrOfObjects;
    
    CGFloat collectionViewHeight = cellHeight * rows;
    CGFloat collectionViewWidth  = tableWidth;
    
    return CGSizeMake(collectionViewWidth, collectionViewHeight);
}

#pragma mark - Getters and Setters

@synthesize tableView = _tableView;
@synthesize cancelButton = _cancelButton;
@synthesize sellectionVerifyer = _sellectionVerifyer;

- (void) setSellectionVerifyer:(SellectionVerifyer *)sellectionVerifyer
{
    _sellectionVerifyer = sellectionVerifyer;
    _tableView.delegate = _sellectionVerifyer;
    _tableView.dataSource = _sellectionVerifyer;
}

@end
