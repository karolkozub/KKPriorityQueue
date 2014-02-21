//
//  main.m
//  KKPriorityQueueBenchmarks
//
//  Created by Karol Kozub on 21/02/14.
//  Copyright (c) 2014 Karol Kozub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKPriorityQueue.h"

void benchmarkAddingObjects();
void benchmarkPoppingObjects();

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    benchmarkAddingObjects();
    benchmarkPoppingObjects();
  }
  
  return 0;
}

void benchmarkAddingObjects() {
  KKPriorityQueue *queue = [KKPriorityQueue minQueue];
  NSMutableArray *numbers = [NSMutableArray array];
  const NSInteger numberOfNumbers = 1000000;
  
  // objects should be sorted
  for (NSInteger i = numberOfNumbers - 1; i >= 0; i--) {
    [numbers addObject:@(i)];
  }
  
  printf("Adding %d numbers in reverse order: ", (int)numberOfNumbers);
  fflush(stdout);
  
  NSDate *startDate = [NSDate date];
  
  for (NSNumber *number in numbers) {
    [queue addObject:number];
  }
  
  NSDate *endDate = [NSDate date];
  
  printf("%0.3f seconds\n", [endDate timeIntervalSinceDate:startDate]);
}

void benchmarkPoppingObjects() {
  KKPriorityQueue *queue = [KKPriorityQueue minQueue];
  const NSInteger numberOfNumbers = 1000000;
  
  // objects should be sorted
  for (NSInteger i = 0; i < numberOfNumbers; i++) {
    [queue addObject:@(i)];
  }
  
  printf("Popping %d numbers: ", (int)numberOfNumbers);
  fflush(stdout);

  NSDate *startDate = [NSDate date];
  
  while (!queue.isEmpty) {
    [queue popObject];
  }
  
  NSDate *endDate = [NSDate date];
  
  printf("%0.3f seconds\n", [endDate timeIntervalSinceDate:startDate]);
}
