//
//  AccBookTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/28.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AccBookTableViewCell.h"

@implementation AccBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 15)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:14];
        
        _contLab = [[UILabel alloc]initWithFrame:CGRectMake(20+80, 5, zScreenWidth-40-80-60, 15)];
        _contLab.textAlignment = NSTextAlignmentLeft;
        _contLab.font = [UIFont systemFontOfSize:14];
        
        _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-20-60, 5, 60, 15)];
        _moneyLab.textAlignment = NSTextAlignmentRight;
        _moneyLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_titleLab];
        [self addSubview:_contLab];
        [self addSubview:_moneyLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
