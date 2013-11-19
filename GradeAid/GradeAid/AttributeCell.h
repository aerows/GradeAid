//
//  RegisterCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributeInput.h"

static NSString *const AttributeCellIdentifier = @"AttributeCellIdentifier";

@interface AttributeCell : UITableViewCell<AttributeInputView>
{
    IBOutlet UITextField *_textField;
    IBOutlet UIImageView *_imageView;
    IBOutlet UILabel     *_attributeTitleLabel;
}

@property (nonatomic, strong) AttributeInput *attributeInput;

@end
