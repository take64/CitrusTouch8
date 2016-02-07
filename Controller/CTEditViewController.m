//
//  CTEditViewController.m
//  CitrusTouch
//
//  Created by take64 on 2013/12/21.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTEditViewController.h"

@interface CTEditViewController ()

@end

@implementation CTEditViewController

//
// synthseize
//
@synthesize entity;
@synthesize headTitles;
@synthesize rowOfSection;
@synthesize datastore;
@synthesize temporary;
@synthesize relations;
@synthesize editFoot;
@synthesize editable;
@synthesize removeAlertView;
@synthesize removeAlertVisible;
@synthesize rebirthAlertView;
@synthesize rebirthAlertVisible;

// 初期化
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // 保存ボタン
        [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonSave)]];
        
        // データストア生成
        [self setHeadTitles:[NSArray array]];
        [self setRowOfSection:[NSArray array]];
        [self setDatastore:[NSMutableDictionary dictionary]];
        [self setTemporary:[NSMutableDictionary dictionary]];
        
        // 削除可能
        [self setEditable:YES];
//        
//        // 背景
//        [[self view] setBackgroundColor:[CTColor colorWithHEXString:@"F5F5F5"]];
        
        // スタイル調整
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

        // ボタンパネル
        [self setEditFoot:[[CTEditFoot alloc] initWithFrame:CGRectZero]];
        [[self tableView] setTableFooterView:[self editFoot]];
        [[[self editFoot] removeButton] addTarget:self action:@selector(onTapButtonRemove) forControlEvents:UIControlEventTouchUpInside];
        [[[self editFoot] rebirthButton] addTarget:self action:@selector(onTapButtonRebirth) forControlEvents:UIControlEventTouchUpInside];
        
        // 削除確認
        [self setRemoveAlertView:[[UIAlertView alloc] initWithTitle:@"確認" message:@"削除します。よろしいですか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"OK", nil]];
        // 復活確認
        [self setRebirthAlertView:[[UIAlertView alloc] initWithTitle:@"確認" message:@"復活します。よろしいですか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"OK", nil]];
        
        // 削除アラート
        [self setRemoveAlertVisible:YES];
        // 復活アラート
        [self setRebirthAlertVisible:YES];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 削除復活ボタン
    if([self editable] == YES)
    {
        if([self entity] != nil)
        {
            [[self editFoot] setHidden:NO];
            if([[self entity] respondsToSelector:@selector(status)] == YES)
            {
                NSNumber *numberValue = [[self entity] valueForKey:@"status"];
                [[self editFoot] loadStatus:numberValue];
            }
        }
        else
        {
            [[self editFoot] setHidden:YES];
        }
    }
    else
    {
        [[self editFoot] setHidden:YES];
    }
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
#pragma mark UITableViewDataSource
//
// UITableViewDataSource
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
    return [[self rowOfSection] count];
}
// ヘッダタイトル
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self headTitles] objectAtIndex:section];
}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;


#pragma mark -
#pragma mark UITableViewDelegate
//
// UITableViewDelegate
//

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section;
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
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
#pragma mark UIAlertViewDelegate
//
// UIAlertViewDelegate
//

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
//- (void)alertViewCancel:(UIAlertView *)alertView;
//- (void)willPresentAlertView:(UIAlertView *)alertView;
//- (void)didPresentAlertView:(UIAlertView *)alertView;
//- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
// ボタン押下時(消え時)
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // 削除
    if(alertView == [self removeAlertView])
    {
        if(buttonIndex == 1)
        {
            [self remove];
        }
    }
    // 復活
    else if(alertView == [self rebirthAlertView])
    {
        if(buttonIndex == 1)
        {
            [self rebirth];
        }
    }
}
//- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView;




#pragma mark -
#pragma mark method
//
// method
//

// 読み込み
- (void) loadEntity:(NSManagedObject *)entityValue
{
    [self setEntity:entityValue];
    [self setTemporary:[NSMutableDictionary dictionary]];
    [self setDatastore:[NSMutableDictionary dictionary]];
}
// 保存
- (void) save
{
}
// 削除
- (void) remove
{
    [[self entity] setValue:@9              forKey:@"status"];
    [[self entity] setValue:[NSDate date]   forKey:@"modified"];
}
// 復活
- (void) rebirth
{
    [[self entity] setValue:@0              forKey:@"status"];
    [[self entity] setValue:[NSDate date]   forKey:@"modified"];
}

#pragma mark -
#pragma mark private
//
// private
//

// ボタン押下時(保存)
- (void) onTapBarButtonSave
{
    if([self canPerformAction:@selector(save) withSender:nil] == YES)
    {
        [self performSelector:@selector(save) withObject:nil];
    }
}
// ボタン押下時(削除)
- (void) onTapButtonRemove
{
    if([self removeAlertVisible] == YES)
    {
        [[self removeAlertView] performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [self remove];
    }
}
// ボタン押下時(復活)
- (void) onTapButtonRebirth
{
    if([self rebirthAlertVisible] == YES)
    {
        [[self rebirthAlertView] performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [self rebirth];
    }
}

@end
