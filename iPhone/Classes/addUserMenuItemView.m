//
//  addUserMenuItemView.m
//  testProject
//
//  Created by Liang Xiao on 01/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addUserMenuItemView.h"


@implementation addUserMenuItemView
@synthesize tView, navBar, cancelButton, saveButton,stringArray,aCell,aTextField,foodKindCell,segControl;
@synthesize tableHeaderView,tableHeaderImageView,chooseImageButton;
@synthesize imageChanged,delegate;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];	
}

- (id) init{
	stringArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil];
	self.imageChanged = NO;
	return self;
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


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:	return @"Name";		break;
		case 1:	return @"Intro";	break;
		case 2:	return @"Price";	break;
		case 3:	return @"Quantity";	break;
		case 4:	return @"Kind";		break;
		default:	return @"no";	break;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = [NSString stringWithFormat:@"[%d][%d]",indexPath.section,indexPath.row];
    
    textInputCell *cell = (textInputCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		if (indexPath.section < 4) {
			[[NSBundle mainBundle] loadNibNamed:@"addUserMenuItemCell" owner:self options:nil];
			cell = aCell;
			[cell.tf setDelegate:self];
			[cell.tf setTag:(indexPath.section+10)];
			if ([[stringArray objectAtIndex:indexPath.section] length] > 0) {
				cell.tf.text = [stringArray objectAtIndex:indexPath.section];
			}
			if (indexPath.section == 2 || indexPath.section == 3) {
				cell.tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
			}
			return cell;
		}
		else {
			return self.foodKindCell;
		}

    }
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
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
	textInputCell *cell = (textInputCell*)[tableView cellForRowAtIndexPath:indexPath];
	if (indexPath.section <4) {
		[cell.tf becomeFirstResponder];
	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

	[textField resignFirstResponder];
	return YES;
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

- (void) checkEmptyCell:(id)sender{
}

- (IBAction) cancel{
	[self dismissModalViewControllerAnimated:YES];
}
- (IBAction) save{
	//store all editing data into array
	for (int i = 0; i<4; i++) {
		UITextField *currentTag = (UITextField*)[self.tView viewWithTag:(i+10)];
		if ([currentTag isFirstResponder]) {
			[stringArray replaceObjectAtIndex:i withObject:currentTag.text];
			[currentTag resignFirstResponder];
			break;
		}
	}
	//check if all textfields have content
	BOOL formCompleteStatus = YES;
	for (id tempString in stringArray){
		if ([(NSString*)tempString length] == 0) {			
			formCompleteStatus = NO;
			break;
		}
	}
	//prompt user for black textfield and stop function
	if (formCompleteStatus == NO) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forget something?" message:@"Seems you missed some text?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}

	//put things into url request body
	NSString *tempString[4]={@"name=",@"intro=",@"price=",@"quantity="};
	NSMutableString *dataString = [NSMutableString string];
	
	for (int count = 0; count < 4; count++) {
		NSString *contentString = [stringArray objectAtIndex:count];
		
		if ([contentString length] > 0) {
			[dataString appendString:@"&"];
			[dataString appendString:tempString[count]];
			[dataString appendString:contentString];
		}
	}
	[dataString appendString:[NSString stringWithFormat:@"&kind=%d",[self.segControl selectedSegmentIndex]]];

	NSData *returnData = [sharedFunctions postDataString:dataString toURL:[globalURL menuItemAddURL]];
	
	NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
	int returnItemId = [returnString intValue];
	NSLog(@"returned item id:%d",returnItemId);
	//check if valid item id is returnd
	if (returnItemId > 0) {
		//start uploading image
		if (imageChanged) {
			[self uploadImageWithItemId:returnItemId];
			///////////also write the image data to file
			NSData *dataToBeWrittenToFile = UIImageJPEGRepresentation(self.tableHeaderImageView.image, 80);
			NSString *folderPathForMenuItemPic = [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
			NSString *filePath = [NSString stringWithFormat:@"%@/%d.jpg",folderPathForMenuItemPic,returnItemId];
			[dataToBeWrittenToFile writeToFile:filePath atomically:YES];
		}
	}
	
	///add the newly created menu item to the user menu view
	menuItem *newlyAddedMenuItem = [[menuItem alloc] init];
	newlyAddedMenuItem.itemId = returnItemId;
	newlyAddedMenuItem.itemName = [stringArray objectAtIndex:0];
	newlyAddedMenuItem.intro = [stringArray objectAtIndex:1];
	newlyAddedMenuItem.price = [[stringArray objectAtIndex:2] floatValue];
	newlyAddedMenuItem.quantity = [[stringArray objectAtIndex:3] intValue];
	newlyAddedMenuItem.kind = [self.segControl selectedSegmentIndex];
	EasyMealAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[[appDelegate.menuArray objectAtIndex:newlyAddedMenuItem.kind] addObject:newlyAddedMenuItem];
	[newlyAddedMenuItem release];
	
	[delegate updateUserMenu];
	[self dismissModalViewControllerAnimated:YES];
}


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

- (IBAction) chooseImage{
	UIImagePickerController *pickerController = [[[UIImagePickerController alloc] init] autorelease];
	pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	pickerController.delegate = self;
	pickerController.allowsEditing = YES;
	[self presentModalViewController:pickerController animated:YES];
}

- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)img editingInfo:(NSDictionary*)editInfo{
	self.imageChanged = YES;
	self.tableHeaderImageView.image = img;
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}


- (void) uploadImageWithItemId:(int)itemId{
	NSURL *url = [globalURL menuItemPicUploaderURLAtItemID:itemId];
	[sharedFunctions uploadImage:self.tableHeaderImageView.image toURL:url];
	[self dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[chooseImageButton release];
	[tableHeaderView release];
	[tableHeaderImageView release];
	[segControl release];
	[foodKindCell release];
	[aTextField release];
	[aCell release];
	[stringArray release];
	[cancelButton release];
	[saveButton release];
	[navBar release];
	[tView release];
    [super dealloc];
}


@end

