//
//  orderItem.m
//  testProject
//
//  Created by Liang Xiao on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "orderItem.h"


@implementation orderItem
@synthesize customerName,contactPhone,deliveryAddress,orderDate,comment,orderID,status,menuItemList;

- (id) init{
	if (self = [super init]) {
		NSMutableArray *tempArray = [NSMutableArray array];
		self.menuItemList = tempArray;
	}
	return self;
}
- (void)dealloc {
	[menuItemList release];
	[customerName release];
	[contactPhone release];
	[deliveryAddress release];
	[orderDate release];
	[comment release];
    [super dealloc];
}
@end
