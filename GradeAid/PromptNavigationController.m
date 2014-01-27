//
//  PromptNavigationController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-11.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptNavigationController.h"
#import "UIStoryboard+mainStoryboard.h"

@interface PromptNavigationController ()
{
    CGRect navigationGoalFrame;
}

@end

@implementation PromptNavigationController

- (id) init
{
    if ((self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"PromptNavigationController"]))
    {
        _navigationControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        [self setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self setModalPresentationStyle: UIModalPresentationFullScreen];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self setUpBackgroundView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self animateNavControllers];
}

- (void) setUpBackgroundView
{
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismissPrompt)];
    [_backgroundView addGestureRecognizer: tapper];
    self.view.opaque = NO;
    self.backgroundView.opaque = NO;
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
}

- (void) animateNavControllers
{
    for (int i = 0; i < _navigationControllers.count; i++)
    {
        UINavigationController *nav = [_navigationControllers objectAtIndex: i];
        nav.view.frame = [self startFrameForPromptAtIndex: i];
    }
    
    [UIView animateWithDuration: 0.4 animations:^{
        for (int i = 0; i < _navigationControllers.count; i++)
        {
            UINavigationController *nav = [_navigationControllers objectAtIndex: i];
            nav.view.frame = [self goalFrameForPromptAtIndex: i];
            NSLog(@"%@", NSStringFromCGRect(nav.view.frame));
        }
    }];
}

static CGRect const currentPromptFrame = (CGRect){194, 144, 380, 300};
static CGPoint const frameOffsetMargin   = (CGPoint){30,30};

- (CGRect) startFrameForPromptAtIndex: (NSInteger) index
{
    if (index == 0)
    {
        CGPoint offset = CGPointMake(currentPromptFrame.origin.x, self.view.frame.size.height);
        return (CGRect){offset, currentPromptFrame.size};
    }
    return [self goalFrameForPromptAtIndex: index - 1];
}

- (CGRect) goalFrameForPromptAtIndex: (NSInteger) index
{
    CGPoint offset = CGPointMake(currentPromptFrame.origin.x + index * frameOffsetMargin.x,
                                 currentPromptFrame.origin.y + index * frameOffsetMargin.y);
    
    return (CGRect){offset, currentPromptFrame.size};
}

- (void) dismissPrompt
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) setNavigationControllers:(NSArray *)navigationControllers
{
    [_navigationControllers setArray: navigationControllers];
}

- (void) pushNavigationController:(UINavigationController *)navigationController animated: (bool) animated
{
    [_navigationControllers insertObject: navigationController atIndex:0];
    [self.view addSubview: navigationController.view];
    [navigationController didMoveToParentViewController: self];
}

#pragma mark - PromptEnviorment Methods

- (void) pushPromptViewController: (PromptViewController*) promptViewController animated: (bool) animated
{
    UINavigationController *nav = [[UINavigationController alloc] init];
    
    nav.view.layer.cornerRadius = 10.0f;
    nav.view.layer.masksToBounds = YES;
    
    PromptViewController *promptRoot = promptViewController;
    while (promptRoot.previousPromptViewController)
    {
        promptRoot = promptRoot.previousPromptViewController;
    }
    
    PromptViewController *nextPrompt = promptRoot;
    while (nextPrompt)
    {
        [nextPrompt setEnviorment: self];
        nextPrompt = nextPrompt.nextPromptViewController;
        
    }
    
    nextPrompt = promptRoot;
    [nav pushViewController: nextPrompt animated: NO];
    while (nextPrompt.object)
    {
        
        nextPrompt = nextPrompt.nextPromptViewController;
        
        [nav pushViewController: nextPrompt animated: NO];
    }
    
    [self pushNavigationController: nav animated: NO];
    [self animateNavControllers];
}

- (void) dismissPromptViewController:(id)promptViewController animated:(bool)animated
{
    [self dismissViewControllerAnimated: YES completion: nil];
}



@synthesize navigationControllers = _navigationControllers;
@synthesize backgroundView = _backgroundView;

@end
