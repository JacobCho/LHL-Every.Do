//
//  Todo.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject <NSCoding> 

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *todoDescription;
@property (nonatomic, assign) NSInteger priorityNumber;
@property (nonatomic, assign) BOOL isCompleted;

-(instancetype)initWithTitle:(NSString *)title
             withDescription:(NSString *)description
          withPriorityNumber:(NSInteger)number
                andCompleted:(BOOL)completed;

- (id)initWithCoder:(NSCoder *)decoder;

@end
