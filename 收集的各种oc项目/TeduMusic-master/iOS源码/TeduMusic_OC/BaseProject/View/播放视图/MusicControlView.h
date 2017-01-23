//
//  MusicControlView.h
//  BaseProject
//
//  Created by yingxin on 15/12/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicControlView : UIView
{
    NSURL *currentURL;
}
+ (MusicControlView *)sharedMusicControlView;

- (IBAction)playNext:(id)sender;

- (IBAction)play:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *songNameLb;
@property (weak, nonatomic) IBOutlet UILabel *artistLb;

@end
