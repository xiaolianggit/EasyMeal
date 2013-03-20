//
//  customTableView.m
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "customTableView.h"


@implementation customTableView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
	if (event.subtype == UIEventSubtypeMotionShake) {
		[self.delegate showRandomMenuItem];////this generate a warning here?
	}
}

- (BOOL) canBecomeFirstResponder{
	return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
