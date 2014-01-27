//
//  CourseEnrollmentSuiteViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseEnrollmentSuiteViewController.h"

// Global
#import "UIStoryboard+mainStoryboard.h"
#import "AppDelegate.h"
#import "Session.h"

@interface CourseEnrollmentSuiteViewController ()
{
    UIViewController *_currentViewController;
    bool didStartInCourseView;
}

@end

@implementation CourseEnrollmentSuiteViewController

- (id) initWithCourse:(Course *)course
{
    if (self = [self init])
    {
        _courseViewController.course = course;
        _courseViewController.courseDescription = course.courseEdition.courseDescription;
        _enrollmentViewController.course = course;
    }
    return self;
}

- (id) initWithCourseDescription:(CourseDescription *)courseDescription
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    Teacher *teacher = [Session currentSession].teacher;
    Course *course = [Course courseWithCourseDescription: courseDescription teacher: teacher managedObjectContext:moc];
    if (self = [self initWithCourse: course])
    {
        _courseViewController.inCreateMode = YES;
    }
    return self;
}

- (id) init
{
    if (self = [super init])
    {
        _courseViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CourseViewController"];
        _enrollmentViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"EnrollmentViewController"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    [_courseViewController.view setFrame: frame];
    
    [_courseViewController didMoveToParentViewController: self];
    [self.view addSubview: _courseViewController.view];
    didStartInCourseView = YES;
}


#pragma mark - Enrollment Was Selected Notification

- (void) enrollmentWasSelected: (NSNotification*) notification
{
    Enrollment *enrollment = notification.object;
    NSLog(@"Student %@ was selected", enrollment.student.title);
    [_enrollmentViewController setEnrollment: enrollment];
    
    [self toggleSelectViewController: _enrollmentViewController];
    
//    CGRect frame = self.view.frame;
//    frame.origin = CGPointZero;
//    [_enrollmentViewController.view setFrame: frame];
//    
//    [_courseViewController removeFromParentViewController];
//    [_courseViewController.view removeFromSuperview];
//    
//    [_enrollmentViewController didMoveToParentViewController: self];
//    [self.view addSubview: _enrollmentViewController.view];
}

- (void) toggleSelectViewController: (UIViewController*) viewController
{
    if ([_currentViewController isEqual: viewController]) return;
    
    UIViewController *previousViewController = _currentViewController;
    _currentViewController = viewController;
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    [_currentViewController.view setFrame: frame];
    
    [UIView transitionWithView:self.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                        [previousViewController.view removeFromSuperview];
                        [self.view addSubview: _currentViewController.view];
                        
                        [previousViewController removeFromParentViewController];
                        [_currentViewController didMoveToParentViewController: self];
                    }
                    completion:nil];
    
}

#pragma mark - Dismiss View Controller

- (void) dismissViewController: (NSNotification*) notification
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) enrollmentViewDone: (NSNotification*) notification
{
    if (didStartInCourseView)
    {
        [self toggleSelectViewController: _courseViewController];
    }
    else
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

#pragma mark - Notification Preparation Methods

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(enrollmentWasSelected:) name:EnrolllmentWasSelectedNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(dismissViewController:) name:WillDismissViewControllerNotifification object: _courseViewController];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(enrollmentViewDone:) name:WillDismissViewControllerNotifification object: _enrollmentViewController];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end
