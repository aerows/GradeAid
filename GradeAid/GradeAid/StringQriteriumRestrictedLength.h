//
//  StringQriteriumNotEmpty.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringQriteriumProtocol.h"

@interface StringQriteriumRestrictedLength : NSObject <StringQriteriumProtocol>

- (id) initWithRange: (NSRange) range qriteriumCaption: (NSString*) caption;

@end

