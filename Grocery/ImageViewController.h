//
//  ImageViewController.h
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 15/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
- (IBAction)clickedDone:(id)sender;

@end
