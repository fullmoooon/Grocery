//
//  DetailViewController.m
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 10/13/15.
//  Copyright (c) 2015 Charmelle. All rights reserved.
//

#import "DetailViewController.h"
//#import "ImageViewController.h"
#import "Networker.h"

#define updateURL @"http://dev.charm.com/grocery_api/?controller=product&action=updateProduct"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    //if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        //
    //}
}


- (void)getProduct:(id)productObject
{
    self.currentProduct = productObject;
}


- (IBAction)clickedEdit:(id)sender
{
    // Check if there were any differences made to the original ?
    NSLog(@"Original: %@", self.currentProduct.name);
    NSLog(@"Updated: %@", self.nameLabel.text);
    
    if ([self.currentProduct.name isEqualToString:self.nameLabel.text] &&
        [self.currentProduct.p_description isEqualToString:self.descriptionLabel.text] &&
        [self.currentProduct.priceSGD isEqualToString:self.priceSGDLabel.text] &&
        [self.currentProduct.pricePHP isEqualToString:self.pricePHPLabel.text] &&
        [self.currentProduct.store isEqualToString:self.prefStoreLabel.text]) {
        
        NSLog(@"NO CHANGES were made from the original.");
    } else {
        
        NSLog(@"CHANGES, DB to be updated.");
        /*NSURL *url = [NSURL URLWithString:updateURL];
        
        // Get the updated data, update by passing its p_id
        NSMutableString *test = [NSMutableString string];
        [test appendString:[NSString stringWithFormat:@"p_id=%@", self.idLabel.text]];
        [test appendString:[NSString stringWithFormat:@"&name=%@", self.nameLabel.text]];
        [test appendString:[NSString stringWithFormat:@"&description=%@", self.descriptionLabel.text]];
        [test appendString:[NSString stringWithFormat:@"&priceSGD=%@", self.priceSGDLabel.text]];
        [test appendString:[NSString stringWithFormat:@"&pricePHP=%@", self.pricePHPLabel.text]];
        [test appendString:[NSString stringWithFormat:@"&prefStore=%@", self.prefStoreLabel.text]];
        NSLog(@"%@", test);
        
        NSData *data = [test dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        
        [Networker fetchContentsOfRequest:request completion:^(NSData *data, NSURLResponse *response, NSError *error) {
            // connect to DB
            // Update the DB based on passed data
            NSMutableDictionary *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"success: %@", x[@"success"]);
            
            // alert view if successfully updated
            
            
            // reload products' table view
            [self.delegate reloadDataFromUpdatedProduct];
        }];
        */
    }
}

- (void)setLabels
{
    self.idLabel.text = [[NSString alloc] initWithFormat:@"%d", self.currentProduct.p_id];
    self.nameLabel.text = self.currentProduct.name;
    self.descriptionLabel.text = self.currentProduct.p_description;
    self.priceSGDLabel.text = self.currentProduct.priceSGD;
    self.pricePHPLabel.text = self.currentProduct.pricePHP;
    self.prefStoreLabel.text = self.currentProduct.store;
}

@end
