//
//  userMenuCell.m
//  testProject
//
//  Created by Liang Xiao on 31/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "userMenuCell.h"


@implementation userMenuCell
@synthesize imageView, nameLabel,priceLabel;
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
	[imageView release];
	[nameLabel release];
	[priceLabel release];
    [super dealloc];
}


@end
