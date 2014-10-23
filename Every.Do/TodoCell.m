//
//  TodoCell.m
//  Every.Do
//
//  Created by Jacob Cho on 2014-10-22.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "TodoCell.h"

@implementation TodoCell

- (void)awakeFromNib {
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeRecognizer.delegate = self;
    [self addGestureRecognizer:swipeRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)swipeGesture:(UISwipeGestureRecognizer *)sender {
    
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        [self.delegate setCompleted:self];
        
    }
    
}

@end
