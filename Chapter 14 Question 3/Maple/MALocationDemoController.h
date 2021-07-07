//
//  MASecondViewController.h
//  Maple
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MALocationDemoController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtStreetAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UILabel *lblLatitude;
@property (weak, nonatomic) IBOutlet UILabel *lblLongitude;
@property (weak, nonatomic) IBOutlet UILabel *lblLocationAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *lblHeading;
@property (weak, nonatomic) IBOutlet UILabel *lblHeadingAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *lblAltitude;
@property (weak, nonatomic) IBOutlet UILabel *lblAltitudeAccuracy;
@property (weak, nonatomic) IBOutlet UISegmentedControl *accuracyToggle;

- (IBAction)changeAccuracy:(id)sender;
- (IBAction)addressToCoordinates:(id)sender;
- (IBAction)deviceCoordinates:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
@end
