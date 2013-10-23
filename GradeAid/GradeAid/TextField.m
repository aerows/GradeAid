//
//  TextField.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "TextField.h"

@implementation TextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end


/*

Lägg in funktioner för att kolla textinnehållet mot ett visst kriterium,
 Matcha regex, matcha annat textField, ev. kolla om email är upptagen. 
 
 Länka med att presentera information och varningar om detta inte uppfylls.
 Använd strategi designen.


*/