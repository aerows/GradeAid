//
//  LoginViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "LoginViewController.h"
#import "TextField.h"
#import "Button.h"
#import "HomeViewController.h"
#import "UIStoryboard+mainStoryboard.h"

@interface LoginViewController ()
{
    IBOutlet TextField *loginField;
    IBOutlet TextField *passwordField;
    IBOutlet Button *loginButton;
    IBOutlet Button *registerButton;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor clearColor]];
    //[self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
    
    [passwordField setSecureTextEntry: YES];
    [loginButton addTarget: self action: @selector(login) forControlEvents: UIControlEventTouchUpInside];
    
    [loginField setText: @"Rickard Samuelsson"];
    [passwordField setText: @"password"];
}

- (void) login
{
    HomeViewController *hvc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [self.navigationController pushViewController: hvc animated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
