//
//  Todo.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "Todo.h"

#define TitleKey @"Title"
#define DescriptionKey @"Description"
#define PriorityKey @"Priority Number"
#define CompletedKey @"Completed"

@implementation Todo

-(instancetype)initWithTitle:(NSString *)title
             withDescription:(NSString *)description
            withPriorityNumber:(NSInteger)number
                andCompleted:(BOOL)completed {
    
    self = [super init];
    self.title = title;
    self.todoDescription = description;
    self.priorityNumber = number;
    self.isCompleted = completed;
    
    return self;
    
}



- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:TitleKey];
    [encoder encodeObject:_todoDescription forKey:DescriptionKey];
    [encoder encodeInteger:_priorityNumber forKey:PriorityKey];
    [encoder encodeBool:_isCompleted forKey:CompletedKey];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    _title = [decoder decodeObjectForKey:TitleKey];
    _todoDescription = [decoder decodeObjectForKey:DescriptionKey];
    _priorityNumber = [decoder decodeIntegerForKey:PriorityKey];
    _isCompleted = [decoder decodeBoolForKey:CompletedKey];
    
    return [self initWithTitle:_title withDescription:_todoDescription withPriorityNumber:_priorityNumber andCompleted:_isCompleted];
    
}


@end
