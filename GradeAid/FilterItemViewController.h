//
//  FilterViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterItem.h"
#import "PromptViewController.h"

typedef void(^DismissFilterItemViewControllerBlock)();

@interface FilterItemViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, PromptDelegate>
{
    IBOutlet UICollectionView *_filterItemCollectionView;
    IBOutlet UIButton *_editButton;
}

- (CGFloat) neededHeight;

@property (nonatomic) BOOL inEditMode;

@property (nonatomic, strong) __block FilterItem* filterItem;
@property (nonatomic, strong) __block UICollectionView *filterItemCollectionView;
@property (nonatomic, copy) DismissFilterItemViewControllerBlock dismissBlock;

@end
