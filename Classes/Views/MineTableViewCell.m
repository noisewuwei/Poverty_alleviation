//
//  MineTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/15.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(23+20+12, 11, 200, 30)];
        _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-40-100, 11, 100, 30)];
        
        _firstLabel.textAlignment = NSTextAlignmentLeft;
        _secondLabel.textAlignment = NSTextAlignmentRight;
        
        _firstLabel.textColor = [UIColor colorHexString:@"121212"];
        _secondLabel.textColor = [UIColor colorHexString:@"888888"];
        
        [self addSubview:_firstLabel];
        [self addSubview:_secondLabel];
        
        _firstLabel.font = [UIFont systemFontOfSize:14];
        
        
        _firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(23, 17, 20, 20)];
        _firstImg.contentMode = UIViewContentModeCenter;
        
        [self addSubview:_firstImg];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
