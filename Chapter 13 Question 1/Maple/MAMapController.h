//
//  MAMapController.h
//  Maple
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MAMapController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mvMap;
@property (nonatomic) NSArray *contacts;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtMapType;
- (IBAction)mapTypeChanged:(id)sender;

@end
