//
//  AbstractRegisterViewViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "ObjectVerifyer.h"
#import "CellPresentable.h"

@interface RegisterObjectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ObjectVerifyerView, UIPopoverControllerDelegate>
{
    UIPopoverController *_currentPopoverController;
}

@property (nonatomic, strong) NSArray *attributes;
@property (nonatomic, strong) NSArray *attributesSellectors;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet Button *cancelButton;
@property (nonatomic, weak) IBOutlet Button *saveButton;
@property (nonatomic, weak) IBOutlet Button *plusButton;

@property (nonatomic, strong) ObjectVerifyer *objectVerifyer;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
