//
//  MAContactsTableController.m
//  Maple
//
//  Created by Jakob Iversen on 9/10/13.
//  Copyright (c) 2021 Nouman. All rights reserved.
//

#import "MAContactsTableController.h"

#import "Contact.h"
#import "MAAppDelegate.h"
#import "MAContactsController.h"
#import "Constants.h"
#import "CoreDataHelper.h"

@interface MAContactsTableController ()

@end

NSArray *contacts;
MAContactsController *contactController;

@implementation MAContactsTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contacts = [CoreDataHelper.sharedManager loadDataFromDatabase];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    contacts = [CoreDataHelper.sharedManager loadDataFromDatabase];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Contact *contact = [contacts objectAtIndex:[indexPath row] ];
    NSString *name = [contact contactName];
    NSString *city = [contact city];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = city;
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Contact *contactToDelete = [contacts objectAtIndex:[indexPath row]];
        [CoreDataHelper.sharedManager deleteContactObject: contactToDelete];
        contacts = [CoreDataHelper.sharedManager loadDataFromDatabase];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditContact"]) {
        contactController = segue.destinationViewController;
    }
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Contact *selectedContact = [contacts objectAtIndex:[indexPath row]];
    contactController.contact = selectedContact;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int selectedRow = [indexPath row];
   // NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    Contact *selectedContact = [contacts objectAtIndex:selectedRow];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Contact Selected"
                               message:[NSString
                                        stringWithFormat:@"Selected row: %d (%@)",
                                        selectedRow, selectedContact.contactName]
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
    UIAlertAction* showDetails = [UIAlertAction actionWithTitle:@"Show Details" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        
        MAContactsController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"editContact"];
        controller.contact = selectedContact;
        [self.navigationController pushViewController:controller animated:YES];
    }];

    [alert addAction:showDetails];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
