//
//  StringFormatQriteraTests.m
//  StringFormatQriteraTests
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "StringFormatter.h"
#import "StringQriterium.h"


@interface StringFormatQriteraTests : SenTestCase

@end

@implementation StringFormatQriteraTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testNameFormatter
{
    StringFormatter *nf = [StringFormatter nameFormatter];
    NSString *formatted = [nf formatString: @"    bEngT     hALLberg    "];
    STAssertTrue([formatted isEqualToString: @"Bengt Hallberg"], [NSString stringWithFormat: @"Failed to format name: %@", formatted]);
    
    formatted = [nf formatString: @"lArs- gunnar -gÖran  "];
    STAssertTrue([formatted isEqualToString: @"Lars-Gunnar-Göran"], [NSString stringWithFormat: @"Failed to format hyphen: %@", formatted]);
}
- (void) testNotEmpty
{
    StringQriterium *qriterium = [StringQriterium notEmtpyQriterium];
    NSString *empty = @"";
    NSString *notEmtpy = @"Bengt";
    STAssertFalse([qriterium checkText: empty], @"Qriterium should return false on empty string.");
    STAssertTrue([qriterium checkText: notEmtpy], @"Qriterium should return true on non emtpy string.");
}

@end
