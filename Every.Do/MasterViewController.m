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

@interface MasterViewController () <AddTodoViewControllerDelegate, DetailViewControllerDelegate, TodoCellDelegate>

@property (nonatomic, strong) NSMutableArray *todoList;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    headerView.backgroundColor = [UIColor redColor];
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(163, 0, 100, 50)];
    refreshButton.backgroundColor = [UIColor whiteColor];
    [refreshButton setTitle:@"Save" forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [refreshButton addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:refreshButton];
    
    self.tableView.tableHeaderView = headerView;
    
}

-(void)saveData {
    
    MasterViewController *appDelegate = (MasterViewController *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate saveData];

}


#pragma mark - Bar Button Items

- (IBAction)addTodo:(UIBarButtonItem *)sender {
    
    
}
- (IBAction)editItem:(UIBarButtonItem *)sender {
    if (!self.tableView.editing) {
    
        [self.tableView setEditing:YES];
    }
    else {
        [self.tableView setEditing:NO];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *todo = self.todoList[indexPath.row];
        
        DetailViewController *dVC = segue.destinationViewController;
        dVC.selectedIndexPath = indexPath;
        
        [dVC setDetailItem:todo];
        dVC.delegate = self;
        
        
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
    cell.delegate = self;
    
    Todo *todo = self.todoList[indexPath.row];
    
    [self setTableCell:todo withCell:cell];
    
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

#pragma mark - Helper Methods

-(NSAttributedString *)addStrikeThrough:(NSString *)string {
    NSAttributedString * title =
    [[NSAttributedString alloc] initWithString:string
                                    attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    
    return title;
    
}



-(void)setTableCell:(Todo *)todo withCell:(TodoCell *)cell {
    if (todo.isCompleted) {
        [cell.titleLabel setAttributedText:[self addStrikeThrough:todo.title]];
    }
    else if (!todo.isCompleted){
        cell.titleLabel.text = todo.title;

    }
    
    cell.descriptionLabel.text = todo.todoDescription;
    cell.priorityLabel.text = [NSString stringWithFormat:@"Priority %d", (int)todo.priorityNumber];
    
    if (todo.priorityNumber < 3) {
        
        cell.priorityLabel.textColor = [UIColor greenColor];
    } else if (todo.priorityNumber == 3) {
        
        cell.priorityLabel.textColor = [UIColor orangeColor];
    } else {
        
        cell.priorityLabel.textColor = [UIColor redColor];
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

#pragma mark - Detail View Controller Delegate 

-(void)completeTask:(DetailViewController *)dvc withTodo:(Todo *)todo atIndexPath:(NSIndexPath *)indexPath{
     TodoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    self.todo = todo;
    
    [self setTableCell:todo withCell:cell];

    [self.tableView reloadData];
}

#pragma mark - Todo Cell Delegate

-(void)setCompleted:(TodoCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.todo = self.todoList[indexPath.row];
    
    self.todo.isCompleted = YES;
    
    [self setTableCell:self.todo withCell:cell];
    
}

#pragma mark - UITableViewDataSource Method

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Todo *todoSource = [self.todoList objectAtIndex:sourceIndexPath.row];

    [self.todoList removeObjectAtIndex:sourceIndexPath.row];
    [self.todoList insertObject:todoSource atIndex:destinationIndexPath.row];

}



@end
