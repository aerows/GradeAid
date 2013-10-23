//
//  AttributeCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-04.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"
#import "AttributeVerifyer.h"

static NSString *AttributeCellIdentifier = @"AttributeCellIdentifier";

@interface AttributeCell : UITableViewCell<AttributeVerifyerView>

@property (weak, nonatomic) IBOutlet TextField *textField;
@property (nonatomic, strong) AttributeVerifyer *attributeVerifyer;

@end
