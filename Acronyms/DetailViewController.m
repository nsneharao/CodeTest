//
//  DetailViewController.m
//  Acronyms
//
//  Created by Sneha Rao on 04/20/17.
//  Copyright © 2017 Sneha Rao. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    title_lbl.text = [self.detials valueForKey:@"lf"];
    
    freq.text = [NSString stringWithFormat:@"%@",[self.detials valueForKey:@"freq"]];
    since_lbl.text = [NSString stringWithFormat:@"%@",[self.detials valueForKey:@"since"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
