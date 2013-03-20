//
//  editRestInfoView.m
//  testProject
//
//  Created by Liang Xiao on 22/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "editRestInfoView.h"

@implementation editRestInfoView
@synthesize stringArray, navBar, tView, doneButton, cancelButton;
@synthesize aCell,delegate;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	
	self.doneButton.enabled = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (id) init{
	if (self = [super init]) {
		stringArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil];
	}
	return self;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:	return @"New name";		break;
		case 1:	return @"New intro";	break;
		case 2:	return @"New location";	break;
		case 3:	return @"New phone";	break;
		default:	return @"no";		break;
	}
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
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *MyIdentifier = [NSString stringWithFormat:@"[%d]",indexPath.section];
	//static NSString *MyIdentifier = @"EditRestInfoCell";
	textInputCell *cell = (textInputCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {	
		[[NSBundle mainBundle] loadNibNamed:@"editRestInfoCell" owner:self options:nil];
		cell = aCell;
		[[cell tf] setDelegate:self];
		[cell.tf setTag:(indexPath.section+10)];
		if ([stringArray objectAtIndex:indexPath.section] != @"") {
			cell.tf.text = [stringArray objectAtIndex:indexPath.section];
		}
		if (indexPath.section == 3) {
			cell.tf.keyboardType = UIKeyboardTypePhonePad;
		}
	 }
	return cell;
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
	[cell.tf becomeFirstResponder];
		
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (IBAction) saveEdit: (id)sender{
	
	for (int i = 0; i<4; i++) {
		UITextField *currentTextField = (UITextField*)[self.tView viewWithTag:(i+10)];
		if ([currentTextField isFirstResponder]) {
			[stringArray replaceObjectAtIndex:i withObject:currentTextField.text];
			[currentTextField resignFirstResponder];
			break;
		}
	}
	
	
	NSString *tempString[4]={@"&name=",@"&intro=",@"&location=",@"&phone="};
	NSMutableString *dataString = [NSMutableString string];

	for (int count = 0; count < 4; count++) {
		NSString *stringa = [stringArray objectAtIndex:count];
		
		if ([stringa length] > 0) {			
			[dataString appendString:tempString[count]];
			[dataString appendString:stringa];
			[delegate changeInfoAtIndex:count withNewString:stringa];
		}
	}
	
	[sharedFunctions postDataString:dataString toURL:[globalURL restInfoUpdateURL]];

	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancelEdit: (id) sender{
	[self dismissModalViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField tag] == 13)
    {
        [textField setReturnKeyType:UIReturnKeyDone];
    }
    
    return YES;
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.tag < 13) {
		UITableViewCell *cell = (UITableViewCell*) [[textField superview] superview];
		[tView scrollToRowAtIndexPath:[tView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
		UIView *nextTF = [self.tView viewWithTag:(textField.tag+1)];
		[nextTF becomeFirstResponder];
	}
	else
		[textField resignFirstResponder];
	return YES;
}


- (void) doneButtonControl: (id) sender{
	UITextField *tf = (UITextField*)sender;
	if (tf.text.length > 0) {
		self.doneButton.enabled = YES;
	}
	else {
		self.doneButton.enabled = NO;
	}
}



- (void)dealloc {
	[aCell release];
	[cancelButton release];
	[doneButton release];
	[navBar release];
	[tView release];
	[stringArray release];
    [super dealloc];
}


@end

