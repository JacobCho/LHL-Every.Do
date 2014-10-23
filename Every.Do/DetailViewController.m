//
//  DetailViewController.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *completionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *completionSwitch;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Todo *)newTodo {
    if (_todo != newTodo) {
        _todo = newTodo;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.todo) {
        self.titleTextField.text = self.todo.title;
        self.descriptionTextView.text = self.todo.todoDescription;
        self.priorityLabel.text = [NSString stringWithFormat:@"%d", (int)self.todo.priorityNumber];
        
        if (self.todo.isCompleted) {
            
            [self.completionSwitch setOn:YES];
            
        } else {
            [self.completionSwitch setOn:NO];
        }
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (IBAction)completionSwitch:(UISwitch *)sender {
   
    if ([sender isOn]) {
        self.todo.isCompleted = YES;
        self.completionLabel.text = @"Completed:";
    } else if (![sender isOn]) {
        self.todo.isCompleted = NO;
        self.completionLabel.text = @"Not Completed:";
    }
    
}
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    self.todo.title = self.titleTextField.text;
    self.todo.todoDescription = self.descriptionTextView.text;
    [self.delegate completeTask:self withTodo:self.todo atIndexPath:self.selectedIndexPath];
    [self.navigationController popViewControllerAnimated:YES];

}



@end
