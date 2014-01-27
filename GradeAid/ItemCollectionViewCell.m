//
//  ItemCollectionViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "ItemCollectionViewCell.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@implementation ItemCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];

//    if (selected)
//    {
//        [self.contentView setBackgroundColor: colorTintedBlue];
//    }
//    else
//    {
//        [self.contentView setBackgroundColor: [UIColor clearColor]];
//    }
}

- (void) startWobble
{
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5.0));
    
    _imageView.transform = leftWobble;  // starting point
    
    [UIView beginAnimations:@"wobble" context:(__bridge void *)(_imageView)];
    [UIView setAnimationRepeatAutoreverses:YES]; // important
    [UIView setAnimationRepeatCount: FLT_MAX];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(wobbleEnded:finished:context:)];
    
    _imageView.transform = rightWobble; // end here & auto-reverse
    
    [UIView commitAnimations];
}

- (void) wobbleEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([finished boolValue]) {
        _imageView.transform = CGAffineTransformIdentity;
    }
}



#pragma mark - Getters and Setters

- (void) setShowDeleteView:(bool)showDeleteView
{
    _showDeleteView = showDeleteView;
    [_removeIconView setHidden: !_showDeleteView];
    
    if (_showDeleteView)
    {
        [self setUserInteractionEnabled: YES];
        [_imageView setUserInteractionEnabled: YES];
        _tapper = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(deleteIconTapped:)];
        [_tapper setNumberOfTapsRequired: 1];
        [_tapper setNumberOfTouchesRequired: 1];
        [_removeIconView addGestureRecognizer: _tapper];
    }
    else
    {
        [_removeIconView removeGestureRecognizer: _tapper];
    }
}

- (void) deleteIconTapped: (UITapGestureRecognizer*) tapper
{
    _deleteObjectBlock(self);
}

- (void) setWobble:(bool)wobble
{
    if (wobble == _wobble) return;
    _wobble = wobble;
    if (_wobble)
    {
        [self startWobble];
    }
    else
    {
        [self wobbleEnded: @"" finished: @YES context: nil];
    }
}

@synthesize imageView = _imageView;
@synthesize label = _label;
@synthesize wobble = _wobble;
@synthesize removeIconView = _removeIconView;
@synthesize tapper = _tapper;


@end
