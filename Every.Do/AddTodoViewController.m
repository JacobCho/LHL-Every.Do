//
//  AddTodoViewController.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "AddTodoViewController.h"
#import "DefaultTodoViewController.h"

@interface AddTodoViewController () {
    
    NSString *titleTextChange;
    
}


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
    
   
    [self loadData];
    
    
    [self.titleTextField addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
    
    [self.descriptionTextField addTarget:self
                            action:@selector(textFieldDidChange)
                  forControlEvents:UIControlEventEditingChanged];
    
    [self.prioritySlider addTarget:self
                                  action:@selector(textFieldDidChange)
                        forControlEvents:UIControlEventEditingChanged];
    
    
}

-(void)textFieldDidChange {
    
    self.todo.title = self.titleTextField.text;
    self.todo.todoDescription = self.descriptionTextField.text;
    self.todo.priorityNumber = self.prioritySlider.value;
    
    [self saveData];
    
    NSLog(@"Editing");
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

#pragma mark - Data Persistence

-(void)saveData {
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    if (self.todo != nil) {
        [dataDict setObject:self.todo forKey:@"todo"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingString:@"cache"];
    
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
    NSLog(@"Saved!");
    
}

-(void)loadData {
    
    // Look for saved data
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingString:@"cache"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([savedData objectForKey:@"todo"] != nil) {
            self.todo = [savedData objectForKey:@"todo"];
            self.titleTextField.text = self.todo.title;
            self.descriptionTextField.text = self.todo.todoDescription;
            self.priorityLabel.text = [NSString stringWithFormat:@"%d", (int)self.todo.priorityNumber];
            NSLog(@"Todo available");
        }
        
    
        NSLog(@"Loaded!");
    }
    else {
        DefaultTodoViewController *dvc = [[DefaultTodoViewController alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [self setDefaultTodo:dvc withDefaults:defaults];
    }
}



@end
