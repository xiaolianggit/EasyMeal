//
//  orderDetailView.h
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderItem.h"
#import "menuItem.h"
#import "mapView.h"
#import "userMenuDetailView.h"
@interface orderDetailView : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate> {
	orderItem *localOrderItem;
	UITableView *tableView;
}
@property (nonatomic, retain) orderItem *localOrderItem;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (id) initWithOrderItem:(orderItem*)item;
- (void) updateOrderStatusWithCell:(UITableViewCell*)cell;
@end
