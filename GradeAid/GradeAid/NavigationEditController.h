//
//  NavigationEditController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-28.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationEditController : UINavigationController
{
    bool _editMode;
    UIBarButtonItemStyle _itemStyle;
}

@property (nonatomic, getter = isInEditMode) bool editMode;
@property (nonatomic) UIBarButtonItemStyle barButtonItemStyle;
@end
