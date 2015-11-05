//
//  AddProductViewController.h
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 28/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddProductViewControllerDelegate <NSObject>
-(void)reloadDataFromAddProduct;
@end


@interface AddProductViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceSGDTextField;
@property (strong, nonatomic) IBOutlet UITextField *pricePHPTextField;
@property (strong, nonatomic) IBOutlet UITextField *prefStoreTextField;

@property (weak, nonatomic) id <AddProductViewControllerDelegate> delegate;

@end
