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
@property (strong, nonatomic) APIManager *apiManager;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tweetButtom:(id)sender {
    [self.apiManager init];
    [self.apiManager postStatusWithText:self.tweetText.text completion:nil];
    
    //If sucessfull, dismiss composer view controller
    //TO DO: CALL IT ONLY WHEN IT IS SUCCESSFUL
    [self dismissViewControllerAnimated:true completion:nil];
    
}
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
