/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import "MGFilterBar.h"
#import "MGConst.h"
#import "AMButtonBarItem.h"

#define MGALL @"all"
#define MGINCOME @"income"
#define MGEXPENSE @"expense"
#define MGTRANSFER @"transfer"
#define MGUNASSIGNED @"unassigned"
#define MGRECONCILED @"reconciled"
#define MGNOTRECONCILED @"not_reconciled"

@implementation MGFilterBar
- (id)initWithPyParent:(id)aPyParent view:(AMButtonBar *)aView forEntryTable:(BOOL)forEntryTable
{
    NSString *pyClassName = forEntryTable ? @"PyEntryFilterBar" : @"PyTransactionFilterBar";
    self = [super initWithPyClassName:pyClassName pyParent:aPyParent];
    view = [aView retain];
    AMButtonBarItem *item = [[[AMButtonBarItem alloc] initWithIdentifier:MGALL] autorelease];
	[item setTitle:TR(@"All")];
	[view insertItem:item atIndex:0];
	item = [[[AMButtonBarItem alloc] initWithIdentifier:MGINCOME] autorelease];
	[item setTitle:forEntryTable ? TR(@"Increase") : TR(@"Income")];
	[view insertItem:item atIndex:1];
	item = [[[AMButtonBarItem alloc] initWithIdentifier:MGEXPENSE] autorelease];
	[item setTitle:forEntryTable ? TR(@"Decrease") : TR(@"Expenses")];
	[view insertItem:item atIndex:2];
    item = [[[AMButtonBarItem alloc] initWithIdentifier:MGTRANSFER] autorelease];
    [item setTitle:TR(@"Transfers")];
    [view insertItem:item atIndex:3];
    item = [[[AMButtonBarItem alloc] initWithIdentifier:MGUNASSIGNED] autorelease];
    [item setTitle:TR(@"Unassigned")];
    [view insertItem:item atIndex:4];
    item = [[[AMButtonBarItem alloc] initWithIdentifier:MGRECONCILED] autorelease];
    [item setTitle:TR(@"Reconciled")];
    [view insertItem:item atIndex:5];
    item = [[[AMButtonBarItem alloc] initWithIdentifier:MGNOTRECONCILED] autorelease];
    [item setTitle:TR(@"Not Reconciled")];
    [view insertItem:item atIndex:6];
    [view selectItemWithIdentifier:MGALL];
	[view setDelegate:self];
    return self;
}

- (void)dealloc
{
    [view release];
    [super dealloc];
}

/* HSGUIController */

- (PyFilterBarBase *)py
{
    return (PyFilterBarBase *)py;
}

- (NSView *)view
{
    return view;
}

/* Delegate */

- (void)buttonBarSelectionDidChange:(NSNotification *)aNotification
{
    NSArray *selectedItems = [[aNotification userInfo] objectForKey:@"selectedItems"];
        NSString *selected = [selectedItems objectAtIndex:0];
        [[self py] setFilterType:selected];
}

/* Python --> Cocoa */

- (void)disableTransfers
{
    [[[view items] objectAtIndex:3] setEnabled:NO];
}

- (void)enableTransfers
{
    [[[view items] objectAtIndex:3] setEnabled:YES];
}

- (void)refresh
{
    [view selectItemWithIdentifier:[[self py] filterType]];
}

@end