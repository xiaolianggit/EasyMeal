//
//  adminAuthen.m
//  EasyMeal
//
//  Created by Liang Xiao on 07/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "adminAuthen.h"


@implementation adminAuthen
@synthesize usernameLabel,passwordLabel,usernameCell,passwordCell,usernameTF,passwordTF,tableView,cancel,go;
@synthesize delegate;

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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }*/
	if (indexPath.row) {
		return self.passwordCell;
	}
	else {
		return self.usernameCell;
	}

    
    // Configure the cell...
    
    //return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	[_tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 1) {
		[self.passwordTF becomeFirstResponder];
	}
	else {
		[self.usernameTF becomeFirstResponder];
	}

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if (textField == self.passwordTF) {
		[textField resignFirstResponder];
		[self authenticate];
	}
	else {
		[self.passwordTF becomeFirstResponder];
	}
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
- (IBAction) dismissView{
	[self dismissModalViewControllerAnimated:YES];
}
- (IBAction) authenticate{
	if ([self.usernameTF.text length] < 1 || [self.passwordTF.text length] < 1) {
		UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Missing something?" message:@"You need both username and password to login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
		[alertView show];
		return;
	}
	NSString *dataString = [NSString stringWithFormat:@"username=%@&password=%@",self.usernameTF.text,self.passwordTF.text];
	NSData *returnedData = [sharedFunctions postDataString:dataString toURL:[globalURL authenURL]];
	NSString *response = [[NSString alloc] initWithData:returnedData encoding:NSUTF8StringEncoding];
	NSLog(@"%@",response);
	if (![response isEqualToString:@"yes"]) {
		UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Admin login failed" message:@"Please check your username and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
		[alertView show];
		return;
	}
	
	[delegate changeAdminButtonStatus:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
	[cancel release];
	[go release];
	[tableView release];
	[usernameLabel release];
	[passwordLabel release];
	[usernameCell release];
	[passwordCell release];
	[usernameTF release];
	[passwordTF release];
    [super dealloc];
}


@end

