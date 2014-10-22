//
//  Todo.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *todoDescription;
@property (nonatomic, assign) NSInteger priorityNumber;
@property (nonatomic, assign) BOOL isCompleted;



@end
