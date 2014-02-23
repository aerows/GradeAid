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
#import "SchoolCollectionViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "AppDelegate.h"
#import "Session.h"

static NSString *const SegueIdentifierLogin = @"SegueIdentifierLogin";

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
    
    [loginField setPlaceholder: @"Lärare epost"];
    [passwordField setPlaceholder: @"Lösenord"];
//    [loginField setText: @"hallin.daniel@gmail.com"];
//    [passwordField setText: @"password"];
}

- (void) viewWillAppear:(BOOL)animated
{
    Teacher *teacher = [Session currentSession].teacher;

    if (teacher)
    {
        [loginField setText: teacher.email];
        [passwordField setText: teacher.password];
    }
    else
    {
        [loginField setText: [self getLastEmail]];
    }
    
//    [loginField setText: @"hallin.daniel@gmail.com"];
//    [passwordField setText: @"password"];
}


- (IBAction)login:(id)sender
{
    if ([[Session currentSession] loginWithEmail: loginField.text password: passwordField.text])
    {
        UIViewController *tbc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"RootViewController"];
        tbc.modalPresentationStyle = UIModalPresentationFullScreen;
        tbc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController: tbc animated: YES completion: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(logout:) name: TeacherWillLogOutNotification object: [Session currentSession].teacher];
        [self setLastEmail: loginField.text];
        passwordField.text = @"";
    }
}

- (void) logout: (NSNotification*) notifcation
{
    [self dismissViewControllerAnimated: YES completion:^{
        [[Session currentSession] logout];
    }];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (IBAction)loginForSettingsView:(id)sender
{
    [[Session currentSession] loginWithEmail: loginField.text password: passwordField.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Save last email methods

static NSString *const KeyForLastEmail = @"KeyForLastEmail";

- (void) setLastEmail: (NSString*) lastEmail
{
    [[NSUserDefaults standardUserDefaults] setObject: lastEmail forKey:KeyForLastEmail];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*) getLastEmail
{
    NSString *lastEmail = [[NSUserDefaults standardUserDefaults] objectForKey: KeyForLastEmail];
    return (lastEmail) ? lastEmail : @"";
}

#pragma mark - Getters and Setters
@synthesize teacher = _teacher;


@end
