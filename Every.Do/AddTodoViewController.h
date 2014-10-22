//
//  AddTodoViewController.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@class AddTodoViewController;
@protocol AddTodoViewControllerDelegate <NSObject>

-(void)addNewTodo:(AddTodoViewController *)addTodoVC didAddTodo:(Todo *)todo;

@end

@interface AddTodoViewController : UIViewController

@property (nonatomic, weak) id<AddTodoViewControllerDelegate> delegate;
@property (nonatomic, strong) Todo *todo;

@end
