//
//  DetailViewController.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Todo *todo;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


- (void)setDetailItem:(Todo *)newTodo;

@end

