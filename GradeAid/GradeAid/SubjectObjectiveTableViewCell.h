//
//  SubjectObjectiveTableViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectObjective+Create.h"

static NSString *const SubjectObjectiveTableViewCellIdentifier = @"SubjectObjectiveTableViewCellIdentifier";

@interface SubjectObjectiveTableViewCell : UITableViewCell
{
    IBOutlet UILabel *_objetiveLabel;
}

@property (nonatomic, strong) SubjectObjective *objective;
@property (nonatomic, strong) NSString *title;

@end
