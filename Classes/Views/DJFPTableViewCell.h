//
//  DJFPTableViewCell.h
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/29.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJFPTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *namelab;
@property(nonatomic,strong) UILabel *numlab;
@property(nonatomic,strong) UILabel *skilllab;
@property(nonatomic,strong) UILabel *contentlab;
@property(nonatomic,strong) UIView *backview;

@property(nonatomic,strong) UIButton *btn;

//-(void)setIntroductionText:(NSString*)text;

@end
