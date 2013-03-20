//
//  userMenuDetailView.m
//  testProject
//
//  Created by Liang Xiao on 10/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "userMenuDetailView.h"


@implementation userMenuDetailView
@synthesize imageView;
@synthesize itemIdLabel,priceLabel,quantityLabel,kindLabel,introTextView;
@synthesize selectedIndexPath,singleMenuItem;
@synthesize swipeLeftRecognizer;
@synthesize appDelegate,setRecommended;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.appDelegate = (EasyMealAppDelegate*) [[UIApplication sharedApplication] delegate];
	[self refreshLabels];
	
	self.setRecommended.hidden = !self.appDelegate.isAdminMode;
}

- (void) refreshLabels{
	menuItem *selectedItem;
	if (self.singleMenuItem == nil) {
		selectedItem = [sharedFunctions menuItemAtIndexPath:self.selectedIndexPath];
	}
	else {
		selectedItem = self.singleMenuItem;
	}

	self.navigationItem.title = selectedItem.itemName;
	self.introTextView.text = selectedItem.intro;
	self.priceLabel.text = [NSString stringWithFormat:@"$ %.2f",selectedItem.price];
	self.itemIdLabel.text =[NSString stringWithFormat:@"Item ID: %d",selectedItem.itemId]; 
	
	NSString *folderPathForMenuItemPic = [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
	int menuItemId = selectedItem.itemId;
	NSString *filePath = [NSString stringWithFormat:@"%@/%d.jpg",folderPathForMenuItemPic,menuItemId];
	NSData *tempLocalImageData = [NSData dataWithContentsOfFile:filePath];
	if (tempLocalImageData) {
		self.imageView.image = [UIImage imageWithData:tempLocalImageData];
	}
	else {
		self.imageView.image = [UIImage imageNamed:@"unavailable.jpg"];
	}

}

- (void) handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
	NSIndexPath *predictedIndexPath;
	if (recognizer == self.swipeLeftRecognizer) {
		predictedIndexPath = [self findNextIndexPath:selectedIndexPath];
		if (predictedIndexPath) {
			self.selectedIndexPath = predictedIndexPath;
			[self showNextItem];
			[self refreshLabels];
		}
		else {
			[self bounceCurrentItemLeft];
		}
	}
	else {
		predictedIndexPath = [self findPreviousIndexPath:selectedIndexPath];
		if (predictedIndexPath) {
			self.selectedIndexPath = predictedIndexPath;
			[self showPreviousItem];
			[self refreshLabels];
		}
		else {
			[self bounceCurrentItemRight];
		}
	}	
}

- (NSIndexPath*) findNextIndexPath:(NSIndexPath*)originalIndexPath{
	NSIndexPath *newIndexPath;
	//first check if it is the last object in row
	if (originalIndexPath.row < [[self.appDelegate.menuArray objectAtIndex:originalIndexPath.section] count] -1)
	//not the last item in the section
	{
		newIndexPath = [NSIndexPath indexPathForRow:(originalIndexPath.row + 1) inSection:originalIndexPath.section];
	}
	else 
	//originsal index path is the last one in section
	//continue to check section
	{
		if (originalIndexPath.section < [self.appDelegate.menuArray count] - 1) {//section is not the last
			newIndexPath = [NSIndexPath indexPathForRow:0 inSection:(originalIndexPath.section+1)];
		}
		else {//section is the lst
			newIndexPath = nil;//no more next one
		}

	}
	return newIndexPath;
}

- (NSIndexPath*) findPreviousIndexPath:(NSIndexPath*)originalIndexPath{
	NSIndexPath *newIndexPath;
	//check if it's the first row in the section
	if (originalIndexPath.row > 0) {//not the first one
		newIndexPath = [NSIndexPath indexPathForRow:(originalIndexPath.row - 1) inSection:originalIndexPath.section];
	}
	else {//first row in section
		  //continue to check if it's the first section
		if (originalIndexPath.section == 0) {
			//also first section
			//no more previous one
			newIndexPath = nil;
		}
		else {
			newIndexPath = [NSIndexPath indexPathForRow:([[self.appDelegate.menuArray objectAtIndex:(originalIndexPath.section - 1)] count] - 1) inSection:(originalIndexPath.section - 1)];
		}

	}

	return newIndexPath;
}

/////////animation functions;

