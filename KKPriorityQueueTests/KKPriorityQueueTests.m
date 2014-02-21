//
//  KKPriorityQueueTests.m
//  KKPriorityQueueTests
//
//  Created by Karol Kozub on 17/02/14.
//  Copyright (c) 2014 Karol Kozub. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KKPriorityQueue.h"

@interface KKPriorityQueueTests : XCTestCase

@property (nonatomic, strong) KKPriorityQueue *queue;
@property (nonatomic, strong, readonly) NSArray *queueArrayValue;

@end

@implementation KKPriorityQueueTests
@dynamic queueArrayValue;

- (void)setUp {
  self.queue = [KKPriorityQueue minQueue];
}

- (void)testEmptyQueue {
  XCTAssertTrue([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)0, [self.queue count]);
  XCTAssertNil([self.queue topObject]);
  XCTAssertNil([self.queue popObject]);
}

- (void)testQueueWithOneObject {
  [self.queue addObject:@1];
  
  XCTAssertFalse([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)1, [self.queue count]);
  XCTAssertEqual(@1, [self.queue topObject]);
  XCTAssertEqual(@1, [self.queue popObject]);
}

- (void)testCountWhenAddingObjects {
  XCTAssertTrue([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)0, [self.queue count]);
  
  [self.queue addObject:@1];
  
  XCTAssertFalse([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)1, [self.queue count]);
  
  [self.queue addObject:@2];
  
  XCTAssertFalse([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)2, [self.queue count]);
}

- (void)testCountWhenRemovingObjectsWithPopObject {
  [self.queue addObjectsFromArray:@[@1, @2]];
  
  XCTAssertFalse([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)2, [self.queue count]);
  
  [self.queue popObject];

  XCTAssertFalse([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)1, [self.queue count]);
  
  [self.queue popObject];
  
  XCTAssertTrue([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)0, [self.queue count]);

  [self.queue popObject];
  
  XCTAssertTrue([self.queue isEmpty]);
  XCTAssertEqual((NSUInteger)0, [self.queue count]);
}

- (void)testIfObjectsAppearInCorrectOrderFromMinQueue {
  self.queue = [KKPriorityQueue minQueue];
  [self.queue addObjectsFromArray:@[@11, @2, @33, @4, @55]];
  
  XCTAssertEqualObjects(@2, [self.queue topObject]);
  XCTAssertEqualObjects(@2, [self.queue popObject]);
  
  XCTAssertEqualObjects(@4, [self.queue topObject]);
  XCTAssertEqualObjects(@4, [self.queue popObject]);
  
  XCTAssertEqualObjects(@11, [self.queue topObject]);
  XCTAssertEqualObjects(@11, [self.queue popObject]);
  
  XCTAssertEqualObjects(@33, [self.queue topObject]);
  XCTAssertEqualObjects(@33, [self.queue popObject]);
  
  XCTAssertEqualObjects(@55, [self.queue topObject]);
  XCTAssertEqualObjects(@55, [self.queue popObject]);
  
  XCTAssertNil([self.queue topObject]);
  XCTAssertNil([self.queue popObject]);
}

- (void)testIfObjectsAppearInCorrectOrderFromMaxQueue {
  self.queue = [KKPriorityQueue maxQueue];
  [self.queue addObjectsFromArray:@[@11, @2, @33, @4, @55]];
  
  XCTAssertEqualObjects(@55, [self.queue topObject]);
  XCTAssertEqualObjects(@55, [self.queue popObject]);
  
  XCTAssertEqualObjects(@33, [self.queue topObject]);
  XCTAssertEqualObjects(@33, [self.queue popObject]);
  
  XCTAssertEqualObjects(@11, [self.queue topObject]);
  XCTAssertEqualObjects(@11, [self.queue popObject]);
  
  XCTAssertEqualObjects(@4, [self.queue topObject]);
  XCTAssertEqualObjects(@4, [self.queue popObject]);
  
  XCTAssertEqualObjects(@2, [self.queue topObject]);
  XCTAssertEqualObjects(@2, [self.queue popObject]);
  
  XCTAssertNil([self.queue topObject]);
  XCTAssertNil([self.queue popObject]);
}

- (void)testIfObjectsAppearInCorrectOrderFromQueueWithCustomComparator {
  self.queue = [KKPriorityQueue queueWithComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
    return [@([str1 length]) compare:@([str2 length])];
  } ascending:YES];
  [self.queue addObjectsFromArray:@[@"test", @"1", @"qwerty", @"as", @"zxc"]];
  
  XCTAssertEqualObjects(@"1", [self.queue topObject]);
  XCTAssertEqualObjects(@"1", [self.queue popObject]);
  
  XCTAssertEqualObjects(@"as", [self.queue topObject]);
  XCTAssertEqualObjects(@"as", [self.queue popObject]);
  
  XCTAssertEqualObjects(@"zxc", [self.queue topObject]);
  XCTAssertEqualObjects(@"zxc", [self.queue popObject]);
  
  XCTAssertEqualObjects(@"test", [self.queue topObject]);
  XCTAssertEqualObjects(@"test", [self.queue popObject]);
  
  XCTAssertEqualObjects(@"qwerty", [self.queue topObject]);
  XCTAssertEqualObjects(@"qwerty", [self.queue popObject]);
  
  XCTAssertNil([self.queue topObject]);
  XCTAssertNil([self.queue popObject]);
}

- (void)testCopying {
  NSArray *objects = @[@1, @2, @3, @4, @5, @10, @20, @30];
  
  [self.queue addObjectsFromArray:objects];
  
  KKPriorityQueue *copy = [self.queue copy];
  
  XCTAssertEqual([objects count], [self.queue count]);
  XCTAssertEqual([objects count], [copy count]);
  
  for (NSInteger i = 0; i < [objects count]; i++) {
    XCTAssertEqual(objects[i], [self.queue popObject]);
    XCTAssertEqual(objects[i], [copy popObject]);
  }
}

- (void)testRemovingObjectsWithRemoveObject {
  [self.queue addObjectsFromArray:@[@7, @2, @6, @4, @5, @1, @3, @8]];

  [self.queue removeObject:@4];
  [self.queue removeObject:@2];
  [self.queue removeObject:@6];
  
  XCTAssertEqualObjects((@[@1, @3, @5, @7, @8]), self.queueArrayValue);
}

- (void)testRemovingObjectsWithRemoveObjectsFromArray {
  [self.queue addObjectsFromArray:@[@7, @2, @6, @4, @5, @1, @3, @8]];

  [self.queue removeObjectsFromArray:@[@4, @5, @1, @8]];
  
  XCTAssertEqualObjects((@[@2, @3, @6, @7]), self.queueArrayValue);
}

#pragma mark -

- (NSArray *)queueArrayValue {
  NSMutableArray *array = [NSMutableArray array];
  KKPriorityQueue *queueCopy = [self.queue copy];
  
  while (![queueCopy isEmpty]) {
    [array addObject:[queueCopy popObject]];
  }
  
  return [array copy];
}


@end
