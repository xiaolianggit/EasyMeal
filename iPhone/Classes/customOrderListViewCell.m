//
//  customOrderListViewCell.m
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "customOrderListViewCell.h"


@implementation customOrderListViewCell
@synthesize orderID,name,date,status;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[orderID release];
	[name release];
	[date release];
	[status release];
    [super dealloc];
}


@end
