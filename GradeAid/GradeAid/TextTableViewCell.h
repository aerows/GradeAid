//
//  TextTableViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-13.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const TextTableViewCellIdentifier = @"TextTableViewCellIdentifier";

@interface TextTableViewCell : UITableViewCell
{
    IBOutlet UITextView *_textView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_expandLabel;
}

@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, getter = isExpanded, readonly) bool expanded;

- (void) setText: (NSString*) text expanded: (bool) expanded;

+ (CGFloat) heightForText:(NSString *)text expanded: (bool) expanded;

@end
