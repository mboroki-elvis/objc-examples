//
//  MAMapPoint.h
//  Maple
//
//  Created by Iversen, Jakob H on 9/13/13.
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

