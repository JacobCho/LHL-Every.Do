//
//  MasterViewController.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface MasterViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Todo *todo;
@property (nonatomic, strong) NSMutableArray *todoList;


-(void)saveData;

@end

