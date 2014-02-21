//
//  KKPriorityQueue.h
//  KKPriorityQueue
//
//  Created by Karol Kozub on 17/02/14.
//  Copyright (c) 2014 Karol Kozub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKPriorityQueue : NSObject <NSCopying>

+ (instancetype)minQueue;
+ (instancetype)maxQueue;
+ (instancetype)queueWithComparator:(NSComparator)comparator ascending:(BOOL)ascending;

- (BOOL)isEmpty;
- (NSUInteger)count;
- (id)topObject;
- (id)popObject;
- (void)addObject:(id)object;
- (void)addObjectsFromArray:(NSArray *)objects;
- (void)removeObject:(id)object;

@end
