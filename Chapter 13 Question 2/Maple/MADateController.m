//
//  MADateController.m
//  Maple CoreData
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MADateController.h"

@interface MADateController ()

@end

@implementation MADateController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *saveButton =
                  [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                      target:self
                      action:@selector(saveDate:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    self.title = @"Pick Birthdate";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveDate: (id)sender
{
    [_delegate dateChanged:[_dtpDate date]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
