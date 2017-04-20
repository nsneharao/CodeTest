//
//  ViewController.h
//  Acronyms
//
//  Created by Sneha Rao on 04/20/17.
//  Copyright © 2017 Sneha Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    IBOutlet UITableView *tbl;
    IBOutlet UILabel *Alert_lbl;
    
    IBOutlet UISearchBar *searchTextBar;
}
@property(nonatomic,strong)NSMutableArray *acronymsArray;

@end

