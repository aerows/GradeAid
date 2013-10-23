//
//  HomeViewController2.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController2 : UIViewController

@property (strong, nonatomic) IBOutlet UIView *teacherView;
@property (strong, nonatomic) IBOutlet UIView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *scrollHandle;

- (IBAction) handlePan:(id)sender;

@end
