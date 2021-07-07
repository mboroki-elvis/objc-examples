//
//  MAFirstViewController.h
//  Maple
//
//  Created by Iversen, Jakob H on 8/29/13.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <MessageUI/MessageUI.h>
#import "Contact.h"
#import "MAPhoneTextField.h"

@interface MAContactsController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate> 

@property (strong, nonatomic) Contact *contact;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)changeEditMode:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtEditMode;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtCell;
@property (weak, nonatomic) IBOutlet MAPhoneTextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdate;

@property (weak, nonatomic) IBOutlet UIImageView *imageContactPicture;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
- (IBAction)handleChangeImage:(id)sender;

@end
