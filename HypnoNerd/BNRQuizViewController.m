//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by Lakhpat on 26/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@property (nonatomic) CGRect ansFrame;
@property (nonatomic) CGRect queFrame;

@end

@implementation BNRQuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.questions = @[@"From what cognac made?",
                           @"what is 7+7?",
                           @"what is capital of vermont?"];
        
        self.answers = @[@"Grapes",
                         @"14",
                         @"Montpelier"];
    }
    return self;
}

- (IBAction)showQuestion:(id)sender
{
    
    self.questionLabel.alpha = 0.0;
    _queFrame = self.questionLabel.frame;
    self.questionLabel.frame = CGRectMake(-_queFrame.size.width, self.questionLabel.frame.origin.y, self.questionLabel.frame.size.width, self.questionLabel.frame.size.height);
    
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = 0;
    }
    
    NSString *question = self.questions[self.currentQuestionIndex];
    
    
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.questionLabel.text = question;
        self.questionLabel.frame = _queFrame;
        self.questionLabel.alpha = 1.0;
    } completion:nil];
    
    
    _ansFrame = self.answerLabel.frame;
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
     self.answerLabel.frame = CGRectMake(self.view.frame.size.width, self.answerLabel.frame.origin.y, self.answerLabel.frame.size.width, self.answerLabel.frame.size.height);
     self.answerLabel.alpha = 0.0;
     } completion:nil];
    
}

- (IBAction)showAnswer:(id)sender
{
    
    //self.answerLabel.alpha = 0.0;
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.frame = CGRectMake(- self.answerLabel.frame.size.width, self.answerLabel.frame.origin.y, self.answerLabel.frame.size.width, self.answerLabel.frame.size.height);
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.answerLabel.frame = _ansFrame;
        self.answerLabel.text = answer;
        self.answerLabel.alpha = 1.0;
    } completion:nil];
    
}

@end
