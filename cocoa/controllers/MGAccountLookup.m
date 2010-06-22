/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import "MGAccountLookup.h"
#import "MGConst.h"

@implementation MGAccountLookup
- (id)initWithPyParent:(id)aPyParent
{
    self = [super initWithClassName:@"PyAccountLookup" pyParent:aPyParent];
    [[self window] setTitle:TR(@"Account Lookup")];
    return self;
}

- (PyAccountLookup *)py
{
    return (PyAccountLookup *)py;
}
@end