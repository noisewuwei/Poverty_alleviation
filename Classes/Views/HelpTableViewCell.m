//
//  HelpTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/14.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "HelpTableViewCell.h"

@implementation HelpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        _photoImage.contentMode = UIViewContentModeScaleAspectFit;
        
        _addinfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-66-15, 10, 66, 25)];
        _addinfoBtn.layer.masksToBounds = YES;
        _addinfoBtn.layer.cornerRadius = 12.5;
        [_addinfoBtn setTitle:@"完善信息" forState:UIControlStateNormal];
        [_addinfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addinfoBtn.backgroundColor = [UIColor colorHexString:@"fdba45"];
        _addinfoBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        _addinfoBtn.hidden = YES;
        [self addSubview:_addinfoBtn];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+80+15, 10, zScreenWidth-(10+80+15+10+160), 20)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor colorHexString:@"121212"];
        
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x+zScreenWidth-(10+80+15+10+160), 10, 100, 20)];
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.textColor = [UIColor colorHexString:@"fdba44"];
        _statusLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _statusLabel.text = @"家中无人";
        _statusLabel.hidden = YES;
        
        UIImageView *mobileImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, 10+20+13, 10, 15)];
        mobileImg.image = [UIImage imageNamed:@"list_photo"];
        [mobileImg sizeToFit];
        
        UIImageView *houseImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, 10+20+13+15+13, 10, 15)];
        houseImg.image = [UIImage imageNamed:@"list_adress"];
        [houseImg sizeToFit];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(mobileImg.frame.origin.x+18, mobileImg.frame.origin.y-1, zScreenWidth-(mobileImg.frame.origin.x+10+23+10), 15)];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = [UIColor colorHexString:@"888888"];
        _phoneLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(houseImg.frame.origin.x+18, houseImg.frame.origin.y-9, zScreenWidth-(mobileImg.frame.origin.x+10+23+10), 30)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.textColor = [UIColor colorHexString:@"888888"];
        _addressLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        
        [self addSubview:_photoImage];
        [self addSubview:_nameLabel];
        [self addSubview:_phoneLabel];
        [self addSubview:_addressLabel];
        [self addSubview:mobileImg];
        [self addSubview:houseImg];
        [self addSubview:_statusLabel];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
