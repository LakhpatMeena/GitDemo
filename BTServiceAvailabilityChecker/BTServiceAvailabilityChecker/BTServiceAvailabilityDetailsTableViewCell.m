//
//  BTServiceAvailabilityDetailsTableViewCell.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 20/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceAvailabilityDetailsTableViewCell.h"
#import "BTAppFontFamily.h"

#define maximumDownloadSpeed 80

@implementation BTServiceAvailabilityDetailsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.availableServiceNameLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:15];
    self.availableServiceNameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.availableServiceChargeLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:15];
    self.availableServiceChargeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.downloadSpeedLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:8];
    self.downloadSpeedLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.uploadSpeedLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:8];
    self.uploadSpeedLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.usageLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:8];
    self.usageLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.downloadSpeedValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.uploadSpeedValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    self.usageValueLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:8];
    self.usageValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithServiceData:(BTAvailableServiceData *)serviceData withCellDivider:(BOOL)isVisible
{
    self.availableServiceNameLabel.text = serviceData.serviceName;
    
    NSMutableAttributedString *charge = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"£%@/mo", serviceData.serviceCharge]];
    [charge addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:10] range:NSMakeRange(0, 1)];
    [charge addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTBoldFontOfSize:15] range:NSMakeRange(1, serviceData.serviceCharge.length)];
    [charge addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:10] range:NSMakeRange(1+serviceData.serviceCharge.length, 3)];
    self.availableServiceChargeLabel.attributedText = charge;
    
    if ([serviceData.lowDownSpeed isEqualToString:@""]) {
        NSMutableAttributedString *dspeed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Up to %@Mbps", serviceData.highDownSpeed]];
        [dspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:8] range:NSMakeRange(0, 6)];
        [dspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getBTFontExtraBoldFontOfSize:8] range:NSMakeRange(6, serviceData.highDownSpeed.length + 4)];
        self.downloadSpeedValueLabel.attributedText = dspeed;
    } else {
        NSMutableAttributedString *dspeed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"From %@ to %@Mbps",serviceData.lowDownSpeed, serviceData.highDownSpeed]];
        [dspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:8] range:NSMakeRange(0, [dspeed length]-[serviceData.highDownSpeed length]-4)];
        [dspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getBTFontExtraBoldFontOfSize:8] range:NSMakeRange([dspeed length]-[serviceData.highDownSpeed length]-4, serviceData.highDownSpeed.length +4)];
        self.downloadSpeedValueLabel.attributedText = dspeed;
    }
    
    if ([serviceData.lowUpSpeed isEqualToString:@""]) {
        if ([serviceData.highUpSpeed isEqualToString:@""]) {
            NSMutableAttributedString *uspeed = [[NSMutableAttributedString alloc] initWithString:@"Up to 1Mbps"];
            [uspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:8] range:NSMakeRange(0, 6)];
            [uspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getBTFontExtraBoldFontOfSize:8] range:NSMakeRange(6, 5)];
            self.uploadSpeedValueLabel.attributedText = uspeed;
        } else {
            NSMutableAttributedString *uspeed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Up to %@Mbps",serviceData.highUpSpeed]];
            [uspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:8] range:NSMakeRange(0, 6)];
            [uspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getBTFontExtraBoldFontOfSize:8] range:NSMakeRange(6, serviceData.highUpSpeed.length + 4)];
            self.uploadSpeedValueLabel.attributedText = uspeed;
        }
    } else {
        NSMutableAttributedString *uspeed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"From %@ to %@Mbps",serviceData.lowUpSpeed, serviceData.highUpSpeed]];
        [uspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:8] range:NSMakeRange(0, uspeed.length -serviceData.highUpSpeed.length - 4)];
        [uspeed addAttribute:NSFontAttributeName value:[BTAppFontFamily getBTFontExtraBoldFontOfSize:8] range:NSMakeRange(uspeed.length - serviceData.highUpSpeed.length - 4, serviceData.highUpSpeed.length + 4)];
        self.uploadSpeedValueLabel.attributedText = uspeed;
    }
    
    self.usageValueLabel.text = serviceData.usage;
    
    if (!isVisible) {
        [self.availableServicesCellDividerImageView setHidden:YES];
    }
    
    [self rotateAvailabilityDetailsMeterNeedleImageView:[serviceData.highDownSpeed floatValue]];
}


- (void)rotateAvailabilityDetailsMeterNeedleImageView:(float)speed
{
    float degree = ((speed / maximumDownloadSpeed)*180) - 90;
    self.availableServicesMeterNeedleImageView.transform = CGAffineTransformMakeRotation(degree * M_PI/180);
}


@end
