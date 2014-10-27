//
//  DefaultTodoViewController.h
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-27.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@class DefaultTodoViewController;
@protocol DefaultTodoViewControllerDelegate <NSObject>

-(void)setDefaultTodo:(DefaultTodoViewController *)dvc withDefaults:(NSUserDefaults *)defaults;

@end

@interface DefaultTodoViewController : UIViewController

@property (weak, nonatomic) id<DefaultTodoViewControllerDelegate> delegate;
@property (strong, nonatomic) Todo *todo;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UISlider *prioritySlider;
- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)saveButtonPressed:(UIButton *)sender;



@end
