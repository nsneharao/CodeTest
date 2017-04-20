//
//  DetailViewController.h
//  Acronyms
//
//  Created by Sneha Rao on 04/20/17.
//  Copyright © 2017 Sneha Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    
    IBOutlet UILabel *title_lbl;
    IBOutlet UILabel *since_lbl;
    IBOutlet UILabel *freq;
}
@property (nonatomic,retain) NSDictionary * detials;

@end
