//
//  MAMapPoint.m
//  Maple
//
//  Created by Nouman Aslam on 06/07/2021.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MAMapPoint.h"

@implementation MAMapPoint


- (id) init
{
    self = [super init];
    if(self){
        //Initialization code
    }
    return self;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)location title:(NSString *)contactName subtitle:(NSString *)address
{
    self = [self init];
    if(self)
    {
        _coordinate = location;
        _title = contactName;
        _subtitle = address;
    }
    return self;
}

@end

