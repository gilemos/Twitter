//
//  ComposeViewController.m
//  
//
//  Created by gilemos on 7/1/19.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@end

@implementation ComposeViewController

#pragma mark - Flow of the app
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetText.delegate = self;
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

#pragma mark - Protocol method
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int characterLimit = 140;
    //This is the text the user is typing
    NSString *newText = [self.tweetText.text stringByReplacingCharactersInRange:range withString:text];
    self.wordCountLabel.text = [NSString stringWithFormat:@"Character count: %lu", (unsigned long)newText.length];
    //Sees if the length is allowed
    BOOL isAllowed = newText.length < characterLimit;
    //If not, the label turns red
    if(!isAllowed) {
        self.wordCountLabel.textColor = [UIColor redColor];
    }
    return isAllowed;
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
