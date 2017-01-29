//
//  CTFirebaseSignInTypeModal.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/23.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTFirebaseSignInTypeModal.h"

@interface CTFirebaseSignInTypeModal ()

@end

@implementation CTFirebaseSignInTypeModal

//
// synthesize
//
@synthesize colors;

// 初期化
- (id)initWithStyle:(UITableViewStyle)style title:(NSString *)titleValue
{
    self = [super initWithStyle:style title:titleValue];
    if(self)
    {
        [self setKeyList:[@[
                            [@[ CTFirebaseSignInTypeFacebook, CTFirebaseSignInTypeTwitter, CTFirebaseSignInTypeGoogle ] mutableCopy]
                            ] mutableCopy]];
        [self setKeyDict:[@{
                            CTFirebaseSignInTypeFacebook    :@"Facebook",
                            CTFirebaseSignInTypeTwitter     :@"Twitter",
                            CTFirebaseSignInTypeGoogle      :@"Google",
                            } mutableCopy]];
        [self setColors:@{
                          CTFirebaseSignInTypeFacebook    :@"305097",
                          CTFirebaseSignInTypeTwitter     :@"00aced",
                          CTFirebaseSignInTypeGoogle      :@"db4a39",
                          }];
        
//        [[CTFirebaseSignInGoogle sharedService] signInWithControllr:self];
    }
    return self;
}


#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
// セルを返却する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CellId";
    
    CTTableCellLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(cell == nil)
    {
        cell = [[CTTableCellLabel alloc] initWithPrefix:nil reuseIdentifier:CellId];
        [[[cell prefixLabel] callStyle] addStyleKey:@"color" value:@"FFFFFF"];
        [[[cell label] callStyle] addStyleKey:@"text-align" value:@"center"];
    }
    if(cell != nil)
    {
        NSInteger section   = [indexPath section];
        NSInteger row       = [indexPath row];
        id _selectedKey = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
        
        NSString *valString = [[self keyDict] objectForKey:_selectedKey];
//        [cell setContentText:valString];
        [[cell prefixLabel] setText:valString];
        
        // 接続情報
        NSString *connectionString = @"(未接続)";
        
        // Google
        if([_selectedKey isEqualToString:CTFirebaseSignInTypeGoogle] == YES)
        {
            if([CTFirebaseSignIn isSignInGoogle] == YES)
            {
                connectionString = @"接続済";
            }
        }
        
        [cell setContentText:connectionString];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        if([[self selectedList] containsObject:_selectedKey] == YES)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        
    }
    return cell;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;





#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = [indexPath section];
    NSInteger row       = [indexPath row];
    NSString *_selectedKey = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
    NSString *colorCode = [[self colors] objectForKey:_selectedKey];
    
    [(CTTableCellLabel *)cell setBackgroundColor:[CTColor colorWithHEXString:colorCode]];
    [[[(CTTableCellLabel *)cell label] callStyle] addStyleKey:@"color" value:@"FFFFFF"];
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section;
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = [indexPath section];
    NSInteger row       = [indexPath row];
    NSString *_selectedKey = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
    if([_selectedKey isEqualToString:CTFirebaseSignInTypeGoogle] == YES)
    {
        [[CTFirebaseSignInGoogle sharedService] bindBlockSignIn:^(GIDGoogleUser *user, NSError *error) {
            
            // access_deniedの時はGoogle画面が残るので1回余計にhideする
            if([error code] == -5)
            {
                [self hide];
            }
            [self hide];
            
        } signOut:^(GIDGoogleUser *user, NSError *error) {
            
        }];
        [[CTFirebaseSignInGoogle sharedService] signInWithControllr:self];
    }
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context;
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator;
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView;


#pragma mark - GIDSignInUIDelegate
//
// GIDSignInUIDelegate
//

//// The sign-in flow has finished selecting how to proceed, and the UI should no longer display
//// a spinner or other "please wait" element.
//- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
//{
//    CTLog(@"- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error : %@", error);
//}
//
//// If implemented, this method will be invoked when sign in needs to display a view controller.
//// The view controller should be displayed modally (via UIViewController's |presentViewController|
//// method, and not pushed unto a navigation controller's stack.
//- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
//{
//    CTLog(@"- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController");
//    
//    [self presentViewController:viewController animated:YES completion:nil];
////    [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:viewController animated:YES completion:nil];
//    
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        
////        dispatch_async(dispatch_get_main_queue(), ^{
////            
//////            [self presentViewController:viewController animated:YES completion:^{
//////                
//////            }];
//////            [[[self _tableViewController] navigationController] pushViewController:viewController animated:NO];
////            [[self _tableViewController] presentViewController:viewController animated:NO completion:^{
////                
////            }];
////        });
////    });
//
//}
//
//// If implemented, this method will be invoked when sign in needs to dismiss a view controller.
//// Typically, this should be implemented by calling |dismissViewController| on the passed
//// view controller.
//- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
//{
//    CTLog(@"- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController");
//}


@end
