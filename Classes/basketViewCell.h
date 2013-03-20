//
//  basketViewCell.h
//  testProject
//
//  Created by Liang Xiao on 18/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface basketViewCell : UITableViewCell {
	UILabel *nameLabel,*quantityLabel,*unitPriceLabel,*sumPriceLabel;
	UIImageView *imageView;
}
@property (nonatomic, retain) IBOutlet UILabel *nameLabel,*quantityLabel,*unitPriceLabel,*sumPriceLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@end
