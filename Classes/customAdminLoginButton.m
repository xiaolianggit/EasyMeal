//
//  customAdminLoginButton.m
//  EasyMeal
//
//  Created by Liang Xiao on 07/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "customAdminLoginButton.h"


@implementation customAdminLoginButton


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code.
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/
- (BOOL) canBecomeFirstResponder{
	return YES;
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
	if (event.subtype == UIEventSubtypeMotionShake) {
		self.hidden = NO;
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
