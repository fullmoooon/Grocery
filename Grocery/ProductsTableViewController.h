//
//  ProductsTableViewController.h
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 16/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductViewController.h"
#import "DetailViewController.h"

@interface ProductsTableViewController : UITableViewController <AddProductViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *jsonArray;
@property (nonatomic, strong) NSMutableArray *productsArray;

@end
