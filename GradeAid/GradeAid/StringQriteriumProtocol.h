//
//  StringQriteriumProtocol.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StringQriteriumProtocol <NSObject>

- (bool) checkText: (NSString*) text;
- (NSString*) qriterium;

@end
