//
//  userInfo.m
//  testProject
//
//  Created by Liang Xiao on 24/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "userInfo.h"


@implementation userInfo
@synthesize tView,navBar,cancelButton,saveButton,localCell,stringArray,delegate;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	stringArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	[super viewWillAppear:animated];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];	
	[super viewWillDisappear:animated];
}
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	return YES;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = [NSString stringWithFormat:@"[%d]",indexPath.section];    
    textInputCell *cell = (textInputCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[[NSBundle mainBundle] loadNibNamed:@"userInfoCell" owner:self options:nil];
		cell = self.localCell;
		
		cell.tf.tag = indexPath.section + 10;
		cell.tf.text = [self.stringArray objectAtIndex:indexPath.section];
		if (indexPath.section == 3) {
			cell.tf.placeholder = @"";
		}
    }
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:	return @"Your name:";				break;
		case 1:	return @"Contact phone:";			break;
		case 2:	return @"Delivery address:";		break;
		case 3:	return @"Special wishes:";			break;
		default:	return @"Other";				break;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	textInputCell *cell = (textInputCell*)[tableView cellForRowAtIndexPath:indexPath];
	[cell.tf becomeFirstResponder];
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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

- (IBAction) cancel{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) save{
	//put editing text into array
	for (int i = 0; i<4; i++) {
		UITextField *currentTextField = (UITextField*)[self.tView viewWithTag:(i+10)];
		if ([currentTextField isFirstResponder]) {
			[stringArray replaceObjectAtIndex:i withObject:currentTextField.text];
			[currentTextField resignFirstResponder];
			break;
		}
	}
	//check if users completes everything
	for(int i = 0; i < 3; i++){
		if ([[self.stringArray objectAtIndex:i] isEqualToString:@""]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forget something?" message:@"Seems you missed some text?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			return;
		}
	}
	//prepare the data string for posting to server
	NSString *keyString[4] = {@"name=",@"phone=",@"address=",@"comment="};
	NSMutableString *dataString = [NSMutableString string];
	
	for (int count = 0; count < 4; count ++) {
		NSString *contentString = [stringArray objectAtIndex:count];
		if ([contentString length] > 0) {
			[dataString appendString:@"&"];
			[dataString appendString:keyString[count]];
			[dataString appendString:contentString];
		}
	}
	
	NSString *udidString = [[UIDevice currentDevice] uniqueIdentifier];
	[dataString appendString:@"&udid="];
	[dataString appendString:udidString];
	
	
	EasyMealAppDelegate *appDelegate = (EasyMealAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *localOrderList = appDelegate.orderList;
	menuItem *tempMenuItem;
	NSEnumerator *enumerator = [localOrderList keyEnumerator];
	id key;
	int counter = 0;
	while (key = [enumerator nextObject]) {
		tempMenuItem = [localOrderList objectForKey:key];
		NSString *keyString = [NSString stringWithFormat:@"&itemID%d=%d",counter,tempMenuItem.itemId];
		NSString *valueString = [NSString stringWithFormat:@"&quantity%d=%d",counter,tempMenuItem.quantity];
		counter++;
		[dataString appendString:keyString];
		[dataString appendString:valueString];
	}
	
	[sharedFunctions postDataString:dataString toURL:[globalURL orderListAddURL]];
	[delegate emptyBasket];
	
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Order complete!" message:@"You can view your order status in the Order tab" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
	[alertView show];
	
	[self dismissModalViewControllerAnimated:YES];
}

///scrolling code:


- (void) textFieldDidBeginEditing:(UITextField *)textField{	
	aTextField = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
	aTextField = nil;
	[stringArray replaceObjectAtIndex:(textField.tag-10) withObject:textField.text];
}

- (void) keyBoardWillShow:(NSNotification*)notification{	
	CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    
	CGRect frame = self.view.frame;
	frame.size.height -= keyboardHeight;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.5f];
	self.view.frame = frame;
	[UIView commitAnimations];
	if (aTextField) {
		UITableViewCell *cell = (UITableViewCell*) [[aTextField superview] superview];
		[tView scrollToRowAtIndexPath:[tView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}	
}
- (void) keyBoardWillHide:(NSNotification*)notification{
	CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    
	CGRect frame = self.view.frame;
	frame.size.height += keyboardHeight;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3f];
	self.view.frame = frame;
	[UIView commitAnimations];
}


- (void)dealloc {
	[stringArray release];
	//[tableFooterView release];
	[localCell release];
	[cancelButton release];
	[saveButton release];
	[navBar release];
	[tView release];
    [super dealloc];
}


@end

