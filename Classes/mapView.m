//
//  mapView.m
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mapView.h"


@implementation mapView
@synthesize closeButton,addressMapView,textView,deliveryAddress,segControl;
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
	self.textView.text = self.deliveryAddress;
	[self showMap];
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

- (IBAction) dismissView{
	[self dismissModalViewControllerAnimated:YES];
}

- (void) showMap{
	self.addressMapView.delegate = self;
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = .005;
	span.longitudeDelta = .005;
	region.span = span;
	
	CLLocationCoordinate2D mapCoordinate = [sharedFunctions locationCoordinateForAddressString:self.deliveryAddress];
	region.center = mapCoordinate;
	[self.addressMapView setCenterCoordinate:mapCoordinate animated:YES];
	[self.addressMapView setRegion:region animated:YES];
	customMapAnnotation *newAnnotation = [[customMapAnnotation alloc] initWithCoordinate:mapCoordinate title:nil];
	[self.addressMapView addAnnotation:newAnnotation];
	[newAnnotation release];
}

- (IBAction) changeMapViewType{
	
	self.addressMapView.mapType = self.segControl.selectedSegmentIndex;
}


- (void)dealloc {
	[segControl release];
	[deliveryAddress release];
	[closeButton release];
	[addressMapView release];
	[textView release];
    [super dealloc];
}


@end
