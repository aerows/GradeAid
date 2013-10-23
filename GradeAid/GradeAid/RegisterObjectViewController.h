//
//  AbstractRegisterViewViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "ObjectVerifyer.h"

@interface RegisterObjectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ObjectVerifyerView>

@property (nonatomic, strong) ObjectVerifyer* objectVerifyer;

- (id) initWithObjectVerifyer: (ObjectVerifyer*) objectVerifyer;


@end
