//
//  BTViewControllerTests.m
//  GitDemo
//
//  Created by Lakhpat on 03/05/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTViewController+test.h"

@interface BTViewControllerTests : XCTestCase

@property (nonatomic) BTViewController *testClass;

@end

@implementation BTViewControllerTests

- (void)setUp
{
    [super setUp];
    self.testClass = [[BTViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckNumber
{
    int original = 10;
    int expected = [self.testClass getNumber];
    XCTAssertEqual(original, expected, @"not equal");
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
