//
//  SecondViewController.h
//  Harker Homework Management System
//
//  Created by Arcterus on 10/15/12.
//  Copyright (c) 2012 kRaken Research. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *homeworkTableView;
    NSMutableArray *homeworkContents;
}

@property (nonatomic, retain) IBOutlet UITableView *homeworkTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *homeworkContents;

@end
