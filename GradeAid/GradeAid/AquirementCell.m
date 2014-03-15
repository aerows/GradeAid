//
//  AquirementCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AquirementCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AquirementDescription+Create.h"
#import "Aquirement+Manage.h"
#import "AppDelegate.h"

static CGFloat const animationDuration = 1.6f;
static CGFloat const numberOfGradations = 3;

CGFloat const captionLabelWidth = 728;
CGFloat const captionTextViewWidth = 728;
CGFloat const gradeLabelHeight = 30.f;

NSInteger const textSize = 14;

#define SelectedEditColor    ([UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0])
#define SelectedNonEditColor ([UIColor grayColor])
#define NonselectedColor     ([UIColor grayColor])

@implementation AquirementCell
{
    IBOutlet UILabel *captionLabel;
    IBOutlet UITextView *captionTextView;
    IBOutlet UIView *labelContainer;
    IBOutletCollection(UILabel) NSArray *gradeLabels;
}

#pragma mark - Constructor Methods

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        _tapper = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(tapGesture:)];
        [_tapper setNumberOfTapsRequired: 1];
        [_tapper setNumberOfTouchesRequired: 1];
        [self.contentView addGestureRecognizer: _tapper];
        [self.contentView setUserInteractionEnabled: YES];
        
        _presser = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(pressGesture:)];
        [_presser setMinimumPressDuration: 0.8];
        [self.contentView addGestureRecognizer: _presser];
        
        [_tapper requireGestureRecognizerToFail: _presser];
    }
    return self;
}

#pragma mark - UIGestureRecognizer Delegate Methods

- (void) tapGesture: (UIGestureRecognizer*) tapper
{
    if (_editmode)
    {
        [self gesture: tapper];
    }
}

- (void) pressGesture: (UIGestureRecognizer*) presser
{
    if (presser.state == UIGestureRecognizerStateBegan)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName: AquirementCellDidEnableEditNotification object: nil];
        [self gesture: presser];
    }
}

- (void) gesture: (UIGestureRecognizer*) gesture
{
    CGPoint tapPoint = [gesture locationInView: self.contentView];
    CGFloat interval = self.contentView.frame.size.width / numberOfGradations;
    int tappedGrade = ceilf((tapPoint.x / interval));
    [self selectGrade: @(tappedGrade)];
}

- (void) selectGrade: (NSNumber*) grade
{
    bool deselectedGrade = [_aquirement.grade isEqualToNumber: grade];
    [_aquirement setGrade: (deselectedGrade) ? @(0) : grade managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    [self setGrade: _aquirement.grade];
}

#pragma mark - Private Methods

+ (CGSize) sizeForAquirement: (Aquirement*) aquirement
{
    static CGFloat marginCorrection = 20;
    CGSize constrainedSize = CGSizeMake(captionTextViewWidth, CGFLOAT_MAX);
    
    NSString *text = aquirement.aquirementDescription.longestCaption;
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize: textSize] constrainedToSize: constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
    size.height += marginCorrection;
    return size;
}

+ (CGFloat) heightForCellWithAquirement:(Aquirement *)aquirement
{
    return [AquirementCell sizeForAquirement: aquirement].height + gradeLabelHeight;
}

- (void) updateLabels
{
    for (UILabel *label in gradeLabels)
    {
        if (label.tag == _grade.intValue)
        {
            [label setFont: [UIFont boldSystemFontOfSize: [UIFont systemFontSize]]];
            
            [label setTextColor: [UIColor whiteColor]];
            [label setBackgroundColor: (_editmode) ? SelectedEditColor : SelectedNonEditColor];
            label.layer.cornerRadius = 13;
            label.layer.masksToBounds = YES;
        }
        else
        {
            [label setFont: [UIFont systemFontOfSize: [UIFont systemFontSize]]];
            [label setTextColor: NonselectedColor];
            [label setBackgroundColor: [UIColor clearColor]];
        }
    }
}

- (void) updateLayout
{
    [self performSelector:@selector(_updateLayout) withObject:nil afterDelay:0.0];
}

- (void) _updateLayout
{
    CGRect frame = captionTextView.frame;
    frame.size.height = [AquirementCell sizeForAquirement: _aquirement].height;
    [captionTextView setFrame: frame];
    
    CGRect labelFrame = labelContainer.frame;
    labelFrame.origin.y = CGRectGetMaxY(frame);
    [labelContainer setFrame: labelFrame];
    
    //[self updateBackground];
}

#pragma mark - Getters and Setters

- (void) setAquirement:(Aquirement *) aquirement
{
    if ([_aquirement isEqual: aquirement]) return;
    _aquirement = aquirement;
    [self setGrade: _aquirement.grade];
    [self updateLayout];
}

- (void) setGrade:(NSNumber *)grade
{
    _grade = grade;
    [captionTextView setAttributedText: [_aquirement attributedStringForCurrentGrade: _grade.intValue]];
    [self updateLabels];
    //[self updateBackground];
}

- (void) setEditmode:(bool)editmode
{
    _editmode = editmode;
    if (!_editmode) [self updateLabels];
}

@synthesize aquirement = _aquirement;
@synthesize grade = _grade;
@synthesize editmode = _editmode;
@synthesize enableEdit = _enableEdit;
@synthesize shadowed = _shadowed;

- (void) setShadowed:(bool)shadowed
{
    _shadowed = shadowed;
    if (_shadowed)
    {
        [self.contentView setBackgroundColor: [UIColor colorWithWhite:235.f/255.f alpha:1.0]];
        [captionTextView setAlpha: 0.8];
    }
    else
    {
        [self.contentView setBackgroundColor: [UIColor whiteColor]];
        [captionTextView setAlpha: 1.0];
    }
}

@end
