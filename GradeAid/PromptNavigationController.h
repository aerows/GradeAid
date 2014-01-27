//
//  PromptNavigationController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-11.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptViewController.h"
#import "SelectSchoolPromptViewController.h"
#import "CreateSchoolPromptViewController.h"


@interface PromptNavigationController : UIViewController<PromptEnviorment>
{
    IBOutlet UIView *_backgroundView;
    IBOutlet UIView *navigationContainer;
    
    NSMutableArray *_navigationControllers;
}

@property (nonatomic, strong) NSArray *navigationControllers;
@property (nonatomic, strong) UIView *backgroundView;

@end
