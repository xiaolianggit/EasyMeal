//
//  changeRestImageView.h
//  testProject
//
//  Created by Liang Xiao on 30/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalURL.h"
#import "sharedFunctions.h"
#import "folderPath.h"
#import "welcome.h"

@protocol welcomeViewDelegate;

@interface changeRestImageView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	id <welcomeViewDelegate> delegate;
	
	UIImageView *imageView;
	UIButton *pickButton, *uploadButton, *cancelButton;
}
@property (nonatomic, assign) id <welcomeViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton *pickButton, *uploadButton, *cancelButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (IBAction) cancel;
- (IBAction) choose;
- (IBAction) upload;
@end
