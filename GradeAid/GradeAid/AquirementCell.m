//
//  AquirementCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

CGFloat const captionLabelWidth = 728;

#import "AquirementCell.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const animationDuration = 1.6f;

@implementation AquirementCell
{
    IBOutlet UILabel *captionLabel;
    IBOutletCollection(AquirementButton) NSArray* buttons;
}

#pragma mark - AquirementButton Delegate Methods

- (void) aquirementButtonWasPressed:(id)sender
{
    AquirementButton *button = (AquirementButton*) sender;
//    bool toggle = (_aquirementDescription.grade == button.grade);
//    _aquirementDescription.grade = (toggle) ? 0 : button.grade;
    

    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setType:kCATransitionFade];
    [transitionAnimation setDuration:0.3f];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transitionAnimation setFillMode:kCAFillModeBoth];
    [captionLabel.layer addAnimation:transitionAnimation forKey:@"fadeAnimation"];
//    captionLabel.attributedText = [_aquirementDescription attributedStringForCurrentGrade: _aquirementDescription.grade];
    
//    [self updateButtonsWithGrade: _aquirementDescription.grade];
}



#pragma mark - Private Methods

- (void) updateButtonsWithGrade: (int) grade
{
    for (AquirementButton *ab in buttons)
    {
        [ab setSelected: (ab.grade == grade)];
    }
}

+ (CGRect) rectForCaption: (NSString*) caption
{
    UIFont *font = [UIFont systemFontOfSize: 17];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]
                                          initWithString: caption
                                          attributes:@{NSFontAttributeName: font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){captionLabelWidth, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    rect = CGRectMake(23, 10, ceilf(rect.size.width), ceilf(rect.size.height));
    return rect;
    
}

//+ (CGFloat) heightForCellWithAquirement:(CourseAquirementDescription *) cad
//{
//    return 164;
//    CGRect labelFrame = [AquirementCell rectForCaption: cad.caption];
//    
//    return labelFrame.origin.y * 2 + labelFrame.size.height + 55;
//}

#pragma mark - Getters and Setters

//- (void) setAquirement:(CourseAquirementDescription *)courseAquirementDescription
//{
//    if ([_aquirementDescription isEqual: courseAquirementDescription]) return;
//    _aquirementDescription = courseAquirementDescription;
//    int grade = _aquirementDescription.grade;
//    [captionLabel setAttributedText: [_aquirementDescription attributedStringForCurrentGrade: grade]];
//    [self updateButtonsWithGrade: grade];
//}

@synthesize aquirement = _aquirementDescription;

@end
