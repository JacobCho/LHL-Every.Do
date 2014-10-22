//
//  AddTodoViewController.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UISlider *prioritySlider;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@end



@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    self.priorityLabel.text = [NSString stringWithFormat:@"%d", (int)self.prioritySlider.value];
}
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    
    if ([self.titleTextField.text isEqual: @""]) {

        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        self.todo = [[Todo alloc] init];
        self.todo.priorityNumber = [self.priorityLabel.text integerValue];
        self.todo.title = self.titleTextField.text;
        self.todo.todoDescription = self.descriptionTextField.text;
        
        [self.delegate addNewTodo:self didAddTodo:self.todo];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}



@end
