//
//  Creatable.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectVerifyer.h"

@protocol Creatable <NSObject>

+ (ObjectVerifyer*) objectVerifyer;

@end
