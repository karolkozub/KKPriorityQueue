//
//  KKPriorityQueue.m
//  KKPriorityQueue
//
//  Created by Karol Kozub on 17/02/14.
//  Copyright (c) 2014 Karol Kozub. All rights reserved.
//

#import "KKPriorityQueue.h"

@interface KKPriorityQueue ()

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSComparator comparator;
@property (nonatomic, assign) NSComparisonResult orderedPrior;

@end

@implementation KKPriorityQueue

+ (instancetype)minQueue {
  return [self queueWithComparator:nil ascending:YES];
}

+ (instancetype)maxQueue {
  return [self queueWithComparator:nil ascending:NO];
}

+ (instancetype)queueWithComparator:(NSComparator)comparator ascending:(BOOL)ascending {
  return [[self alloc] initWithComparator:comparator ascending:ascending];
}

- (instancetype)init {
  return [self initWithComparator:nil ascending:YES];
}

- (instancetype)initWithComparator:(NSComparator)comparator ascending:(BOOL)ascending {
  self = [super init];
  
  if (self) {
    self.objects = [NSMutableArray array];
    self.comparator = comparator ?: ^NSComparisonResult(id obj1, id obj2) {
      return [obj1 compare:obj2];
    };
    self.orderedPrior = ascending ? NSOrderedAscending : NSOrderedDescending;
  }
  
  return self;
}

- (BOOL)isEmpty {
  return 0 == [self.objects count];
}

- (NSUInteger)count {
  return [self.objects count];
}

- (id)topObject {
  return [self.objects firstObject];
}

- (id)popObject {
  if ([self isEmpty]) {
    return nil;
  }
  
  id result = [self.objects firstObject];
  NSInteger index = 0;

  [self.objects exchangeObjectAtIndex:0 withObjectAtIndex:[self.objects count] - 1];
  [self.objects removeLastObject];
  
  while (index < [self.objects count]) {
    NSInteger leftChildIndex = (index + 1) * 2 - 1;
    NSInteger rightChildIndex = (index + 1) * 2;
    NSInteger priorChildIndex;
    
    BOOL isLeftChildPrior = leftChildIndex < [self.objects count] && [self isObjectAtIndex:leftChildIndex priorToObjectAtIndex:index];
    BOOL isRightChildPrior = rightChildIndex < [self.objects count] && [self isObjectAtIndex:rightChildIndex priorToObjectAtIndex:index];
    
    if (isLeftChildPrior && isRightChildPrior) {
      priorChildIndex = [self isObjectAtIndex:leftChildIndex priorToObjectAtIndex:rightChildIndex] ? leftChildIndex : rightChildIndex;
      
    } else if (isLeftChildPrior) {
      priorChildIndex = leftChildIndex;
      
    } else if (isRightChildPrior) {
      priorChildIndex = rightChildIndex;
      
    } else {
      break;
    }

    [self.objects exchangeObjectAtIndex:index withObjectAtIndex:priorChildIndex];
    
    index = priorChildIndex;
  }
  
  return result;
}

- (BOOL)isObjectAtIndex:(NSInteger)index priorToObjectAtIndex:(NSInteger)otherIndex {
  return self.orderedPrior == self.comparator([self.objects objectAtIndex:index], [self.objects objectAtIndex:otherIndex]);
}

- (void)addObject:(id)object {
  [self.objects addObject:object];
  NSInteger index = [self.objects count] - 1;
  
  while (index > 0) {
    NSInteger parentIndex = (index - 1) / 2;
    BOOL isPriorToParent = [self isObjectAtIndex:index priorToObjectAtIndex:parentIndex];
    
    if (isPriorToParent) {
      [self.objects exchangeObjectAtIndex:index withObjectAtIndex:parentIndex];
      index = parentIndex;
      
    } else {
      break;
    }
  }
}

- (void)addObjectsFromArray:(NSArray *)objects {
  for (id object in objects) {
    [self addObject:object];
  }
}

- (instancetype)copyWithZone:(NSZone *)zone {
  KKPriorityQueue *queue = [KKPriorityQueue queueWithComparator:[self.comparator copy] ascending:NSOrderedAscending == self.orderedPrior];
  
  queue.objects = [self.objects mutableCopy];
  
  return queue;
}

@end
