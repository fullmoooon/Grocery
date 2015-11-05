//
//  DetailViewController.h
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 10/13/15.
//  Copyright (c) 2015 Charmelle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@protocol DetailViewControllerDelegate <NSObject>
-(void) reloadDataFromUpdatedProduct;
@end

@interface DetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *idLabel;
@property (nonatomic, strong) IBOutlet UITextField *nameLabel;
@property (nonatomic, strong) IBOutlet UITextView *descriptionLabel;
@property (nonatomic, strong) IBOutlet UITextField *priceSGDLabel;
@property (nonatomic, strong) IBOutlet UITextField *pricePHPLabel;
@property (nonatomic, strong) IBOutlet UITextField *prefStoreLabel;

@property (nonatomic, strong) Product *currentProduct;
@property (nonatomic, weak) id <DetailViewControllerDelegate> delegate;

- (void)getProduct:(id)productObject;
- (IBAction)clickedEdit:(id)sender;

@end
