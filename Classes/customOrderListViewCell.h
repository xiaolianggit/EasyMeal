//
//  customOrderListViewCell.h
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface customOrderListViewCell : UITableViewCell {
	UILabel *orderID,*name,*date,*status;
}
@property (nonatomic, retain) IBOutlet UILabel *orderID,*name,*date,*status;
@end
