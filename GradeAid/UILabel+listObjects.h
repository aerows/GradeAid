//
//  UILabel+listObjects.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (listObjects)

- (void) listObjects: (NSArray*) stringArray lineBreak: (bool) lineBreak;

@end
