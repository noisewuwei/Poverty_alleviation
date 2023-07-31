//
//  DeatailAndMethodTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/15.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "DeatailAndMethodTableViewCell.h"

@implementation DeatailAndMethodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(17+5, 5, 100, 20)];
        _firstLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
        _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(17+100, 7, zScreenWidth-17-100-17-5, 20)];
        _secondLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
        
        _firstLabel.textAlignment = NSTextAlignmentLeft;
        _secondLabel.textAlignment = NSTextAlignmentRight;
        
        _firstLabel.textColor = [UIColor colorHexString:@"888888"];
        _secondLabel.textColor = [UIColor colorHexString:@"121212"];
        
        [self addSubview:_firstLabel];
        [self addSubview:_secondLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
