//
//  ComposeViewController.m
//  
//
//  Created by gilemos on 7/1/19.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@end

@implementation ComposeViewController

#pragma mark - Flow of the app
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Buttons Functions
//This function posts a tweet
- (IBAction)tweetButtom:(id)sender {
    [[APIManager shared]postStatusWithText:self.tweetText.text
                                completion:^(Tweet *tweet, NSError *error) {
                                    if(error){
                                        NSLog(@"Error composing Tweet: %@",error.localizedDescription);
                                    }
                                    else{
                                        [self.delegate didTweet:tweet];
                                        NSLog(@"Compose Tweet Success!");
                                        //If sucessfull, dismiss composer view controller
                                        [self dismissViewControllerAnimated:true completion:nil];
                                    }
                                }];
    
}
//This function closes the screen
- (IBAction)closeButtom:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
