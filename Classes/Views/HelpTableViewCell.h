//
//  HelpTableViewCell.h
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/14.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *photoImage;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *phoneLabel;
@property(nonatomic,strong) UILabel *statusLabel;
@property(nonatomic,strong) UILabel *addressLabel;

@property(nonatomic,strong) UIButton *addinfoBtn;


@end
