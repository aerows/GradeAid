//
//  TeacherAquirementEditCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirementDescriptionEditCell.h"
#import "AppDelegate.h"

@implementation TeacherAquirementDescriptionEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected: NO animated:animated];
    if (selected)
    {
        [_textField becomeFirstResponder];
    }
}

#pragma mark - TextField Delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString: @""])
    {
        [[AppDelegate sharedDelegate].managedObjectContext delete: _teacherAquirementDescription];
        [[AppDelegate sharedDelegate].managedObjectContext save: nil];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidChange: (UITextField*) textField
{
    if (_teacherAquirementDescription)
    {
        _teacherAquirementDescription.caption = textField.text;
        [[AppDelegate sharedDelegate].managedObjectContext save: nil];
    }
}

#pragma mark - Setters and Getters

@synthesize textField = _textField;

- (void) setTextField:(UITextField *)textField
{
    [_textField removeTarget: nil action: nil forControlEvents: UIControlEventAllEditingEvents];
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_textField setDelegate: self];
}

@synthesize teacherAquirementDescription = _teacherAquirementDescription;

- (void) setTeacherAquirementDescription:(TeacherAquirementDescription *)teacherAquirementDescription
{
    [self setTextField: _textField];
    
    _teacherAquirementDescription = nil;
    [_textField setText: teacherAquirementDescription.caption];
    _teacherAquirementDescription = teacherAquirementDescription;
}

@end
