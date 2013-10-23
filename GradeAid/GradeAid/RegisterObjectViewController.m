//
//  AbstractRegisterViewViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterObjectViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "AttributeCell.h"
#import "Label.h"

@implementation RegisterObjectViewController
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UITableView *_tableView;
    
    IBOutlet Label *_titleLabel;
    
    IBOutlet Button *_cancelButton;
    IBOutlet Button *_saveButton;
    IBOutlet Button *_plusButton;
    
    ObjectVerifyer* _objectVerifyer;
}

#pragma - Constructor Methods

- (id) initWithObjectVerifyer:(ObjectVerifyer *)objectVerifyer
{
    if ((self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"RegisterObject"]))
    {
        _objectVerifyer = objectVerifyer;
        [_objectVerifyer setView: self];
        [self setModalPresentationStyle: UIModalPresentationFormSheet];

    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [_titleLabel setText: _objectVerifyer.createObjectTitle];
    [_imageView setImage: _objectVerifyer.defaultImage];
    [self updateButtons];
    [_tableView reloadData];
}

#pragma - Button Methods

- (IBAction) saveButtonPressed: (id) sender
{
    [_objectVerifyer saveObject];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) plusButtonPressed: (id) sender
{
    
}

- (IBAction) cancelButtonPressed: (id) sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma - ObjectVerifyer View Methods

- (void) objectVerifyerDidUpdate:(id)sender
{
    [self updateButtons];
}

#pragma - Private Methods

- (void) updateButtons
{
    [_plusButton setEnabled: _objectVerifyer.createMany && _objectVerifyer.isObjectVerified];
    [_saveButton setEnabled: _objectVerifyer.isObjectVerified];
}

#pragma - TableView Data Source Methods

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: AttributeCellIdentifier];

    [cell setAttributeVerifyer: [_objectVerifyer.attributeVerifyers objectAtIndex: indexPath.row]];
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objectVerifyer.attributeVerifyers.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.f;
}

#pragma - Getters and Setters

@synthesize objectVerifyer = _objectVerifyer;


@end
