//
//  MAMapPoint.h
//  Maple
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//1
@interface MAMapPoint : NSObject<MKAnnotation>
//2
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
//3
-(id) initWithCoordinate:(CLLocationCoordinate2D) location
                   title:(NSString *) contactName
                subtitle:(NSString *) address;
@end

