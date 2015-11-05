//
//  ProductsTableViewController.m
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 16/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import "ProductsTableViewController.h"
#import "Product.h"
#import "DetailViewController.h"
#import "Networker.h"


#define deleteURL @"http://dev.charm.com/grocery_api/?controller=product&action=deleteProduct"
#define productsURL @"http://dev.charm.com/grocery_api/?controller=product&action=getAll"

@interface ProductsTableViewController ()

@end

@implementation ProductsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testBlocksGCD];
    
    [self getAllData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) testBlocksGCD {
    
    //dispatch_queue_t concurrentQueue = dispatch_queue_create(@"", dispatch_async(dispatch_get_current_queue(), ^{
        
    //}));
}


#pragma mark - JSON NSURSessions


- (void) getAllData
{
    NSURL *url = [NSURL URLWithString:productsURL];

    [Networker fetchContentsOfURL:url completion:^(NSData *data, NSError *error) {
        if(![NSThread isMainThread] && !error)
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadDataFrom:data];
            });
    }];
    
    /*
    // 1. Create a Session Configuration
    //NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 2. Create an NSURLSession Object
    NSURLSession *session = [NSURLSession sharedSession];
    //NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 3. Create an NSURLSession Task (Data  / Download / Upload]
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError * _Nullable error) {
        
        if(![NSThread isMainThread])
            dispatch_async(dispatch_get_main_queue(), ^{
                [self parseData:data];
            });
    }];
    
    [dataTask resume];
     */
}


- (void) reloadDataFrom:(NSData *)data
{
    NSError *error = nil;
    
    NSMutableDictionary *x = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (self.jsonArray != nil) {
        self.jsonArray = nil;
        self.productsArray = nil;
    }
    
    self.jsonArray = x[@"data"];
    //NSLog(@"reloadDataFrom: %@", self.jsonArray);
    
    
    if(!self.productsArray)
        self.productsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.jsonArray count]; i++) {
        
        NSString *desc = [NSString stringWithFormat:@"%@", self.jsonArray[i][@"description"]];
        
        NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
                           desc, @"description",
                           (NSString*)self.jsonArray[i][@"name"], @"name",
                           (NSString*)self.jsonArray[i][@"p_id"], @"p_id",
                           (NSString*)self.jsonArray[i][@"prefStore"], @"prefStore",
                           (NSString*)self.jsonArray[i][@"pricePHP"], @"pricePHP",
                           (NSString*)self.jsonArray[i][@"priceSGD"], @"priceSGD",
                           nil];
                           
        Product *product = [[Product alloc] initWithProduct:d];
        [self.productsArray addObject:product];
    }
    
    [self.tableView reloadData];
}




#pragma mark - Add Product Delegate

-(void)reloadDataFromAddProduct
{
    [self getAllData];
    NSLog(@"RELOADING DATA FROM DELEGATE CALL");
}

-(void)reloadDataFromUpdatedProduct
{
    [self getAllData];
    NSLog(@"RELOADING DATA FROM DELEGATE CALL");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.productsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Product *productObject = self.productsArray[indexPath.row];
    cell.textLabel.text = productObject.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"p_id: %d", productObject.p_id];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // get current p_id of selected index
        Product *p = self.productsArray[indexPath.row];
        
        NSString *s = [NSString stringWithFormat:@"p_id=%d", p.p_id];
        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:deleteURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        
        [Networker fetchContentsOfRequest:request completion:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.productsArray removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
            });
        }];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toDetailVC"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Product *product = [self.productsArray objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] getProduct: product];
        
        [[segue destinationViewController] setDelegate:self];
    }
    else if ([[segue identifier] isEqualToString:@"toAddProductVC"]) {
        
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)backToStart:(UIStoryboardSegue *) segue {
    DetailViewController *detailVC = segue.sourceViewController;
    NSLog(@"detailVC: %@", detailVC.nameLabel.text);
}




@end
