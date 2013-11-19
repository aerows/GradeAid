//
//  TextTableViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-13.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "TextTableViewCell.h"

#define ExpandedTextColor   ([UIColor darkTextColor])
#define ContractedTextColor ([UIColor lightGrayColor])

static CGFloat const textLabelWidth = 508.f;
static NSInteger const textSize     = 14;
static CGFloat const headerMargin = 20.f;
static CGFloat const footerMargin = 25.f;

static NSInteger contractedTextLenght = 50;

static NSString *const hide = @"Dölj";
static NSString *const show = @"Visa";


@implementation TextTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
//        CGFloat height = ceilf([TextTableViewCell sizeForText:@"" expanded:NO].height);
//        CGRect frame = (CGRect) {{10,10},{textLabelWidth, height}};
//        _textLabel =[[UILabel alloc] initWithFrame: frame];
//        [_textLabel setFont: [UIFont systemFontOfSize: textSize]];
//        NSLog(NSStringFromCGRect(frame));
    }
    return  self;
}

#pragma mark - Class Methods

+ (CGSize) sizeForText:(NSString *)text expanded: (bool) expanded
{
    
    static CGFloat marginCorrection = 20;
    NSString *_text = (expanded) ? text : @"BBg?";
    CGSize constrainedSize = CGSizeMake(textLabelWidth, CGFLOAT_MAX);
    CGSize size = [_text sizeWithFont:[UIFont systemFontOfSize: textSize] constrainedToSize: constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
    size.height += marginCorrection;

    return size;
}

+ (CGFloat) heightForText:(NSString *)text expanded:(bool)expanded
{
    if (!expanded) return 52;
    
    CGFloat height = [TextTableViewCell sizeForText:text expanded:expanded].height;
    height += headerMargin;
    height += footerMargin;
    
    return height;
}

#pragma mark - Helper Methods

- (void) updateLabel
{
    CGRect frame = _textView.frame;
    frame.size.height = [TextTableViewCell sizeForText: _textView.text expanded: YES].height;
    [_textView setFrame: frame];
    
    if (_expanded)
    {
        frame = _expandLabel.frame;
        frame.origin.y = CGRectGetMaxY(_textView.frame);
        _expandLabel.frame = frame;
        [_expandLabel setText: hide];
    }
    else
    {
        CGPoint center = _expandLabel.center;
        center.y = _textView.center.y;
        _expandLabel.center = center;
        [_expandLabel setText: show];
    }
    
    [_textView setNeedsDisplay];
}

- (NSString*) contractText: (NSString*) text
{
    return [NSString stringWithFormat: @"%@...", [text substringToIndex: contractedTextLenght]];
}

#pragma mark - Getters and Setters

@synthesize expanded = _expanded;
@synthesize text = _text;
@synthesize title = _title;

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText: _title];
}

- (void) setText:(NSString *)text expanded:(bool)expanded
{
    _text = text;
    _expanded = expanded;
    _textView.text = (_expanded) ? _text : [self contractText: _text];
    _textView.textColor = (_expanded) ? ExpandedTextColor : ContractedTextColor;
    [self performSelector:@selector(updateLabel) withObject:nil afterDelay:0.0];
}



@end
