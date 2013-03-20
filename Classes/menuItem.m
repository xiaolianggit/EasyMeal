//
//  menuItem.m
//  testProject
//
//  Created by Liang Xiao on 21/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "menuItem.h"


@implementation menuItem
@synthesize itemName,intro;
@synthesize itemId, price, quantity,kind;


- (void)dealloc {
	[itemName release];
	[intro release];
    [super dealloc];
}
-(id) copyWithZone: (NSZone *) zone
{
	menuItem *menuItemCopy = [[menuItem allocWithZone:zone] init];
	menuItemCopy.itemId = itemId;
	menuItemCopy.itemName = itemName;
	menuItemCopy.intro = intro;
	menuItemCopy.price = price;
	menuItemCopy.quantity = 1;
	menuItemCopy.kind = kind;
	return menuItemCopy;
}


@end
