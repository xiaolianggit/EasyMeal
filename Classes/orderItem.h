//
//  orderItem.h
//  testProject
//
//  Created by Liang Xiao on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface orderItem : NSObject {
	NSString *customerName,*contactPhone,*deliveryAddress,*orderDate,*comment;
	int orderID,status;
	NSMutableArray *menuItemList;
}
@property (nonatomic, retain) NSString *customerName,*contactPhone,*deliveryAddress,*orderDate,*comment;
@property (nonatomic, assign) int orderID,status;
@property (nonatomic, retain) NSMutableArray *menuItemList;
@end
