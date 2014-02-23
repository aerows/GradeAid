//
//  RootViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentedNavigationController.h"
#import "Filter.h"
#import "PlusTableViewController.h"

static NSString *const PlusButtonPressed = @"PlusButtonPressed";

@interface RootViewController : SegmentedNavigationController<UICollectionViewDataSource, UICollectionViewDelegate, PlusButtonDelegate>
{
    IBOutlet UICollectionView *_filterItemCollectionView;
    IBOutlet UIView *_mainView;
    
    IBOutlet UIView *_filterItemPresentationView;

    IBOutlet UIButton *_editButton;
    IBOutlet UIButton *_plusButton;
    IBOutlet UIButton *_logoutButton;
}

@property (nonatomic, strong) UICollectionView *filterItemCollectionView;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, getter = isInEditMode) BOOL editMode;


@end
