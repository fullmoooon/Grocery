//
//  Product.h
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 16/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) int p_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *p_description;
@property (nonatomic, strong) NSString *priceSGD;
@property (nonatomic, strong) NSString *pricePHP;
@property (nonatomic, strong) NSString *store;

- (id) initWithProduct:(NSDictionary *)dict;

@end
