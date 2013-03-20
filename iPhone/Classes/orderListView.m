//
//  orderListView.m
//  testProject
//
//  Created by Liang Xiao on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "orderListView.h"


@implementation orderListView
@synthesize tableView,localOrderItem,currentItem,orderArray,currentItemID,currentQuantity,localCell,navigationController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Orders";
	NSMutableArray *tempArray = [NSMutableArray array];
	self.orderArray = tempArray;
	[self parseOrderList];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.orderArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    customOrderListViewCell *cell = (customOrderListViewCell*)[atableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"customOrderListViewCell" owner:self options:nil];
		cell = localCell;
    }
    
    // Configure the cell...
	orderItem *tempOrderItem = [self.orderArray objectAtIndex:indexPath.row];
    cell.name.text = tempOrderItem.customerName;
	cell.orderID.text = [NSString stringWithFormat:@"ID: %d", tempOrderItem.orderID];
	cell.date.text = tempOrderItem.orderDate;
	[cell.status removeFromSuperview];
	cell.status = [self createLabelForStatus:tempOrderItem.status inFrame:cell.status.frame];
	[cell addSubview:cell.status];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


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

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	orderItem *tempOrderItem = [self.orderArray objectAtIndex:indexPath.row];
    orderDetailView *detailView = [[[orderDetailView alloc] initWithOrderItem:tempOrderItem]autorelease];
	[self.navigationController pushViewController:detailView animated:YES];
	[_tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (void) parseOrderList{
	[self.orderArray removeAllObjects];
	NSURL *url = [globalURL orderListGetURL];//XML location
	NSData *tempURLData = [NSData dataWithContentsOfURL:url];//get data from URL

	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:tempURLData];//declare the parser
	
	[parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	
    [parser parse]; // Parse that data..
	[parser release];//free memory
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	[self.currentItem appendString: string];//temporarily saves the string
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	NSMutableString *tempString = [NSMutableString string];
	self.currentItem = tempString;
	
	if ([elementName isEqualToString:@"order"]) {
		orderItem *newOrderItem = [[[orderItem alloc] init] autorelease];
		self.localOrderItem = newOrderItem;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"orderID"])
		self.localOrderItem.orderID = [self.currentItem intValue];
	
	else if ([elementName isEqualToString:@"name"]) 
		self.localOrderItem.customerName = self.currentItem;
	
	else if([elementName isEqualToString:@"phone"])
		self.localOrderItem.contactPhone = self.currentItem;
	
	else if([elementName isEqualToString:@"address"])
		self.localOrderItem.deliveryAddress = self.currentItem;
	
	else if([elementName isEqualToString:@"date"])
		self.localOrderItem.orderDate = self.currentItem;
	
	else if([elementName isEqualToString:@"comment"])
		self.localOrderItem.comment = self.currentItem;
	
	else if([elementName isEqualToString:@"status"])
		self.localOrderItem.status = [self.currentItem intValue];
	
	else if([elementName isEqualToString:@"itemID"])
		self.currentItemID = [self.currentItem intValue];
	
	else if([elementName isEqualToString:@"quantity"])
		self.currentQuantity = [self.currentItem intValue];
	
	else if([elementName isEqualToString:@"item"]){
		menuItem *tempItem = [[sharedFunctions menuItemForItemID:self.currentItemID]copy];	
		if (tempItem) {
			tempItem.quantity = self.currentQuantity;
			[self.localOrderItem.menuItemList addObject:tempItem];
		}
		else {
			[self.localOrderItem.menuItemList addObject:[NSNull null]];
		}

		[tempItem release];
	}
	
	else if([elementName isEqualToString:@"order"]){
		[self.orderArray addObject:self.localOrderItem];
	}
	self.currentItem = nil;
}

- (UILabel*)createLabelForStatus:(int)status inFrame:(CGRect)frame{
	UILabel *label = [[[UILabel alloc] initWithFrame:frame]autorelease];
	switch (status) {
		case -1:
			label.text = @"Void";
			label.textColor = [UIColor redColor];
			break;
		case 0:
			label.text = @"Pending";
			label.textColor = [UIColor grayColor];
			break;
		case 1:
			label.text = @"Confirmed";
			label.textColor = [UIColor magentaColor];
			break;
		case 2:
			label.text = @"Prepared";
			label.textColor = [UIColor blueColor];
			break;
		case 3:
			label.text = @"Completed";
			label.textColor = [UIColor greenColor];
			break;
		default:
			break;
	}
	return label;
}



- (void)dealloc {
	[navigationController release];
	[localCell release];
	[orderArray release];
	[currentItem release];
	[localOrderItem release];
	[tableView release];
    [super dealloc];
}


@end

