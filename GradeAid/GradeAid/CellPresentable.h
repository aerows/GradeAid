//
//  CellPresentable.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellPresentable <NSObject>

- (NSString*) title;
- (UIImage*) thumbNail;

@end
