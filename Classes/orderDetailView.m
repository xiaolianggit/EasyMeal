//
//  orderDetailView.m
//  EasyMeal
//
//  Created by Liang Xiao on 08/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "orderDetailView.h"


@implementation orderDetailView
@synthesize localOrderItem,tableView;



- (id) initWithOrderItem:(orderItem*)item{
	if (self = [super init]) {
		self.localOrderItem = item;
	}
	self.title = @"View order details";
	return self;
}
#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return 7;
	}
	else if (section == 1)
		return [self.localOrderItem.menuItemList count] + 1;
	else {
		return 1;
	}

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = [NSString stringWithFormat:@"[%d][%d]",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.section == 0) {
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"Order ID";
				cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.localOrderItem.orderID];
				break;
			case 1:
				cell.textLabel.text = @"Status";
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				[self updateOrderStatusWithCell:cell];
				break;
			case 2:
				cell.textLabel.text = @"Date";
				cell.detailTextLabel.text = self.localOrderItem.orderDate;
				break;
			case 3:
				cell.textLabel.text = @"Customer Name";
				cell.detailTextLabel.text = self.localOrderItem.customerName;
				break;
			case 4:
				cell.textLabel.text = @"Contact Phone";
				cell.detailTextLabel.text = self.localOrderItem.contactPhone;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			case 5:
				cell.textLabel.text = @"Address";
				cell.detailTextLabel.text = self.localOrderItem.deliveryAddress;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
			case 6:
				cell.textLabel.text = @"Comment";
				cell.detailTextLabel.text = self.localOrderItem.comment;
				break;
			default:
				break;
		}
	}
	else if(indexPath.section == 1){
		if (indexPath.row == [self.localOrderItem.menuItemList count]) {
			cell.textLabel.text = @"Total:";
			cell.textLabel.textColor = [UIColor redColor];
			float totalAmount = 0;
			for (menuItem *item in self.localOrderItem.menuItemList){
				if (item != [NSNull null]) {
					totalAmount += item.price * item.quantity;
				}
			}
			cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.1f", totalAmount];
			cell.detailTextLabel.textColor = [UIColor redColor];
		}
		else {
			menuItem *tempMenuItem = [self.localOrderItem.menuItemList objectAtIndex:indexPath.row];
			if (tempMenuItem != [NSNull null]) {
				cell.textLabel.text = tempMenuItem.itemName;
				cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.1fx%d",tempMenuItem.price,tempMenuItem.quantity];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			else {
				cell.textLabel.text = @"This item has been removed";
				cell.textLabel.textColor = [UIColor grayColor];
			}

		}
	}
    // Configure the cell...
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section) {
		return @"Order contents:";
	}
	else {
		return @"Contact information:";
	}

	
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
	[_tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (!indexPath.section) {
		EasyMealAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		if (appDelegate.isAdminMode) {
			if (indexPath.row == 1) {
				UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:@"Change order status to" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Void",@"Pending",@"Confirmed",@"Prepared",@"Completed",nil] autorelease];
				[actionSheet showInView:self.view];
			}
			else if (indexPath.row == 4) {
				UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Contact customer" message:[NSString stringWithFormat: @"Call %d, continue?",self.localOrderItem.contactPhone] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call",nil] autorelease];
				[alertView show];
			}
			else if(indexPath.row == 5){
				mapView *newView = [[[mapView alloc] init] autorelease];
				newView.deliveryAddress = self.localOrderItem.deliveryAddress;
				[self presentModalViewController:newView animated:YES];
			}
		}
	}
	else {
		if (indexPath.row != [self.localOrderItem.menuItemList count]) {
			id tempMenuItem = [self.localOrderItem.menuItemList objectAtIndex:indexPath.row];
			if (tempMenuItem != [NSNull null]) {
				userMenuDetailView *detailView = [[[userMenuDetailView alloc] initWithMenuItem:(menuItem*)tempMenuItem]autorelease];
				[self.navigationController pushViewController:detailView animated:YES];
			}
		}
	}

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSLog(@"%d",buttonIndex);
	self.localOrderItem.status = buttonIndex - 1;
	[self updateOrderStatusWithCell:nil];
	NSURL *requestURL = [globalURL orderStatusUpdateURLForOrderID:self.localOrderItem.orderID newStatus:buttonIndex-1];
	[sharedFunctions postDataString:nil toURL:requestURL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex) {
		NSURL *callPhoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.localOrderItem.contactPhone]];
		[[UIApplication sharedApplication] openURL:callPhoneURL];
	}
}

- (void) updateOrderStatusWithCell:(UITableViewCell*)cell{
	if (!cell) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
		cell = [self.tableView cellForRowAtIndexPath:indexPath];
	}
	switch (self.localOrderItem.status) {
		case -1:
			cell.detailTextLabel.text = @"Void";
			cell.detailTextLabel.textColor = [UIColor redColor];
			break;
		case 0:
			cell.detailTextLabel.text = @"Pending";
			cell.detailTextLabel.textColor = [UIColor grayColor];
			break;
		case 1:
			cell.detailTextLabel.text = @"Confirmed";
			cell.detailTextLabel.textColor = [UIColor magentaColor];
			break;
		case 2:
			cell.detailTextLabel.text = @"Prepared";
			cell.detailTextLabel.textColor = [UIColor blueColor];
			break;
		case 3:
			cell.detailTextLabel.text = @"Completed";
			cell.detailTextLabel.textColor = [UIColor greenColor];
			break;
		default:
			break;
	}
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


- (void)dealloc {
	[tableView release];
	[localOrderItem release];
    [super dealloc];
}


@end

