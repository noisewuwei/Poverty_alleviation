//
//  OutTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/4.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "OutTableViewCell.h"

@implementation OutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(33, 14.5, 15, 15)];
        img.contentMode = UIViewContentModeCenter;
        img.image = [UIImage imageNamed:@"task_icon3"];
        [self addSubview:img];
        
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(img.frame.origin.x+15+12, 14.5, 100, 15)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_nameLab];
        
        _statusLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-15-80, 14.5, 80, 15)];
        _statusLab.textAlignment = NSTextAlignmentRight;
        _statusLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_statusLab];

        
    }
    return self;
}

@end
