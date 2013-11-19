//
//  SellectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//
#import "CollectionViewDataFetcher.h"
#import "SellectionViewController.h"
#import "PopupCell.h"
#import "CellPresentable.h"

static CGFloat const buttonMarginHeight = 46.f;

static CGSize const  cellSize = {100, 100};

static CGFloat const topMargin      = 10;
static CGFloat const leftMargin     = 10;
static CGFloat const rightMargin    = 10;
static CGFloat const bottomMargin   = 10;

static CGFloat const cellSpacing    = 10;

@interface SellectionViewController ()

@end

@implementation SellectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    [_collectionView registerNib: @"PopupCell" forCellWithReuseIdentifier: PopupCellIdentifier];
//    
    _collectionView.delegate   = _sellectionVerifyer;
    _collectionView.dataSource = _sellectionVerifyer;
}

- (IBAction) cancelButtonWasPressed: (id) sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (CGSize) sizeForNumberOfObjects:(NSInteger)nrOfObjects
{
    int columns = (nrOfObjects > 12) ? 4 : 3;
    int rows = ((nrOfObjects - 1) / 3) + 1;
    rows = (rows == 5) ? 4 : rows;
    rows = (rows >  5) ? 5 : rows;
    
    CGFloat collectionViewHeight = cellSize.height * rows + cellSpacing * (rows - 1) + topMargin + bottomMargin;
    CGFloat collectionViewWidth  = cellSize.width * columns + cellSpacing * (columns - 1) + leftMargin + rightMargin;
    
    return CGSizeMake(collectionViewWidth, collectionViewHeight);
}

#pragma mark - Getters and Setters

@synthesize collectionView = _collectionView;
@synthesize cancelButton = _cancelButton;
@synthesize sellectionVerifyer = _sellectionVerifyer;

- (void) setSellectionVerifyer:(SellectionVerifyer *)sellectionVerifyer
{
    _sellectionVerifyer = sellectionVerifyer;
    _collectionView.delegate = _sellectionVerifyer;
    _collectionView.dataSource = _sellectionVerifyer;
}

@end
