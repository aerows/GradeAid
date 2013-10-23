//
//  AquirementButton.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AquirementButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation AquirementButton
{
    UITapGestureRecognizer* _tapper;
    IBOutlet UIImageView* _backgroundView;
    IBOutlet UILabel* _titleLabel;
}

#pragma mark - Constructors

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
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapped)];
    [_tapper setNumberOfTapsRequired: 1];
    [_tapper setNumberOfTouchesRequired: 1];
    [self addGestureRecognizer: _tapper];
    
    if (!_backgroundView)
    {
        _backgroundView = [[UIImageView alloc] initWithFrame: (CGRect){CGPointZero, self.frame.size}];
        [self addSubview: _backgroundView];
    }

    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame: (CGRect){CGPointZero, self.frame.size}];
        [_titleLabel setLineBreakMode: NSLineBreakByWordWrapping];
        [self addSubview: _titleLabel];
    }

}

#pragma mark - Class Methods

//+ (CGFloat) heightOfAquirementButtonWithAquirementCaption:(NSString *)caption
//{
//    return 55;
//    CGFloat margin = 10;
//    int rows = [caption componentsSeparatedByString: AquirementGradeDelimiter].count;
//    return margin + 17.f * rows;
//}

#pragma mark - GestureRecognizer Delegate Method

- (void) tapped
{
    [_delegate aquirementButtonWasPressed: self];
}

#pragma mark - Getters and Setters

- (void) setTitle:(NSString *)title
{
    if ([_title isEqualToString: title]) return;
    _title = title;
    [_titleLabel setText: [_title stringByReplacingOccurrencesOfString: AquirementGradeDelimiter withString: @"/n"]];
}

- (void) setSelected:(bool)selected
{
    if (_selected == selected) return;
    _selected = selected;
    [_backgroundView setHighlighted: _selected];
    [_titleLabel setTextColor: (_selected) ? _textColor : [UIColor whiteColor]];
    
    //CGFloat height = (_selected) ? self.frame.size.height : 0;
    
    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setType: kCATransitionFade];
    [transitionAnimation setDuration:0.15f];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [transitionAnimation setFillMode:kCAFillModeRemoved];
    [_backgroundView.layer addAnimation:transitionAnimation forKey:@"buttonAnimation"];
    
//    CGRect frame = _backgroundView.frame;
//    frame.size.height = height;
//    [_backgroundView setFrame: frame];
    
}

- (void) setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    [_backgroundView setHighlightedImage: selectedImage];
}

- (void) setDefaultImage:(UIImage *)defaultImage
{
    _defaultImage = defaultImage;
    [_backgroundView setImage: defaultImage];
}

- (int) grade
{
    return self.tag;
}

@synthesize delegate = _delegate;
@synthesize selected = _selected;
@synthesize defaultImage = _defaultImage;
@synthesize selectedImage = _selectedImage;
@synthesize textColor = _textColor;
@synthesize grade = _grade;

@end