- (void) showNextItem{
	
	UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectOffset([imageView frame], self.view.frame.size.width-self.imageView.frame.origin.x, 0)];
	
	[UIView beginAnimations:@"animateImageOn" context:NULL]; // Begin animation
	[UIView setAnimationDuration:.8];
	[self.imageView setFrame:CGRectOffset([self.imageView frame], -self.imageView.frame.origin.x-self.imageView.frame.size.width,0)]; // Move imageView on screen
	self.imageView.alpha = 0;
	[UIView commitAnimations]; // End animations
	
	newImageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView = newImageView;
	
	[newImageView release];
	
	[self.view addSubview:self.imageView];
	self.imageView.alpha = 0;
	[UIView beginAnimations:@"animateImageOff" context:NULL]; // Begin animation
	[UIView setAnimationDelay:.5];
	[UIView setAnimationDuration:.8];
	[imageView setFrame:CGRectOffset([imageView frame], -self.view.frame.size.width+20, 0)]; // Move imageView off screen
	
	self.imageView.alpha = 1;
	[UIView commitAnimations]; // End animations	
}
- (void) showPreviousItem{
	
	UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectOffset([imageView frame], -self.imageView.frame.size.width-self.imageView.frame.origin.x, 0)];
	
	[UIView beginAnimations:@"animateImageOn" context:NULL]; // Begin animation
	[UIView setAnimationDuration:.8];
	[self.imageView setFrame:CGRectOffset([self.imageView frame], self.view.frame.size.width - self.imageView.frame.origin.x,0)]; // Move imageView on screen
	self.imageView.alpha = 0;
	[UIView commitAnimations]; // End animations
	
	newImageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView = newImageView;
	
	[newImageView release];
	
	[self.view addSubview:self.imageView];
	self.imageView.alpha = 0;
	[UIView beginAnimations:@"animateImageOff" context:NULL]; // Begin animation
	[UIView setAnimationDelay:.5];
	[UIView setAnimationDuration:.8];
	[imageView setFrame:CGRectOffset([imageView frame], self.imageView.frame.size.width+20, 0)]; // Move imageView off screen
	
	self.imageView.alpha = 1;
	[UIView commitAnimations]; // End animations	
}
- (void) bounceCurrentItemLeft{
	//create a new uiview instance
	//UIImageView *newView = self.imageView;
	
	UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectOffset(self.imageView.frame, -90, 0)];
	newImageView.image = self.imageView.image;
	newImageView.contentMode = UIViewContentModeScaleAspectFit;
	newImageView.alpha = 0;
	
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.5];
	[self.imageView setFrame:CGRectOffset([self.imageView frame], -90, 0)];
	self.imageView.alpha = 0;
	[UIView commitAnimations];
	
	[self.view addSubview:newImageView];
	[UIView beginAnimations:@"new animation" context:nil];
	[UIView setAnimationDelay:.5];
	[UIView setAnimationDuration:.3];
	[newImageView setFrame:CGRectOffset([self.imageView frame], 90, 0)];
	newImageView.alpha = 1;
	[UIView commitAnimations];
	
	self.imageView = newImageView;
	
	[newImageView release];
}
- (void) bounceCurrentItemRight{
	UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectOffset(self.imageView.frame, 90, 0)];
	newImageView.image = self.imageView.image;
	newImageView.contentMode = UIViewContentModeScaleAspectFit;
	newImageView.alpha = 0;
	
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.5];
	[self.imageView setFrame:CGRectOffset([self.imageView frame], 90, 0)];
	self.imageView.alpha = 0;
	[UIView commitAnimations];
	
	[self.view addSubview:newImageView];
	[UIView beginAnimations:@"new animation" context:nil];
	[UIView setAnimationDelay:.5];
	[UIView setAnimationDuration:.3];
	[newImageView setFrame:CGRectOffset([self.imageView frame], -90, 0)];
	newImageView.alpha = 1;
	[UIView commitAnimations];
	
	self.imageView = newImageView;
	
	[newImageView release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (id) initWithSelectedIndexPath:(NSIndexPath*)indexPath{
	if (self = [super init]) {
		self.selectedIndexPath = indexPath;
		
		//add gesture recognizers to the view
		
		UIGestureRecognizer *recongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
		[self.view addGestureRecognizer:recongnizer];
		[recongnizer release];
		
		recongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
		self.swipeLeftRecognizer = (UISwipeGestureRecognizer*)recongnizer;
		self.swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
		[self.view addGestureRecognizer:self.swipeLeftRecognizer];
		[recongnizer release];
	}
	return self;
}

- (id) initWithMenuItem:(menuItem*)menuItem{
	if (self = [super init]) {
		self.singleMenuItem = menuItem;
	}
	return self;
}

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

- (IBAction) setPromoItem{
	menuItem *selectedItem;
	if (self.singleMenuItem == nil) {
		selectedItem = [sharedFunctions menuItemAtIndexPath:self.selectedIndexPath];
	}
	else {
		selectedItem = self.singleMenuItem;
	}
	NSURL *requestURL = [globalURL restInfoUpdateURL];
	NSString *dataString = [NSString stringWithFormat:@"?recommend=%d",selectedItem.itemId];
	//NSLog(@"recommended:%@",dataString);
	[sharedFunctions postDataString:dataString toURL:requestURL];
}


- (void)dealloc {
	[setRecommended release];
	[appDelegate release];
	[singleMenuItem release];
	[selectedIndexPath release];
	[swipeLeftRecognizer release];
	[introTextView release];
	[imageView release];
	[itemIdLabel release];
	[priceLabel release];
	[quantityLabel release];
	[kindLabel release];
    [super dealloc];
}


@end
