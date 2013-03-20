//
//  welcome.h
//  testProject
//
//  Created by Liang Xiao on 14/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "globalURL.h"
#import "editRestInfoView.h"
#import "changeRestImageView.h"
#import "menuBasketTabViewController.h"
#import "customMapAnnotation.h"
#import "orderListView.h"
#import "folderPath.h"
#import "customAdminLoginButton.h"
#import "adminAuthen.h"
#import "EasyMealAppDelegate.h"

@protocol welcomeViewDelegate

- (void) refreshRestPic;
- (void) changeInfoAtIndex:(int)index withNewString:(NSString*)string;
- (void) changeAdminButtonStatus:(BOOL)isAdminMode;

@end


@interface welcome : UIViewController <NSXMLParserDelegate,MKMapViewDelegate,welcomeViewDelegate,UIActionSheetDelegate>  {
	UIScrollView *scrollView;
	
	UIButton *editInfoButton,*changePicButton,*showLocationButton,*callButton;
	UILabel *nameLabel,*phoneLabel,*locationLabel,*introLabel,*phoneContent,*locationContent,*introContent;
	
	NSMutableString *currentElement;
	
	UIImageView *imageView;
	customAdminLoginButton *adminLoginButton;
	
	EasyMealAppDelegate *appDelegate;
	
	UILabel *latestLabel,*recommendedLabel;
	UIImageView *latestImageView,*recommendedImageView;

}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *locationLabel;
@property (nonatomic, retain) IBOutlet UILabel *introLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneContent;
@property (nonatomic, retain) IBOutlet UILabel *introContent;
@property (nonatomic, retain) IBOutlet UILabel *locationContent;
@property (nonatomic, retain) NSMutableString *currentElement;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *changePicButton,*showLocationButton,*editInfoButton,*callButton;
@property (nonatomic, retain) IBOutlet customAdminLoginButton *adminLoginButton;
@property (nonatomic, retain) EasyMealAppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UILabel *latestLabel,*recommendedLabel;
@property (nonatomic, retain) IBOutlet UIImageView *latestImageView,*recommendedImageView;
- (IBAction) userLogin:(id)sender;
- (IBAction) adminLogin:(id)sender;
- (void) parseXMLData;
- (IBAction) editInfo;
- (IBAction) changePic;
- (IBAction) showMapView;
- (void) downloadImage:(NSString*)filename;
- (IBAction) callNumber;
- (void)showPromoItem;
@end
