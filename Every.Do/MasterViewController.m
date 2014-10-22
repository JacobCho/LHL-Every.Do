//
//  MasterViewController.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddTodoViewController.h"
#import "TodoCell.h"

@interface MasterViewController () <AddTodoViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *todoList;
@end

@implementation MasterViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.



    
}

#pragma mark - Bar Button Items

- (IBAction)addTodo:(UIBarButtonItem *)sender {
    if (!self.todoList) {
        self.todoList = [[NSMutableArray alloc] init];
    }
    
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}
- (IBAction)editItem:(UIBarButtonItem *)sender {
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *todo = self.todoList[indexPath.row];
        [[segue destinationViewController] setDetailItem:todo];
    }
    else if ([[segue identifier] isEqualToString:@"addTodoSegue"]) {
        
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddTodoViewController *addTodoVC= [navigationController viewControllers][0];
        addTodoVC.delegate = self;
        
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Todo *todo = self.todoList[indexPath.row];
    
    if (todo.isCompleted) {
        NSAttributedString * title =
        [[NSAttributedString alloc] initWithString:todo.title
                                        attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
        [cell.titleLabel setAttributedText:title];
    }
    else {
        cell.titleLabel.text = todo.title;
    }
    
    cell.descriptionLabel.text = todo.todoDescription;
    cell.priorityLabel.text = [NSString stringWithFormat:@"%d", (int)todo.priorityNumber];
    
    if (todo.priorityNumber < 3) {
        
        cell.priorityLabel.textColor = [UIColor greenColor];
    } else if (todo.priorityNumber == 3) {
        
        cell.priorityLabel.textColor = [UIColor orangeColor];
    } else {
        
        cell.priorityLabel.textColor = [UIColor redColor];
    }
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Add Todo Delegate Method

-(void)addNewTodo:(AddTodoViewController *)addTodoVC didAddTodo:(Todo *)todo {
    
    if (!self.todoList) {
        self.todoList = [[NSMutableArray alloc] init];
    }
    
    [self.todoList addObject:todo];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.todoList count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    

    
    
    
}

@end
