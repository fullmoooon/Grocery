//
//  AddProductViewController.m
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 28/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import "AddProductViewController.h"
#import "Networker.h"

#define insertURL @"http://dev.charm.com/grocery_api/?controller=product&action=insertProduct"


@interface AddProductViewController ()

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void) insertData:(NSDictionary *)dict
{
    NSMutableString *test = [NSMutableString string];
    [test appendString:[NSString stringWithFormat:@"name=%@", dict[@"name"]]];
    [test appendString:[NSString stringWithFormat:@"&description=%@", dict[@"description"]]];
    [test appendString:[NSString stringWithFormat:@"&priceSGD=%@", dict[@"priceSGD"]]];
    [test appendString:[NSString stringWithFormat:@"&pricePHP=%@", dict[@"pricePHP"]]];
    [test appendString:[NSString stringWithFormat:@"&prefStore=%@", dict[@"prefStore"]]];
    
    
    NSData *data = [test dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:insertURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    [Networker fetchContentsOfRequest:request completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableDictionary *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        // Create AlertView when error or succes
        if([x[@"success"] intValue] == 1) {
            
            NSLog(@"testAPI : %@", x[@"success"]);
            
            
            [self.delegate reloadDataFromAddProduct];
        }
    }];
}


- (IBAction)saveProductButton:(id)sender
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 self.descriptionTextField.text, @"description",
                                 self.nameTextField.text, @"name",
                                 self.prefStoreTextField.text, @"prefStore",
                                 self.pricePHPTextField.text, @"pricePHP",
                                 self.priceSGDTextField.text, @"priceSGD",
                                 nil];
    
    [self insertData:dict];
}

@end
