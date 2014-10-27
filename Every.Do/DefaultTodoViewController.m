//
//  DefaultTodoViewController.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-27.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "DefaultTodoViewController.h"

@interface DefaultTodoViewController ()

@end

@implementation DefaultTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self setUpViewsFromDefaults];
    
}



- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    self.priorityLabel.text = [NSString stringWithFormat:@"%d", (int)self.prioritySlider.value];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    if ([self.titleTextField.text isEqual: @""]) {
        
        [self.navigationController popViewControllerAnimated:TRUE];
        
    } else {
        [self saveToDefaults];
        
        [self.navigationController popViewControllerAnimated:TRUE];
        
    }
}

#pragma mark - Helper Methods

-(void)saveToDefaults {
    self.todo = [[Todo alloc] init];
    self.todo.priorityNumber = [self.priorityLabel.text integerValue];
    self.todo.title = self.titleTextField.text;
    self.todo.todoDescription = self.descriptionTextField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:self.todo.priorityNumber forKey:@"Priority Number"];
    [defaults setObject:self.todo.title forKey:@"Title"];
    [defaults setObject:self.todo.todoDescription forKey:@"Description"];
    [defaults synchronize];

    [self.delegate setDefaultTodo:self withDefaults:defaults];
    
}

-(void)setUpViewsFromDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (defaults != nil) {
        
        self.titleTextField.text = [defaults objectForKey:@"Title"];
        self.descriptionTextField.text = [defaults objectForKey:@"Description"];
        self.priorityLabel.text = [NSString stringWithFormat:@"%d",(int)[defaults integerForKey:@"Priority Number"]];
        
    }
    
}

@end
