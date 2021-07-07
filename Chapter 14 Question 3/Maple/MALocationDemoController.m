//
//  MASecondViewController.m
//  Maple
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MALocationDemoController.h"


@interface MALocationDemoController ()

@end
    CLLocationManager *locationManager;

@implementation MALocationDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //UIScrollView *tempScrollView=(UIScrollView *)self.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addressToCoordinates:(id)sender {
    NSString *address = [NSString stringWithFormat:@"%@, %@ %@",
                         _txtStreetAddress.text, _txtCity.text, _txtState.text];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *bestMatch = [placemarks objectAtIndex:0];
        CLLocationCoordinate2D coordinate = bestMatch.location.coordinate;
        _lblLatitude.text = [NSString stringWithFormat:@"%g\u00B0",
                             coordinate.latitude];
        _lblLongitude.text = [NSString stringWithFormat:@"%g\u00B0",
                              coordinate.longitude];
    }];
}

- (IBAction)changeAccuracy:(id)sender {
    [self setupManager];
    UISegmentedControl *segments = (UISegmentedControl *)sender;
    switch (segments.selectedSegmentIndex) {
        case 0:
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            break;
        case 1:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            break;
        case 2:
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            break;
        case 3:
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            break;
        case 4:
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            break;
        case 5:
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            break;
        default:
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            break;
    }
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
}

- (IBAction)deviceCoordinates:(id)sender {
    [self setupManager];
}


-(void)viewDidDisappear:(BOOL)animated{
    [locationManager stopUpdatingLocation];
    [locationManager stopUpdatingHeading];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

-(void)setupManager{
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        locationManager.distanceFilter = 100;
        if (@available(iOS 14.0, *)) {
            switch (locationManager.authorizationStatus) {
                case kCLAuthorizationStatusNotDetermined:
                    [locationManager requestAlwaysAuthorization];
                    [locationManager requestWhenInUseAuthorization];
                case kCLAuthorizationStatusRestricted:
                    [locationManager requestAlwaysAuthorization];
                    [locationManager requestWhenInUseAuthorization];
                case kCLAuthorizationStatusDenied:
                    [locationManager requestAlwaysAuthorization];
                    [locationManager requestWhenInUseAuthorization];
                case kCLAuthorizationStatusAuthorizedWhenInUse:
                    break;
                case kCLAuthorizationStatusAuthorizedAlways:
                    break;
            }
        }
    }
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    printf("before %ld", (long)howRecent);
    if (fabs(howRecent) < 15.0) {
        printf("after %ld", (long)howRecent);
        CLLocationCoordinate2D coordinate= location.coordinate;
        _lblLongitude.text = [NSString stringWithFormat:@"%g\u00B0",
                              coordinate.longitude];
        _lblLatitude.text = [NSString stringWithFormat:@"%g\u00B0",
                             coordinate.latitude];
        _lblLocationAccuracy.text = [NSString stringWithFormat:@"%gm",
                                     location.horizontalAccuracy];
        _lblAltitude.text = [NSString stringWithFormat:@"%gm",
                             location.altitude];
        _lblAltitudeAccuracy.text = [NSString stringWithFormat:@"%gm",
                                     location.verticalAccuracy];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if(newHeading.headingAccuracy > 0){
        CLLocationDirection theHeading = newHeading.trueHeading;
        _lblHeading.text = [NSString stringWithFormat:@"%g\u00B0", theHeading];
        _lblHeadingAccuracy.text = [NSString stringWithFormat:@"%g\u00B0",
                                    newHeading.headingAccuracy];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error Getting Location"
                          message:errorType
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}



@end
