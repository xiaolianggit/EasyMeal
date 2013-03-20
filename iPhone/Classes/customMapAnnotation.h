//
//  customMapAnnotation.h
//  testProject
//
//  Created by Liang Xiao on 13/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface customMapAnnotation : NSObject <MKAnnotation>{
	NSString *title;
	CLLocationCoordinate2D coordinate;
}
@property (nonatomic, retain) NSString *title;
- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title;
@end
