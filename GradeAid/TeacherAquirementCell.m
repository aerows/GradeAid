//
//  TeacherAquirementCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirementCell.h"
#import "AppDelegate.h"
static NSInteger const numberOfGradations = 3;

#define SelectedColor       ([UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0])
#define NonselectedColor    ([UIColor grayColor])

@implementation TeacherAquirementCell
{
    IBOutlet UITextView *captionTextView;
    IBOutlet UIView *labelContainer;
    IBOutletCollection(UILabel) NSArray *gradeLabels;
}

#pragma mark - Constructor Methods

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(tapGesture:)];
    [_tapper setNumberOfTapsRequired: 1];
    [_tapper setNumberOfTouchesRequired: 1];
    [self.contentView addGestureRecognizer: _tapper];
    [self.contentView setUserInteractionEnabled: YES];
}

#pragma mark - UIGestureRecognizer Delegate Methods

- (void) tapGesture: (UIGestureRecognizer*) tapper
{
    CGPoint tapPoint = [tapper locationInView: self.contentView];
    CGFloat interval = self.contentView.frame.size.width / numberOfGradations;
    int tappedGrade = floorf((tapPoint.x / interval));
    [self selectGrade: @(tappedGrade)];
}

- (void) selectGrade: (NSNumber*) grade
{
    [_teacherAquirement setGrade: grade managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    [self updateLabels];
}

#pragma mark - Private Methods

- (void) updateLabels
{
    for (UILabel *label in gradeLabels)
    {
        if (label.tag == _teacherAquirement.grade.intValue)
        {
            [label setTextColor: SelectedColor];
        }
        else
        {
            [label setTextColor: NonselectedColor];
        }
    }
}

- (UIColor*) colorForIndex: (NSInteger) index
{
    switch (index) {
        case 0:  return SelectedColor;
        case 1:  return [UIColor yellowColor];
        case 2:  return [UIColor greenColor];
        default: return NonselectedColor;
    }
}

- (void) updateLayout
{
//    CGRect frame = captionTextView.frame;
//    frame.size.height = [AquirementCell sizeForAquirement: _aquirement].height;
//    [captionTextView setFrame: frame];
//    
//    CGRect labelFrame = labelContainer.frame;
//    labelFrame.origin.y = CGRectGetMaxY(frame);
//    [labelContainer setFrame: labelFrame];
}

#pragma mark - Getters and Setters

- (void) setTeacherAquirement:(TeacherAquirement *)teacherAquirement
{
    if ([_teacherAquirement isEqual: teacherAquirement]) return;
    _teacherAquirement = teacherAquirement;
    [captionTextView setText: _teacherAquirement.teacherAquirementDescription.caption];
    [self updateLabels];
    //[self performSelector:@selector(updateLayout) withObject:nil afterDelay:0.0];
}

@synthesize teacherAquirement = _teacherAquirement;

@end

