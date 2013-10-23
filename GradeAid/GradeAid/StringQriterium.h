//
//  StringQriterium.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringQriteriumProtocol.h"

@interface StringQriterium : NSObject<StringQriteriumProtocol>

+ (StringQriterium*) notEmtpyQriterium;
+ (StringQriterium*) restrictedCharactersQriterium: (NSCharacterSet*) characters;

@end
