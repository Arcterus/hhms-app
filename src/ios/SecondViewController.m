//
//  SecondViewController.m
//  Harker Homework Management System
//
//  Created by Arcterus on 10/15/12.
//  Copyright (c) 2012 kRaken Research. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize homeworkTableView;
@synthesize homeworkContents;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *contents = [[NSMutableArray alloc] initWithObjects:@"Red", @"Blue", @"Green", @"Blah", nil];
    [self setHomeworkContents:contents];
    [contents release];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self homeworkTableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self homeworkContents] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellIdentifier";
    NSString *rowContents = [[self homeworkContents] objectAtIndex:[indexPath row]];
    UITableViewCell *cell = [homeworkTableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    [[cell textLabel] setText:rowContents];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [homeworkTableView release];
    [homeworkContents release];
    [super dealloc];
}

@end
