//
//  CTTableModal.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableModal.h"

#import "CTTableCell.h"
#import "CTButton.h"
#import "CTStyle.h"

@interface CTTableModal ()

@end

@implementation CTTableModal

//
// synthesize
//
@synthesize _tableViewController;
@synthesize _tableView;
@synthesize headTitles;
@synthesize rowOfSection;
@synthesize _alertMessage;
@synthesize headViewCaches;
@synthesize footViewCaches;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark -
#pragma mark UITableViewDataSource method
//
// UITableViewDataSource method
//
// セクション内の行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[self rowOfSection] count] == 0)
    {
        return 0;
    }
    return [(NSNumber *)[[self rowOfSection] objectAtIndex:section] integerValue];
}
// セルを返却
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}
// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self rowOfSection] != nil && [[self rowOfSection] count] > 0)
    {
        return [[self rowOfSection] count];
    }
    return 1;
}
// ヘッダタイトル
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if([self headTitles] != nil)
    {
        if([[self headTitles] count] > 0)
        {
            if([[self headTitles] count] >= section)
            {
                title = [[self headTitles] objectAtIndex:section];
            }
        }
    }
    return title;
}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;




#pragma mark -
#pragma mark UITableViewDelegate method
//
// UITableViewDelegate method
//
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[CTTableCell class]] == YES)
    {
        [(CTTableCell *)cell deactivate];
    }
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender;
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender;




#pragma mark -
#pragma mark UIActionSheetDelegate
//
// UIActionSheetDelegate
//

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
//- (void)actionSheetCancel:(UIActionSheet *)actionSheet;
//- (void)willPresentActionSheet:(UIActionSheet *)actionSheet;
//- (void)didPresentActionSheet:(UIActionSheet *)actionSheet;
//- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;



#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithStyle:(UITableViewStyle)style title:(NSString *)titleValue
{
    // 編集テーブルビュー
    [self set_tableViewController:[[UITableViewController alloc] initWithStyle:style]];
    
    self = [super initWithRootViewController:[self _tableViewController]];
    if(self)
    {
        // タイトル
//        [[self _tableViewController] setTitle:titleValue];
        [self setTitle:titleValue];
        
        // delegate
        [[[self _tableViewController] tableView] setDataSource:self];
        [[[self _tableViewController] tableView] setDelegate:self];
        
        // エイリアス
        [self set_tableView:[[self _tableViewController] tableView]];
        
        // 枠線設定
        [[self _tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        // タイトル
        [self setHeadTitles:[NSMutableArray arrayWithCapacity:1]];
        
        // 閉じるボタン
        UIBarButtonItem *buttonClose = [[UIBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStylePlain target:self action:@selector(hide)];
        [[[self _tableViewController] navigationItem] setLeftBarButtonItem:buttonClose];
        
        // ツールバー表示
        [[[self _tableViewController] navigationController] setToolbarHidden:NO];
    }
    return self;
}

// メッセージ
- (void) alertMessageWithTitle:(NSString *)titleValue message:(id)messages
{
    // 生成
    if([self _alertMessage] == nil)
    {
        [self set_alertMessage:[[UIAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]];
    }
    
    // タイトル
    [[self _alertMessage] setTitle:titleValue];
    
    // メッセージ
    if([messages isKindOfClass:[NSArray class]] == YES)
    {
        messages = [(NSArray *)messages componentsJoinedByString:@"\n"];
    }
    [[self _alertMessage] setMessage:(NSString *)messages];
    
    // 表示
    [[self _alertMessage] show];
}

// タイトル設定
- (void)setTitle:(NSString *)titleValue
{
    [[self _tableViewController] setTitle:titleValue];
}

// ツールバー表示
- (void)toolbarHidden:(BOOL)hiddenValue
{
    [[[self _tableViewController] navigationController] setToolbarHidden:hiddenValue];
}

// 保存
- (void) onTapButtonSave
{
    
}
// 削除
- (void) onTapButtonRemove
{
    
}

@end
