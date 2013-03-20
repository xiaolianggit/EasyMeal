//
//  orderListView.h
//  testProject
//
//  Created by Liang Xiao on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalURL.h"
#import "orderItem.h"
#import "menuItem.h"
#import "sharedFunctions.h"
#import "customOrderListViewCell.h"
#import "orderDetailView.h"
@interface orderListView : UIViewController<NSXMLParserDelegate> {
	UITableView *tableView;
	orderItem *localOrderItem;
	NSMutableString *currentItem;
	NSMutableArray *orderArray;
	int currentItemID,currentQuantity;
	customOrderListViewCell *localCell;
	UINavigationController *navigationController;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) orderItem *localOrderItem;
@property (nonatomic, retain) NSMutableString *currentItem;
@property (nonatomic, retain) NSMutableArray *orderArray;
@property (nonatomic, assign) int currentItemID,currentQuantity;
@property (nonatomic, retain) IBOutlet customOrderListViewCell *localCell;
@property (nonatomic, retain) UINavigationController *navigationController;
- (void) parseOrderList;
- (UILabel*)createLabelForStatus:(int)status inFrame:(CGRect)frame;
@end
