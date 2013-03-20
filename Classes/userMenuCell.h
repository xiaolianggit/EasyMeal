//
//  userMenuCell.h
//  testProject
//
//  Created by Liang Xiao on 31/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userMenuCell : UITableViewCell {
	UIImageView *imageView;
	UILabel *nameLabel,*priceLabel;
	
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel,*priceLabel;
@end
