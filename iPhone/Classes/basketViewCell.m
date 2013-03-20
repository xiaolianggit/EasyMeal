//
//  basketViewCell.m
//  testProject
//
//  Created by Liang Xiao on 18/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "basketViewCell.h"


@implementation basketViewCell
@synthesize nameLabel,quantityLabel,unitPriceLabel,sumPriceLabel;
@synthesize imageView;

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
	[nameLabel release];
	[quantityLabel release];
	[unitPriceLabel release];
	[sumPriceLabel release];
	[imageView release];
    [super dealloc];
}


@end
