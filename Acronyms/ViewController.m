//
//  ViewController.m
//  Acronyms
//
//  Created by Sneha Rao on 04/20/17.
//  Copyright © 2017 Sneha Rao. All rights reserved.
//

#import "ViewController.h"
#import "Webservices.h"
#import "Acronym.h"
#import "DetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.acronymsArray = [[NSMutableArray alloc] init];
    // remove extra cell lines
    tbl.tableFooterView = [UIView new];
    UIToolbar *ViewForDoneButtonOnKeyboard = [[UIToolbar alloc] init];
    [ViewForDoneButtonOnKeyboard sizeToFit];
    UIBarButtonItem *btnDoneOnKeyboard = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleDone target:self
                                                                         action:@selector(removeKeyboard)];
    [ViewForDoneButtonOnKeyboard setItems:[NSArray arrayWithObjects:btnDoneOnKeyboard, nil]];
    
    searchTextBar.inputAccessoryView = ViewForDoneButtonOnKeyboard;

    tbl.hidden = YES;
    Alert_lbl.text = @"Start typing. . .";
    
}
-(void)removeKeyboard{
    [self.acronymsArray removeAllObjects];
    [tbl reloadData];
    tbl.hidden = NO;

    if (searchTextBar.text.length) {
        [self getAcronmysFor:searchTextBar.text];
    }else{
        tbl.hidden = YES;
        Alert_lbl.text = @"Start typing. . .";
    }
    [searchTextBar resignFirstResponder];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UISearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.acronymsArray removeAllObjects];
    [tbl reloadData];
    tbl.hidden = NO;

    if (searchBar.text.length) {
        [self getAcronmysFor:searchBar.text];
    }else{
        tbl.hidden = YES;
        Alert_lbl.text = @"Start typing. . .";
    }
    [searchBar resignFirstResponder];

}
#pragma mark TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Acronym *acr = self.acronymsArray[section];

    return acr.variants.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.acronymsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Acronym *acr = self.acronymsArray[section];
    return acr.title;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Acronym *acr = self.acronymsArray[indexPath.section];
    NSArray * vars = acr.variants;
    
    cell.textLabel.text = [[vars objectAtIndex:indexPath.row] valueForKey:@"lf"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    Acronym *acr = self.acronymsArray[indexPath.section];
    NSArray * vars = acr.variants;
    detail.detials = [vars objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)getAcronmysFor:(NSString*)str{
    NSString *urlStr = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",str];
    [Webservices getDataWithURLString:urlStr completionSuccess:^(id result) {
        NSArray *arr = (NSArray*)result;
        if (arr.count){
            arr = arr[0][@"lfs"];

            for (NSDictionary * object in arr) {
                Acronym *acr = [[Acronym alloc] init];
                acr.title = [object valueForKey:@"lf"];
                acr.variants = [object valueForKey:@"vars"] ;
                
                [self.acronymsArray addObject:acr];
                
            }
            tbl.hidden = NO;

            [tbl reloadData];
        }else{
            tbl.hidden = YES;
            Alert_lbl.text = @"No Acronyms found";
        }
        
    } completionfailure:^(NSString *errMsg) {
        NSLog(@"dsfads %@",errMsg);
    }];
}
@end
