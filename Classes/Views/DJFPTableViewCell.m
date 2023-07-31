//
//  DJFPTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/29.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "DJFPTableViewCell.h"

@implementation DJFPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
        _backview = [[UIView alloc] init];
        _backview.backgroundColor = [UIColor whiteColor];
        _backview.layer.masksToBounds = YES;
        _backview.layer.cornerRadius = 4;
        
        
        UIImageView *headimg = [[UIImageView alloc]initWithFrame:CGRectMake(16, 12, 15, 15)];
        headimg.contentMode = UIViewContentModeCenter;
        headimg.image = [UIImage imageNamed:@"dangjian_icon"];
        [_backview addSubview:headimg];
        
        _namelab = [[UILabel alloc]initWithFrame:CGRectMake(headimg.frame.origin.x+15, headimg.frame.origin.y, 50, 15)];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.font = [UIFont systemFontOfSize:14];
        [_backview addSubview:_namelab];
        
        _numlab = [[UILabel alloc]initWithFrame:CGRectMake(_namelab.frame.origin.x+50, headimg.frame.origin.y, 100, 15)];
        _numlab.textAlignment = NSTextAlignmentCenter;
        _numlab.font = [UIFont systemFontOfSize:14];
        _numlab.textColor = [UIColor colorHexString:@"888888"];
        [_backview addSubview:_numlab];
        
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(_namelab.frame.origin.x+50, headimg.frame.origin.y-2.5, 100, 20)];
        [_backview addSubview:_btn];
        
        _skilllab = [[UILabel alloc]initWithFrame:CGRectMake(_numlab.frame.origin.x+100+20, headimg.frame.origin.y-3, zScreenWidth-(_numlab.frame.origin.x+100+14+40)-20, 20)];
        _skilllab.backgroundColor = [UIColor colorHexString:@"f2700b"];
        _skilllab.textAlignment = NSTextAlignmentCenter;
        _skilllab.numberOfLines = 0;
        _skilllab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
        _skilllab.textColor = [UIColor whiteColor];
        [_backview addSubview:_skilllab];
//70
        
        
        
        _contentlab = [[UILabel alloc] init];
        
        _contentlab.numberOfLines = 0;
        _contentlab.textAlignment = NSTextAlignmentLeft;
        _contentlab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        
    }
    return self;
}

//赋值 and 自动换行,计算出cell的高度
//-(void)setIntroductionText:(NSString*)text{
//    //获得当前cell高度
//    CGRect frame = [self frame];
//    //文本赋值
//    self.contentlab.text = text;
//    //设置label的最大行数
//    self.contentlab.numberOfLines = 10;
//    CGSize size = CGSizeMake(300, 1000);
//    CGSize labelSize = [self.contentlab.text sizeWithFont:self.contentlab.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    self.contentlab.frame = CGRectMake(self.contentlab.frame.origin.x, self.contentlab.frame.origin.y, labelSize.width, labelSize.height);
//    
//    //计算出自适应的高度
//    frame.size.height = labelSize.height+100;
//    
//    self.frame = frame;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
