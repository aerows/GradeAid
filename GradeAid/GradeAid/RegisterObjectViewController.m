//
//  AbstractRegisterViewViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterObjectViewController.h"
#import "Label.h"
#import "AttributeCell.h"
#import "SellectionCell.h"
#import "SellectionViewController.h"
#import "SellectionVerifyer.h"

#import "UIStoryboard+mainStoryboard.h"
#import "AppDelegate.h"

static NSInteger const AttributeInputSection  = 0;
static NSInteger const AttributeSelectSection = 1;

@implementation RegisterObjectViewController
{

}

#pragma - Constructor Methods

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self updateButtons];
    [_tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [_titleLabel setText: self.title];
}

#pragma - Button Methods

- (IBAction) saveButtonPressed: (id) sender
{
    if (![_objectVerifyer isVerified]) return;
    
    [_objectVerifyer createInManagedObjectContext: _managedObjectContext];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) plusButtonPressed: (id) sender
{
    if (![_objectVerifyer isVerified]) return;

}

- (IBAction) cancelButtonPressed: (id) sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma - ObjectVerifyer View Methods

- (void) updateView
{
    [self updateButtons];
}

#pragma - Private Methods

- (void) updateButtons
{
    [_plusButton setEnabled: _objectVerifyer.isVerified];
    [_saveButton setEnabled: _objectVerifyer.isVerified];
}

#pragma - TableView Data Source Methods

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case AttributeInputSection:
        {
            AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: AttributeCellIdentifier];
            NSString *key = [_objectVerifyer.orderedAttributeKeys objectAtIndex: indexPath.row];
            [cell setAttributeInput: [_objectVerifyer.attributeInputs objectForKey: key]];
            
            return cell;
        }
        case AttributeSelectSection:
        {
            SellectionCell *cell = [tableView dequeueReusableCellWithIdentifier: SellectionCellIdentifier];
            NSString *key = [_objectVerifyer.orderedSelectorKeys objectAtIndex: indexPath.row];
            [cell setSellectionVerifyer: [_objectVerifyer.attributeSellectionInputs objectForKey: key]];
            return cell;
        }
    }
    NSLog(@"IndexPath section out of range.");
    return nil;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case AttributeInputSection:  return _objectVerifyer.orderedAttributeKeys.count;
        case AttributeSelectSection: return _objectVerifyer.orderedSelectorKeys.count;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case AttributeInputSection:  return 55.f;
        case AttributeSelectSection: return 43.f;
    }
    return 0;
}

#pragma - TableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == AttributeSelectSection)
    {
        NSString *keyForSelectionVerifyer = [_objectVerifyer.orderedSelectorKeys objectAtIndex: indexPath.row];
        
        SellectionVerifyer *sellectionVerifyer = [_objectVerifyer.attributeSellectionInputs objectForKey: keyForSelectionVerifyer];
        
        SellectionViewController *svc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"SellectionViewController"];

        CGSize svcSize = [svc sizeForNumberOfObjects: sellectionVerifyer.objects.count];
        svc.view.frame = (CGRect){CGPointZero, svcSize};
        
        [svc setSellectionVerifyer: sellectionVerifyer];

        CGRect frame = CGRectOffset([tableView rectForRowAtIndexPath: indexPath], tableView.frame.origin.x, tableView.frame.origin.y);

        _currentPopoverController = [[UIPopoverController alloc] initWithContentViewController:svc];
        _currentPopoverController.delegate = self;
        _currentPopoverController.popoverContentSize = svcSize;
        [_currentPopoverController presentPopoverFromRect: frame inView:self.view permittedArrowDirections: UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - PopoverController Delegate Methods

#pragma - Getters and Setters

@synthesize objectVerifyer = _objectVerifyer;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize tableView = _tableView;
@synthesize titleLabel = _titleLabel;
@synthesize cancelButton = _cancelButton;
@synthesize saveButton = _saveButton;
@synthesize plusButton = _plusButton;

- (void) setObjectVerifyer:(ObjectVerifyer *)objectVerifyer
{
    _objectVerifyer = objectVerifyer;
    [_objectVerifyer setView: self];
}


@end
