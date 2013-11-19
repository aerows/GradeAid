//
//  SellectionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellectionVerifyer.h"

@interface SellectionViewController : UIViewController

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) SellectionVerifyer *sellectionVerifyer;

- (CGSize) sizeForNumberOfObjects: (NSInteger) nrOfObjects;

@end
