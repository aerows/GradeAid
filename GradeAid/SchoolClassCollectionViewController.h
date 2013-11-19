//
//  SchoolClassCollectionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "School+Create.h"

@interface SchoolClassCollectionViewController : UIViewController<UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *schoolClassCollectionView;
@property (nonatomic, strong) School *selectedSchool;

@end
