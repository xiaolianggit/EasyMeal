//
//  textInputCell.m
//  testProject
//
//  Created by Liang Xiao on 24/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "textInputCell.h"


@implementation textInputCell
@synthesize tf;
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
	[tf release];
    [super dealloc];
}


@end
