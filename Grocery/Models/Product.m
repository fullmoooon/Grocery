//
//  Product.m
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 16/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import "Product.h"

@implementation Product


- (id) initWithProduct:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        //NSLog(@"Product: %@", dict);
        self.p_id = [dict[@"p_id"] intValue];
        self.name = dict[@"name"];
        self.p_description = dict[@"description"];
        self.priceSGD = dict[@"priceSGD"];
        self.pricePHP = dict[@"pricePHP"];
        self.store = dict[@"prefStore"];
        
    }
    
    return self;
}

@end
