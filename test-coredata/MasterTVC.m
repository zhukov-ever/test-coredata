//
//  MasterVCTableViewController.m
//  test-coredata
//
//  Created by Zhn on 2/12/2014.
//  Copyright (c) 2014 Zhn. All rights reserved.
//

#import "MasterTVC.h"
#import "CatManager.h"

@interface MasterTVC ()

@end

@implementation MasterTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Cats";
    [[CatManager shared] load:^{
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addCatHandler:(id)sender
{
    [[CatManager shared] addRandomCat:^{
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:([CatManager shared].arrayCats.count - 1) inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (IBAction)closeAppHandler:(id)sender
{
    //never use "exit(0);" in production!
    exit(0);
}


#pragma mark - UITableViewControllerdDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CatManager shared].arrayCats count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatCell" forIndexPath:indexPath];
    
    Cat* _cat = [CatManager shared].arrayCats[indexPath.row];
    cell.textLabel.text = _cat.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"vampire: %@", _cat.details.isVampire];
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        [[CatManager shared] removeCatAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    Cat* _cat = [[CatManager shared].catsSet objectAtIndex:indexPath.row];
//    [[CatManager shared] changeCatRandomly:_cat];
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//}



@end
