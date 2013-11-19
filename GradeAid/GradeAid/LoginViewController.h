//
//  LoginViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teacher+Create.h"

@interface LoginViewController : UIViewController

- (IBAction) login:(id)sender;

@property (nonatomic, strong) Teacher *teacher;


@end
