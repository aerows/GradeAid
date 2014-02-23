//
//  TeacherAquirementEditCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirementDescriptionEditCell.h"
#import "AppDelegate.h"
#import "UIAlertView+MKBlockAdditions.h"

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

- (void) textFieldDidChange: (UITextField*) textField
{
    // Nop
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    if (!textField.text.length)
    {
        if (_teacherAquirementDescription.caption.length)
        {
            textField.text = _teacherAquirementDescription.caption;
        } else {
            [_textField resignFirstResponder];
            [self performSelector: @selector(deleteTeacherAquirement) withObject: nil afterDelay:0.01];
        }
        return YES;
    }
    _teacherAquirementDescription.caption = textField.text;
    [[AppDelegate sharedDelegate].managedObjectContext save: nil];

    return YES;
}

- (IBAction) delete: (UIButton*) button
{
    [_textField resignFirstResponder];
    [self performSelector: @selector(deleteTeacherAquirement) withObject: nil afterDelay:0.01];
}

- (void) deleteTeacherAquirement
{
    [TeacherAquirementDescription deleteTeacherAquirement: _teacherAquirementDescription];
}

#warning - Lägg in så att vid slut av editing, inte enter.
#warning - Ta bort gamla kriterier

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
