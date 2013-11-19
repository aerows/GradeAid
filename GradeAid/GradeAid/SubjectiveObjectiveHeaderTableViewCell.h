//
//  SubjectiveObjectiveHeaderTableViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const SubjectiveObjectiveHeaderTableViewCellIdentifier = @"SubjectiveObjectiveHeaderTableViewCellIdentifier";

@interface SubjectiveObjectiveHeaderTableViewCell : UITableViewCell
{
    IBOutlet UILabel *_headerLabel;
}

@property (nonatomic, strong) NSString *title;

@end
