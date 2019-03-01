//
//  PlaygroundTests.m
//  PlaygroundTests
//
//  Created by Tom Belov on 01/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface PlaygroundTests : XCTestCase
@property (nonatomic, strong) ViewController *vc;
@end

@implementation PlaygroundTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual([self.vc getFive], 5);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
