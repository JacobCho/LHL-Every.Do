//
//  DetailViewController.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@class DetailViewController;
@protocol DetailViewControllerDelegate <NSObject>

-(void)completeTask:(DetailViewController *)dvc withTodo:(Todo *)todo atIndexPath:(NSIndexPath *)indexPath;

@end

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Todo *todo;
@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;
@property (weak, nonatomic) NSIndexPath *selectedIndexPath;

- (void)setDetailItem:(Todo *)newTodo;

@end

