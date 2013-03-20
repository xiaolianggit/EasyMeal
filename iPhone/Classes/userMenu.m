//
//  userMenu.m
//  testProject
//
//  Created by Liang Xiao on 17/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "userMenu.h"


@implementation userMenu
@synthesize item,menuArray,currentElement,selectedMenuItemIndexPath;
@synthesize localCell,tableView;
@synthesize navigationController,appDelegate;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self parseMenu];
	[sharedFunctions updateMenuItemImages];
	[self.tableView becomeFirstResponder];
	
	//self.navigationItem.rightBarButtonItem = UIBarButtonSystemItemAdd;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) customInitFunction{
	NSMutableArray *tempMenuArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < 5; i++) {
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempMenuArray addObject:tempArray];
		[tempArray release];
	}
	self.menuArray = tempMenuArray;
	[tempMenuArray release];
	
	self.appDelegate = (EasyMealAppDelegate*)[[UIApplication sharedApplication] delegate];
	appDelegate.menuArray = tempMenuArray;
}

- (id) init{
	if (self = [super init]) {
		[self customInitFunction];
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		[self customInitFunction];
	}
	return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self customInitFunction];
	}
	return self;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.menuArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self.menuArray objectAtIndex:section] count];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellEditingStyleDelete;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [NSString stringWithFormat:@"[%d][%d]",indexPath.section,indexPath.row];
	userMenuCell *cell = (userMenuCell *)[atableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {	
		[[NSBundle mainBundle] loadNibNamed:@"UserMenuCell" owner:self options:nil];
		cell = localCell;
		menuItem *tempMenuItem = [sharedFunctions menuItemAtIndexPath:indexPath];
		cell.nameLabel.text = tempMenuItem.itemName;
		cell.priceLabel.text = [NSString stringWithFormat:@"$ %.1f", tempMenuItem.price];
		cell.imageView.image = [sharedFunctions localImageForIndexPath:indexPath];
	}
    return cell;	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:	return @"Main dish";	break;
		case 1:	return @"Drink";		break;
		case 2:	return @"Soup";			break;
		case 3:	return @"Dessert";		break;
		default:	return @"Other";	break;
	}

}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return appDelegate.isAdminMode;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		
		int deletedItemID = [[sharedFunctions menuItemAtIndexPath:indexPath] itemId];
		[[self.menuArray objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	
		NSURL *requestURL = [globalURL menuItemDeleteURLAtItemID:deletedItemID];
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
		[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    }  
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self showDetailView:indexPath];
	[atableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void) parseMenu{
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:appDelegate.menuItemXMLData];//create the parse and prepare with the raw data
	
	[parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	
    [parser parse]; // Parse that data..
	[parser release];// free the memory
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//called whenever a new elements is found
	if ([elementName isEqualToString:@"item"]) {//check if it's the start of a new object
		menuItem * newItem = [[menuItem alloc] init];//create a new object
		self.item = newItem;//assign the newly created object to the class's property
		[newItem release];//free the memory to avoid memory leaks
	}
	else {
		NSMutableString *tempString = [NSMutableString string];
		self.currentElement = tempString;
	}

}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//called when characters between the start and end tags are found
	[self.currentElement appendString: string];//temporarily stores the characters in a local string
}


- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	//called at the end of each element
	if ([elementName isEqualToString:@"id"])
		//compare the element name with each field and find the match
		self.item.itemId = [self.currentElement intValue];
	else if([elementName isEqualToString:@"name"])
		self.item.itemName = self.currentElement;
	else if([elementName isEqualToString:@"intro"])
		self.item.intro = self.currentElement;
	else if([elementName isEqualToString:@"price"])
		self.item.price = [self.currentElement floatValue];
	else if([elementName isEqualToString:@"quantity"])
		self.item.quantity = [self.currentElement intValue];
	else if([elementName isEqualToString:@"kind"])
		self.item.kind = [self.currentElement intValue];
	else if([elementName isEqualToString:@"item"]){
		[[self.menuArray objectAtIndex:self.item.kind] addObject:self.item];
		self.currentElement = nil;
	}
}

- (void) buttonClicked:(id)sender{
	UIButton *clickedButton = (UIButton*)sender;
	UITableViewCell *cell = (UITableViewCell*) [[clickedButton superview] superview];
	NSIndexPath *indexPathForClickedButton = [self.tableView indexPathForCell:cell];
	self.selectedMenuItemIndexPath = indexPathForClickedButton;
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Order %@, continue?",[[sharedFunctions menuItemAtIndexPath:indexPathForClickedButton] itemName]] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Ok",nil];
	[actionSheet showFromTabBar:self.tabBarController.tabBar];
	[actionSheet release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		//add that menu item to the order list
		[self addOrderItemToBasket];
	}
}

- (void) addOrderItemToBasket{	
	menuItem *selectedMenuItem = [sharedFunctions menuItemAtIndexPath:self.selectedMenuItemIndexPath];
	menuItem *menuItemInDictionary = [self.appDelegate.orderList valueForKey:[NSString stringWithFormat:@"%d",selectedMenuItem.itemId]];
	if (menuItemInDictionary != nil) {//check if the selected item already exists in the order list
		//increase the ordered quantity by 1 if it exists
		menuItemInDictionary.quantity = menuItemInDictionary.quantity + 1;
	}
	else {
		//add the new item to the order list if it's not there
		menuItem *itemToBeAddedToOrderList = [selectedMenuItem copy];
		
		[self.appDelegate.orderList setValue:itemToBeAddedToOrderList forKey:[NSString stringWithFormat:@"%d",itemToBeAddedToOrderList.itemId]];////has problem
		
		[itemToBeAddedToOrderList release];
		
		//update the badge on the tab bar
		UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:1];
		tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[self.appDelegate.orderList count]];
	}
}


- (IBAction) showDetailView:(NSIndexPath*)indexPath{
	userMenuDetailView *detailView = [[userMenuDetailView alloc] initWithSelectedIndexPath:indexPath];
	[self.navigationController pushViewController:detailView animated:YES];
	[detailView release];
}

- (void) showRandomMenuItem{
	int section = arc4random() % [self.menuArray count];
	int row = arc4random() % [[self.menuArray objectAtIndex:section] count];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	[self showDetailView:indexPath];
}


- (void)dealloc {
	[tableView release];
	[appDelegate release];
	[selectedMenuItemIndexPath release];
	[navigationController release];
	[localCell release];
	[currentElement release];
	[menuArray release];
	[item release];
    [super dealloc];
}


@end

