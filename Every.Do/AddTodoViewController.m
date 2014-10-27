//
//  AddTodoViewController.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "AddTodoViewController.h"
#import "DefaultTodoViewController.h"

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

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    DefaultTodoViewController *dvc = [[DefaultTodoViewController alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self setDefaultTodo:dvc withDefaults:defaults];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"DefaultTodoSegue"]) {
         DefaultTodoViewController *dvc = segue.destinationViewController;
         dvc.delegate = self;
        
    }
    
}

#pragma mark - Default VC Delegate Method

-(void)setDefaultTodo:(DefaultTodoViewController *)dvc withDefaults:(NSUserDefaults *)defaults {
    
    if (defaults != nil) {
    
    self.titleTextField.text = [defaults objectForKey:@"Title"];
    self.descriptionTextField.text = [defaults objectForKey:@"Description"];
    self.priorityLabel.text = [NSString stringWithFormat:@"%d",(int)[defaults integerForKey:@"Priority Number"]];
    }
    
}



@end
