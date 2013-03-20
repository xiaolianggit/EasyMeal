//
//  changeRestImageView.m
//  testProject
//
//  Created by Liang Xiao on 30/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "changeRestImageView.h"


@implementation changeRestImageView
@synthesize imageView, pickButton, uploadButton, cancelButton,delegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction) cancel{
	[delegate refreshRestPic];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) choose{
	UIImagePickerController *pickerController = [[[UIImagePickerController alloc] init] autorelease];
	pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	pickerController.delegate = self;
	pickerController.allowsEditing = YES;
	[self presentModalViewController:pickerController animated:YES];
}

- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)img editingInfo:(NSDictionary*)editInfo{
	imageView.image = img;
	uploadButton.hidden = NO;
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) upload{
	NSURL *requestURL = [globalURL restInfoPicUploaderURL];
	[sharedFunctions uploadImage:imageView.image toURL:requestURL];
	NSData *newImageData = UIImageJPEGRepresentation(self.imageView.image, 70);
	NSString *pathstring = [[folderPath restPicturePath] stringByAppendingPathComponent:@"/restPic.jpg"];
	[newImageData writeToFile:pathstring atomically:YES];
	[delegate refreshRestPic];
	[self dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[cancelButton release];
	[imageView release];
	[pickButton release];
	[uploadButton release];
    [super dealloc];
}


@end
