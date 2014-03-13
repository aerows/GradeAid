//
//  GraidAidCollectionViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-28.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "GraidAidCollectionViewCell.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@implementation GraidAidCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    return self;
}

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
    _deleteIconTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(deleteIconTapped:)];
    [_tapRecognizer setNumberOfTapsRequired: 1];
    [_tapRecognizer setNumberOfTouchesRequired: 1];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(cellTapped:)];
    [_tapRecognizer setNumberOfTapsRequired: 1];
    [_tapRecognizer setNumberOfTouchesRequired: 1];
    
    _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget: self action:@selector(cellLongPressed:)];
    [_longPressRecognizer setMinimumPressDuration: 1.0f];
    
    [_tapRecognizer requireGestureRecognizerToFail: _longPressRecognizer];
    [_tapRecognizer requireGestureRecognizerToFail: _deleteIconTapRecognizer];
    
    [self.contentView addGestureRecognizer: _tapRecognizer];
    [self.contentView addGestureRecognizer: _longPressRecognizer];
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

#pragma mark - Wobble Methods

- (void) startWobble
{
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5.0));
    
    _imageView.transform = leftWobble;  // starting point
    
    [UIView beginAnimations:@"wobble" context:(__bridge void *)(_imageView)];
    [UIView setAnimationRepeatAutoreverses:YES]; // important
    [UIView setAnimationRepeatCount: FLT_MAX];
    [UIView setAnimationDuration:0.10];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(wobbleEnded:finished:context:)];
    
    _imageView.transform = rightWobble; // end here & auto-reverse
    
    [UIView commitAnimations];
}

- (void) wobbleEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([finished boolValue])
    {
        _imageView.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - Getters and Setters

- (void) setShowDeleteiconView:(bool)showDeleteiconView
{
    [_deleteiconView setHidden: !_editMode];
    
    if (YES && _editMode)
    {
        [self setUserInteractionEnabled: YES];
        [_deleteiconView setUserInteractionEnabled: YES];
        [_deleteiconView addGestureRecognizer: _deleteIconTapRecognizer];
    }
    else
    {
        [_deleteiconView removeGestureRecognizer: _deleteIconTapRecognizer];
    }
}

#pragma mark - GestureRecognizer Methods

- (void) deleteIconTapped: (UITapGestureRecognizer*) tapper
{
    _deleteiconPressedBlock(self);
}

- (void) cellLongPressed: (UILongPressGestureRecognizer*) longPressRecognizer
{
   if (longPressRecognizer.state == UIGestureRecognizerStateBegan)
   {
        _cellLongPressedBlock(self, _editMode);
   }
}

- (void) cellTapped: (UITapGestureRecognizer*) tapRecognizer
{
    _cellTappedBlock(self, _editMode);
}


- (void) setWobble:(bool) wobble
{
    if (wobble) {
        [self startWobble];
    } else {
        [self wobbleEnded: @"" finished: @YES context: nil];
    }
}

// Model

// View
@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;
@synthesize deleteiconView = _deleteiconView;

// Controller
- (void) setEditMode:(BOOL)editMode
{
    if (_editMode == editMode) return;
    _editMode = editMode;
    [self setWobble: _editMode];
    [self setShowDeleteiconView: _editMode];
}

@synthesize editMode = _editMode;

@synthesize cellLongPressedBlock = _cellLongPressedBlock;
@synthesize cellTappedBlock = _cellTappedBlock;
@synthesize deleteiconPressedBlock = _deleteiconPressedBlock;

@end
