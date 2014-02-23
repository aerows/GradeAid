//
//  StudentInfoViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-02-02.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+Create.h"

@interface StudentInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UIImageView *_imageView;
}

@property (nonatomic, strong) Student *student;
@property (nonatomic, strong) NSArray *enrollments;

@end
