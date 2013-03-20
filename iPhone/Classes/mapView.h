//
//  mapView.h
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "sharedFunctions.h"
#import "customMapAnnotation.h"
@interface mapView : UIViewController<MKMapViewDelegate> {
	UIBarButtonItem *closeButton;
	MKMapView *addressMapView;
	UITextView *textView;
	
	NSString *deliveryAddress;
	UISegmentedControl *segControl;
}
@property (nonatomic, retain) IBOutlet UIBarButtonItem *closeButton;
@property (nonatomic, retain) IBOutlet MKMapView *addressMapView;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, retain) NSString *deliveryAddress;
- (IBAction) dismissView;
- (void) showMap;
- (IBAction) changeMapViewType;
@end
