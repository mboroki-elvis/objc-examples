//
//  MAFirstViewController.m
//  Maple
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MAContactsController.h"
#import "MADateController.h"
#import "Contact.h"
#import "MAAppDelegate.h"
#import "CoreDataHelper.h"

@interface MAContactsController () <MADateControllerDelegate>

@end

@implementation MAContactsController

NSDate *birthdate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _scrollView.contentSize = CGSizeMake(320,500);
    
    UIBarButtonItem *saveButton =
                [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                        target:self
                        action:@selector(saveContact:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    self.title = @"Contact";
    
    if(_contact){
        _txtName.text = _contact.contactName;
        _txtAddress.text = _contact.streetAddress;
        _txtCity.text = _contact.city;
        _txtState.text = _contact.state;
        _txtZip.text = _contact.zipCode;
        _txtPhone.text = _contact.phoneNumber;
        _txtCell.text = _contact.cellNumber;
        _txtEmail.text = _contact.email;
        [self dateChanged:_contact.birthday];
        [_sgmtEditMode setSelectedSegmentIndex:0]; //set to view mode
        
    }
    else{
        [_sgmtEditMode setSelectedSegmentIndex:1];//edit mode
    }
    [self changeEditMode:self];

}


-(void)viewDidLayoutSubviews
{
    _scrollView.contentSize = CGSizeMake(320,500);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)changeEditMode:(id)sender {
    NSArray *textFields = @[_txtName, _txtAddress, _txtCity, _txtState,
                            _txtZip, _txtPhone, _txtCell, _txtEmail];
    if (_sgmtEditMode.selectedSegmentIndex == 0){
        for (UITextField *txtfield in textFields) {
            [txtfield setEnabled:NO];
            [txtfield setBorderStyle:UITextBorderStyleNone];
        }
        [_btnChange setHidden:YES];
    }
    else if (_sgmtEditMode.selectedSegmentIndex == 1)
    {
        for (UITextField *txtfield in textFields) {
            [txtfield setEnabled:YES];
            [txtfield setBorderStyle:UITextBorderStyleRoundedRect];
        }
        [_btnChange setHidden:NO];
    }
}



-(void)dateChanged:(NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [_lblBirthdate setText:[dateFormatter stringFromDate:date ]];
    birthdate = date;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueContactDate"]) {
        MADateController *dateController = segue.destinationViewController;
        dateController.delegate = self;
    }
}

-(IBAction)saveContact: (id)sender
{
    NSMutableDictionary *bookListing = [NSMutableDictionary dictionary];
    [bookListing setObject:_txtName.text  forKey: @"contactName"];
    [bookListing setObject:_txtAddress.text  forKey: @"streetAddress"];
    [bookListing setObject:_txtCity.text  forKey: @"city"];
    [bookListing setObject:_txtState.text  forKey: @"state"];
    [bookListing setObject:_txtZip.text  forKey: @"zipCode"];
    [bookListing setObject:_txtPhone.text  forKey: @"phoneNumber"];
    [bookListing setObject:_txtCell.text  forKey: @"cellNumber"];
    [bookListing setObject:_txtEmail.text  forKey: @"email"];
    [bookListing setObject:birthdate  forKey: @"birthday"];
    [CoreDataHelper.sharedManager saveContact:bookListing];
}
@end
