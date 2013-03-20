//
//  welcome.m
//  testProject
//
//  Created by Liang Xiao on 14/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "welcome.h"


@implementation welcome
@synthesize nameLabel,phoneLabel,locationLabel,introLabel,phoneContent,locationContent,introContent;
@synthesize currentElement;
@synthesize editInfoButton,callButton;
@synthesize imageView;
@synthesize changePicButton,scrollView,showLocationButton,adminLoginButton,appDelegate;
@synthesize latestLabel,recommendedLabel,latestImageView,recommendedImageView;
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
	
	self.appDelegate = (EasyMealAppDelegate*)[[UIApplication sharedApplication] delegate];
	[self parseXMLData];
	self.scrollView.contentSize = CGSizeMake(320, 800);
	
	UIBarButtonItem *barButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(userLogin:)]autorelease];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	
	[self.adminLoginButton becomeFirstResponder];
	[self showPromoItem];
}


- (void) downloadImage:(NSString*)filename{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];//added for multithreading
	assert (pool!=nil);//added for multithreading
	NSString *oldPicFile = [[folderPath restPicturePath] stringByAppendingFormat:@"/restPic.jpg"];
	NSData *imageDataFromServer = [NSData dataWithContentsOfURL:[globalURL restInfoPicURL]];
	if (imageDataFromServer) {
		self.imageView.image = [UIImage imageWithData:imageDataFromServer];
		[imageDataFromServer writeToFile:oldPicFile atomically:YES];
		NSString *picVersionStringPath = [[folderPath restPicturePath] stringByAppendingString:@"/picversion"];
		[filename writeToFile:picVersionStringPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	else {
		UIImage *localImage = [UIImage imageWithContentsOfFile:oldPicFile];
		self.imageView.image = localImage;
	}

	[pool drain];//add for multithreading, clear allocated memory space
}

- (void) updateLocalImageWithFilename:(NSString*)filename{
	NSString *restPicPath = [folderPath restPicturePath];
	NSString *oldPicFile = [restPicPath stringByAppendingString:@"/restPic.jpg"];
	NSString *picVersionStringPath = [restPicPath stringByAppendingString:@"/picversion"];
	NSString *localPicVersion = [NSString stringWithContentsOfFile:picVersionStringPath encoding:NSUTF8StringEncoding error:nil];
	if ([filename isEqualToString:localPicVersion]) {
		UIImage *localImage = [UIImage imageWithContentsOfFile:oldPicFile];
		self.imageView.image = localImage;
		return;		
	}
	else {//can't get image data from server
		  //maintain the original image and image version
		[self performSelectorInBackground:@selector(downloadImage:) withObject:filename];
	}
}

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


- (IBAction) userLogin:(id)sender{
	menuBasketTabViewController *newTabBarView = [[menuBasketTabViewController alloc] init];
	[self.navigationController pushViewController:newTabBarView animated:YES];
	[newTabBarView release];
}

- (IBAction) adminLogin:(id)sender{
	if (self.appDelegate.isAdminMode) {
		
		UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:@"Logout of admin mode?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Logout",nil] autorelease];
		[actionSheet showInView:self.view];
		
	}
	else {
		//[self changeAdminButtonStatus:YES];
		
		adminAuthen *authenView = [[[adminAuthen alloc] init]autorelease];
		authenView.delegate = self;
		[self presentModalViewController:authenView animated:YES];
	}

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[self changeAdminButtonStatus:NO];
		self.adminLoginButton.hidden = YES;
	}
}

- (void) parseXMLData{
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.appDelegate.restInfoXMLData];//declare the parser
	
	[parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	
    [parser parse]; // Parse that data..
	[parser release];//free memory
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	[self.currentElement appendString: string];//temporarily saves the string
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	NSMutableString *tempString = [NSMutableString string];
	self.currentElement = tempString;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"name"]) {
		self.nameLabel.text = self.currentElement;
	}
	else if([elementName isEqualToString:@"intro"]){
		self.introContent.text = self.currentElement;
	}
	else if([elementName isEqualToString:@"location"]){
		self.locationContent.text = self.currentElement;
	}
	else if([elementName isEqualToString:@"phone"]){
		self.phoneContent.text = self.currentElement;
	}
	else if([elementName isEqualToString:@"picversion"]){
		[self updateLocalImageWithFilename:self.currentElement];
	}
	self.currentElement = nil;
}
- (IBAction) editInfo{
	editRestInfoView *view = [[[editRestInfoView alloc] init] autorelease];
	view.delegate = self;
	[self presentModalViewController:view animated:YES];
}

- (IBAction) changePic{
	changeRestImageView *changeView = [[[changeRestImageView alloc] init] autorelease];
	changeView.delegate = self;
	[self presentModalViewController:changeView animated:YES];
}

