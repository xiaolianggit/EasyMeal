//
//  textInputCell.h
//  testProject
//
//  Created by Liang Xiao on 24/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface textInputCell : UITableViewCell {
	UITextField *tf;
}
@property (nonatomic, retain) IBOutlet UITextField *tf;
@end
