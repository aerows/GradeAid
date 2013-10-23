//
//  AquirementButton.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const AquirementGradeDelimiter = @"//";

@protocol AquirementButtonDelegate <NSObject>

- (void) aquirementButtonWasPressed: (id) sender;

@end

@interface AquirementButton : UIView

@property (nonatomic, strong) IBOutlet id<AquirementButtonDelegate> delegate;
@property (nonatomic) int grade;

@property (nonatomic, getter = isSelected) bool selected;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIColor *textColor;

//+ (CGFloat) heightOfAquirementButtonWithAquirementCaption: (NSString*) caption;

@end
