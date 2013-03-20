//
//  userBasketListView.m
//  testProject
//
//  Created by Liang Xiao on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "userBasketListView.h"


@implementation userBasketListView
@synthesize appDelegate,menuArray,navigationController,localCell;
@synthesize proceedTableViewCell,proceedButton,tableView,delegate;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.appDelegate = (EasyMealAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *tempDictionary = self.appDelegate.orderList;
	self.menuArray = [tempDictionary allValues];
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) updateMenuArray{
	NSMutableDictionary *tempDictionary = self.appDelegate.orderList;
	self.menuArray = [tempDictionary allValues];
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 1) {
		return 2;
	}
	else {
		//NSMutableDictionary *array = appDelegate.orderList;
		return [self.menuArray count];
	}
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Items";
	}
	else {
		return @"Total";
	}

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    basketViewCell *cell = (basketViewCell*) [atableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {	
		if (indexPath.section == 1 && indexPath.row == 0) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"identifier"] autorelease];
		}else {
			[[NSBundle mainBundle] loadNibNamed:@"basketViewCell" owner:self options:nil];
			cell = self.localCell;
		}		
    }
	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			float totalPrice = [self calculateTotalPrice];
			cell.textLabel.text = @"Total amout:";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.1f",totalPrice];
			return cell;
		}
		else {
			return self.proceedTableViewCell;
		}
	}
	else {
		menuItem *tempMenuItem = [self.menuArray objectAtIndex:indexPath.row];
		cell.nameLabel.text = tempMenuItem.itemName;
		cell.unitPriceLabel.text = [NSString stringWithFormat:@"$ %.1f",tempMenuItem.price];
		cell.quantityLabel.text = [NSString stringWithFormat:@"Quantity: %d",tempMenuItem.quantity];
		int quantity = tempMenuItem.quantity;
		float unitPrice = tempMenuItem.price;
		float sumPrice = quantity * unitPrice;
		cell.sumPriceLabel.text = [NSString stringWithFormat:@"Sub total: %.2f",sumPrice];
		UIImage *localImage = [sharedFunctions localImageForItemID:tempMenuItem.itemId];
		if (localImage) {//check if local image is nil
						 //if not nil assign it to image view
			cell.imageView.image = localImage;
		}
		else {//local image not exist replace it with default
			cell.imageView.image = [UIImage imageNamed:@"unavailable"];
		}

	}
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0) {
		return 70;
	}
	else {
		return 40;
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

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	
	[atableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.section == 0) {
		menuItem *tempItem = [self.menuArray objectAtIndex:indexPath.row];
		userMenuDetailView *detailView = [[userMenuDetailView alloc] initWithMenuItem:tempItem];
		[self.navigationController pushViewController:detailView animated:YES];
		[detailView release];
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

- (float) calculateTotalPrice{
	NSMutableDictionary *dictionary = appDelegate.orderList;
	NSEnumerator *enumerator = [dictionary keyEnumerator];
	float totalPrice = 0;
	id key;
	while (key = [enumerator nextObject]) {
		menuItem *tmp = [dictionary objectForKey:key];
		totalPrice += tmp.quantity * tmp.price;
	}
	return totalPrice;
}

- (IBAction) proceed{
	if ([appDelegate.orderList count] == 0) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Want to order NOTHING?" message:@"Or forgot to push your meal in the basket?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
	}
	userInfo *userInforView = [[userInfo alloc] init];
	userInforView.delegate = self.delegate;
	[self.navigationController presentModalViewController:userInforView animated:YES];
	[userInforView release];
}


- (void)dealloc {
	[tableView release];
	[proceedTableViewCell release];
	[proceedButton release];
	[localCell release];
	[navigationController release];
	[menuArray release];
	[appDelegate release];
    [super dealloc];
}


@end

