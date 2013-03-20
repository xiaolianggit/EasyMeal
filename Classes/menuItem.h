//
//  menuItem.h
//  testProject
//
//  Created by Liang Xiao on 21/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface menuItem : NSObject<NSCopying>{
	int itemId, quantity, kind;
	NSString *itemName;
	NSString *intro;
	float price;
}
@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, assign) int itemId, quantity, kind;
@property (nonatomic, assign) float price; 
@end
