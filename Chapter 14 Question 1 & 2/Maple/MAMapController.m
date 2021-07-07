//
//  MAMapController.m
//  Maple
//
//  Created by Jakob Iversen on 9/13/13.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MAMapController.h"
#import "MAMapPoint.h"
#import "MAAppDelegate.h"
#import "Contact.h"
#import "CoreDataHelper.h"

@interface MAMapController ()

@end

@implementation MAMapController

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
    _mvMap.showsUserLocation = YES;
    _mvMap.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    _contacts = [CoreDataHelper.sharedManager loadDataFromDatabase];
    //find location for all contacts
    for (Contact *contact in _contacts) {
        NSString *address = [NSString stringWithFormat:@"%@, %@ %@",
                             contact.streetAddress, contact.city, contact.state];
        //geocoding
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *bestMatch = [placemarks objectAtIndex:0];
            //set up annotation
            NSString *title = [NSString stringWithFormat:@"%@, %@",
                               contact.contactName, contact.city];
            CLLocationCoordinate2D coordinate = bestMatch.location.coordinate;
            MAMapPoint *mp = [[MAMapPoint alloc]
                               initWithCoordinate:coordinate
                               title:title
                               subtitle:contact.streetAddress];
            [_mvMap addAnnotation:mp];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D location;
//    location.longitude = userLocation.coordinate.longitude;
//    location.latitude = userLocation.coordinate.latitude;
    location = userLocation.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta = .5;
    span.longitudeDelta = .5;
    MKCoordinateRegion viewRegioin = MKCoordinateRegionMake(location, span);
    [_mvMap setRegion:viewRegioin animated:YES];
    
    MAMapPoint *mp = [[MAMapPoint alloc] initWithCoordinate:location
                                                        title:@"You"
                                                     subtitle:@"Are here"];
    [_mvMap addAnnotation:mp];
}
- (IBAction)mapTypeChanged:(id)sender {
    switch (_sgmtMapType.selectedSegmentIndex) {
        case 0:
            _mvMap.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mvMap.mapType = MKMapTypeHybrid;
            break;
        case 2:
            _mvMap.mapType = MKMapTypeSatellite;
        default:
            break;
    }
}
@end
