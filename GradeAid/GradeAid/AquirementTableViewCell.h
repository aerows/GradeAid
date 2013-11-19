//
//  AquirementTableViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AquirementDescription+Create.h"

static NSString *const AquirementTableViewCellIdentifier = @"AquirementTableViewCellIdentifier";

@interface AquirementTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    IBOutlet UITextView *textView;
    IBOutlet UIGestureRecognizer *tapRecognizer;
}

@property (nonatomic, strong) AquirementDescription *aquirementDescription;

@end
