//
//  CTEditModal.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTEditModal.h"

#import "CTTableCell.h"
#import "CTButton.h"
#import "CTStyle.h"

@interface CTEditModal ()

@end

@implementation CTEditModal

//
// synthesize
//
@synthesize _tableViewController;
@synthesize _tableView;
@synthesize headTitles;
@synthesize rowOfSection;
@synthesize _alertMessage;
@synthesize datastore;
@synthesize temporary;
@synthesize relations;
@synthesize removeButton;
@synthesize removeActionSheet;
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
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // 削除確認
    if(actionSheet == [self removeActionSheet])
    {
        if(buttonIndex == 0)
        {
            if([self respondsToSelector:@selector(remove)] == YES)
            {
                [self performSelector:@selector(remove)];
            }
        }
    }
}



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
        [[self _tableViewController] setTitle:titleValue];
        
//        // 親コントローラー
//        [self set_parentController:parentController];
        
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
        
        // 保存ボタン
        UIBarButtonItem *buttonSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(onTapButtonSave)];
        [[[self _tableViewController] navigationItem] setRightBarButtonItem:buttonSave];
        
        
        // データストア
        [self setDatastore:[NSMutableDictionary dictionaryWithCapacity:1]];
        // テンポラリ
        [self setTemporary:[NSMutableDictionary dictionaryWithCapacity:1]];
        // リレーション
        [self setRelations:[NSMutableDictionary dictionaryWithCapacity:1]];
        
        // ツールバー表示
        [[[self _tableViewController] navigationController] setToolbarHidden:NO];
        
        // 削除ボタン
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"削除" style:UIBarButtonItemStyleDone target:self action:@selector(onTapButtonRemove)];
        [button setTintColor:[UIColor redColor]];
        [[self _tableViewController] setToolbarItems:@[ button ]];
        [self setRemoveButton:button];
        
//        // 削除ボタン
//        [self setRemoveButton:[[CTButton alloc] initWithText:@"削除"]];
//        [[[self removeButton] callStyle] addStyleDictionary:@{
//                                                              @"top"             :@"0",
//                                                              @"left"            :@"0",
//                                                              @"width"           :@"160",
//                                                              @"height"          :@"64",
//                                                              @"font-size"       :@"20",
//                                                              @"font-weight"     :@"bold",
//                                                              @"text-shadow"     :@"0 -1 1 333333",
//                                                              @"background-color":@"FF0000",
//                                                              @"border-color"    :@"FFFFFF",
//                                                              @"border-width"    :@"1",
//                                                              @"border-radius"   :@"8",
//                                                              @"margin"          :@"4 12 12 12",
//                                                              @"box-shadow"      :@"0 1 4 000000",
//                                                              @"background-image":@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
//         }];
//        [[[self removeButton] callStyleHighlighted] addStyleDictionary:@{
//                                                                         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
//         }];
//        [[[self removeButton] callStyleDisabled] addStyleDictionary:@{
//                                                                      @"background-color":@"666666",
//                                                                      @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
//                                                                         }];
//        [[self _tableView] setTableFooterView:[self removeButton]];
//        [[self removeButton] addTarget:self action:@selector(onTapButtonRemove) forControlEvents:UIControlEventTouchUpInside];
        
        // 削除確認
        [self setRemoveActionSheet:[[UIActionSheet alloc] initWithTitle:@"削除します。よろしいですか？" delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:@"削除" otherButtonTitles:nil, nil]];
    }
    return self;
}

// ボタン押下時(保存)
- (void) onTapButtonSave
{
    [self save];
}
// 保存
- (void) save
{
    // 閉じる
    [self hide];
}
// ボタン押下時(削除)
- (void) onTapButtonRemove
{
    [[self removeActionSheet] showInView:[self _tableView]];
}
// 削除
- (void) remove
{
    // 閉じる
    [self hide];
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

@end
