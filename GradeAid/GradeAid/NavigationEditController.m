//
//  NavigationEditController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-28.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "NavigationEditController.h"

static NSString *const Edit     = @"Ändra";
static NSString *const Save     = @"Spara";
static NSString *const Cancel   = @"Avbryt";

@interface NavigationEditController ()
{
    UIBarButtonItem *editButton;
    UIBarButtonItem *saveButton;
    UIBarButtonItem *cancelButton;
}

@end

@implementation NavigationEditController

@synthesize barButtonItemStyle = _itemStyle;
@synthesize editMode = _editMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _itemStyle = UIBarButtonItemStylePlain;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    editButton = [[UIBarButtonItem alloc] initWithTitle: Edit   style: _itemStyle target: self action: @selector(edit)];
    saveButton = [[UIBarButtonItem alloc] initWithTitle: Save   style: _itemStyle target: self action: @selector(save)];
    editButton = [[UIBarButtonItem alloc] initWithTitle: Cancel style: _itemStyle target: self action: @selector(cancel)];

    
}
                  
- (void) edit
{
                      
}

- (void) save
{
    
}

- (void) cancel
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
