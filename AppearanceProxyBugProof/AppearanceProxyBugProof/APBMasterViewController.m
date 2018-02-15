//
//  APBMasterViewController.m
//  AppearanceProxyBugProof
//
//  Created by Ellen Shapiro on 11/21/13.
//  Copyright (c) 2013 VOKAL. All rights reserved.
//

#import "APBMasterViewController.h"

#import "APBDetailViewController.h"

@import MessageUI;

@interface APBMasterViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate> {
    NSMutableArray *_objects;
}
@end

@implementation APBMasterViewController


- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


- (IBAction)sendEmail:(id)sender
{
    MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
    [emailVC setSubject:@"LOOK UP ^^"];
    [emailVC setMailComposeDelegate:self];
    [self presentViewController:emailVC animated:YES completion:nil];
}

- (IBAction)sendSMS:(id)sender
{
    MFMessageComposeViewController *smsVC = [[MFMessageComposeViewController alloc] init];
    [smsVC setBody:@"LOOK UP ^^"];
    [smsVC setMessageComposeDelegate:self];
    [self presentViewController:smsVC animated:YES completion:nil];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
