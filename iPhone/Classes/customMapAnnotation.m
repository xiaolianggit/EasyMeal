//
//  customMapAnnotation.m
//  testProject
//
//  Created by Liang Xiao on 13/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "customMapAnnotation.h"


@implementation customMapAnnotation
@synthesize title,coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)newCoordinate title:(NSString*)newTitle{
	if(self = [super init]){
		coordinate = newCoordinate;
		self.title = newTitle;
	}
	return self;
}
-(void) dealloc{
	[title release];
	[super dealloc];
}

@end
