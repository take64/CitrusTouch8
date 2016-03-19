//
//  CTSelectKeyModal.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/25.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSelectKeyModal.h"

@interface CTSelectKeyModal ()

@end

@implementation CTSelectKeyModal

//
// synthesize
//
@synthesize keyList;
@synthesize keyDict;

// 初期化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setKeyDict:[NSMutableDictionary dictionary]];
        [self setKeyList:[NSMutableArray array]];
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
// セクション内セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[[self keyList] objectAtIndex:section] count];
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self keyList] count];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
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
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
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
// 選択
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = [indexPath section];
    NSInteger row       = [indexPath row];
    id selectedObject = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
    if([self modalComplete] != nil)
    {
        self.modalComplete(selectedObject);
    }
    [self hide];
}
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
        
        // 閉じるボタン
        UIBarButtonItem *buttonClose = [[UIBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStylePlain target:self action:@selector(hide)];
        [[[self _tableViewController] navigationItem] setLeftBarButtonItem:buttonClose];
    }
    return self;
}

@end
