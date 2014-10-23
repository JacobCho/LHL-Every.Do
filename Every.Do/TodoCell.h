//
//  TodoCell.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@class TodoCell;
@protocol TodoCellDelegate <NSObject>

-(void)setCompleted:(TodoCell *)cell;

@end

@interface TodoCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (strong, nonatomic) Todo *todo;
@property (weak, nonatomic) id<TodoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@end
