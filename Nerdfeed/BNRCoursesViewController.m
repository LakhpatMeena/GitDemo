//
//  BNRCoursesViewController.m
//  Nerdfeed
//
//  Created by Lakhpat on 06/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"
#import "BNRCourseTableViewCell.h"

@interface BNRCoursesViewController () <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end

@implementation BNRCoursesViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self){
        self.navigationItem.title = @"BNR Courses";
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //_session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRCourseTableViewCell" forIndexPath:indexPath];
    //self.tableView.rowHeight = 60;
    NSDictionary *course = self.courses[indexPath.row];
    NSString *courseTitle = [[NSString alloc] init];
    courseTitle = course[@"title"];
    NSLog(@"%f\n",cell.courseTitleLableView.frame.size.width);
    
    CGFloat textSizeHeight = [self getLabelHeightForText:courseTitle andWidth:cell.courseTitleLableView.frame.size.width];
    //NSLog(@"%f\n",textSizeHeight);
    
    CGSize courseTitleTextSize = [courseTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    
    //NSLog(@"%f\n",courseTitleTextSize.height);
    
    cell.courseTitleLableView.text = courseTitle;
    
    if(courseTitleTextSize.width >= cell.courseTitleLableView.frame.size.width - 50){
    cell.courseTitleLableView.numberOfLines = 0;
    cell.courseTitleLableView.frame = CGRectMake(cell.courseTitleLableView.frame.origin.x, cell.courseTitleLableView.frame.origin.y, cell.courseTitleLableView.frame.size.width, textSizeHeight);
    }
    cell.courseTitleLableView.textColor = [UIColor blueColor];
    
    NSArray *upcomingDetaills = course[@"upcoming"];
    NSString *startDate = upcomingDetaills[0][@"start_date"];
    NSString *endDate = upcomingDetaills[0][@"end_date"];
    cell.upcomingDateLableView.text = [NSString stringWithFormat:@"upcoming schedule: Start Date : %@ - End Date : %@", startDate, endDate];
    cell.upcomingDateLableView.frame = CGRectMake(cell.courseTitleLableView.frame.origin.x, cell.courseTitleLableView.frame.origin.y+cell.courseTitleLableView.frame.size.height+10, cell.upcomingDateLableView.frame.size.width+50, cell.upcomingDateLableView.frame.size.height);
    cell.upcomingDateLableView.textColor = [UIColor redColor];
    //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 200);
    
    return cell;
}

- (CGFloat)getLabelHeightForText:(NSString *)text andWidth:(CGFloat)labelWidth
{
    CGSize maximumSize = CGSizeMake(labelWidth, 10000);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    CGRect rect = [text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //CGSize labelTextSize = [text sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:maximumSize lineBreakMode:UILineBreakModeTailTruncation];
    return rect.size.height;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSString *title = course[@"title"];
    //BNRCourseTableViewCell *cell = [[BNRCourseTableViewCell alloc] init];
    //NSLog(@"%@\n",title);
    //NSLog(@"%f\n",cell.courseTitleLableView.frame.size.width);
    
    CGFloat titleHeight = [self getLabelHeightForText:title andWidth:339];
    //NSString *date = course[@"end_date"];
    //NSLog(@"%f\n",titleHeight);
    CGFloat rowHeight =  titleHeight+10+21+20;
    //NSLog(@"%f\n",rowHeight);
    //CGFloat *heightByLabel =
    return  rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.title = course[@"title"];
    self.webViewController.url = URL;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"BNRCourseTableViewCell" bundle:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRCourseTableViewCell"];
}

/*- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}*/

- (void)fetchFeed
{
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        //NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", json);
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", jsonObject);
        self.courses = jsonObject[@"courses"];
        //NSLog(@"%@", self.courses);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

@end