- (IBAction) showMapView{
	MKMapView *locationMapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, 530, 280, 220)];
	locationMapView.hidden = NO;
	locationMapView.delegate = self;
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = .005;
	span.longitudeDelta = .005;
	region.span = span;

	CLLocationCoordinate2D mapCoordinate = [sharedFunctions locationCoordinateForAddressString:self.locationContent.text];
	region.center = mapCoordinate;
	[self.view addSubview:locationMapView];
	[locationMapView setCenterCoordinate:mapCoordinate animated:YES];
	[locationMapView setRegion:region animated:YES];
	customMapAnnotation *newAnnotation = [[customMapAnnotation alloc] initWithCoordinate:mapCoordinate title:self.nameLabel.text];
	[locationMapView addAnnotation:newAnnotation];
	[newAnnotation release];
}


- (void)showPromoItem{
	NSString *serverResponseString = [NSString stringWithContentsOfURL:[globalURL promoItemGetURL] encoding:NSUTF8StringEncoding error:nil];
	NSArray *contentsArray = [serverResponseString componentsSeparatedByString:@","];

	if (contentsArray) {
	//if (NO) {
		self.recommendedLabel.text = [contentsArray objectAtIndex:1];
		self.latestLabel.text = [contentsArray objectAtIndex:3];
		int recommended = [[contentsArray objectAtIndex:0] intValue];
		int latest = [[contentsArray objectAtIndex:2] intValue];
		UIImage *recommendedImage = [sharedFunctions localImageForItemID:recommended];
		UIImage *latestImage = [sharedFunctions localImageForItemID:latest];
		if (recommendedImage == nil) {
			NSData *tempImageData = [NSData dataWithContentsOfURL:[globalURL menuItemPicURLAtItemID:recommended]];
			if (tempImageData) {
				recommendedImage = [UIImage imageWithData:tempImageData];
				NSString *filePath = [[folderPath menuItemPicPath] stringByAppendingFormat:@"/%d.jpg",recommended];
				[tempImageData writeToFile:filePath atomically:YES];
			}
		}
		if (latestImage == nil) {
			NSData *tempImageData = [NSData dataWithContentsOfURL:[globalURL menuItemPicURLAtItemID:latest]];
			if (tempImageData) {
				latestImage = [UIImage imageWithData:tempImageData];
				NSString *filePath = [[folderPath menuItemPicPath] stringByAppendingFormat:@"/%d.jpg",latest];
				[tempImageData writeToFile:filePath atomically:YES];
			}
		}
		self.recommendedImageView.image = recommendedImage;
		self.latestImageView.image = latestImage;
	}
}

/////delegate methods:
- (void) refreshRestPic{
	NSString *restPicPath = [[folderPath restPicturePath] stringByAppendingPathComponent:@"/restPic.jpg"];
	NSData *newImageData = [NSData dataWithContentsOfFile:restPicPath];
	UIImageView *newImageView = [[[UIImageView alloc] initWithFrame:self.imageView.frame]autorelease];
	newImageView.image = [UIImage imageWithData:newImageData];
	newImageView.alpha = 0;
	newImageView.contentMode = UIViewContentModeScaleAspectFit;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:.8];
	self.imageView.alpha = 0;
	[UIView commitAnimations];
		
	self.imageView = newImageView;
	[self.view addSubview:self.imageView];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelay:1];
	[UIView setAnimationDuration:1];
	self.imageView.alpha = 1;
	[UIView commitAnimations];
}

- (void) changeInfoAtIndex:(int)index withNewString:(NSString*)string{
	switch (index) {
		case 0:
			self.nameLabel.text = string;
			break;
		case 1:
			self.introContent.text = string;
			break;
		case 2:
			self.locationContent.text = string;
			break;
		case 3:
			self.phoneContent.text = string;
			break;
		default:
			break;
	}
}

- (void) changeAdminButtonStatus:(BOOL)isAdminMode{
	self.changePicButton.hidden = !isAdminMode;
	self.editInfoButton.hidden = !isAdminMode;
	self.appDelegate.isAdminMode=isAdminMode;
}

- (IBAction) callNumber{
	NSURL *callURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phoneContent.text]];
	[[UIApplication sharedApplication] openURL:callURL];
	NSLog(@"tel");
}


- (void)dealloc {
	[latestLabel release];
	[recommendedLabel release];
	[latestImageView release];
	[recommendedImageView release];
	[callButton release];
	[appDelegate release];
	[adminLoginButton release];
	[showLocationButton release];
	[scrollView release];
	[changePicButton release];
	[imageView release];
	[editInfoButton release];
	[nameLabel release];
	[phoneLabel release];
	[phoneContent release];
	[locationContent release];
	[locationLabel release];
	[introContent release];
	[introLabel release];
	[currentElement release];
    [super dealloc];
}


@end
