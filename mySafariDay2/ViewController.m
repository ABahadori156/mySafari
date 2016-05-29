//
//  ViewController.m
//  mySafariDay2
//
//  Created by Pasha Bahadori on 5/24/16.
//  Copyright © 2016 Pelican Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (nonatomic) CGFloat firstContentOffset;


- (IBAction)onBackButtonPressed:(UIButton*)sender;
- (IBAction)onForwardButtonPressed:(UIButton *)sender;
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender;
- (IBAction)onReloadButtonPressed:(UIButton *)sender;
- (IBAction)onPlusButtonPressed:(UIButton *)sender;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFromString:@"http://www.google.com"];
    
    // below we set the scrollView delegate to our current webView so we can
    self.webView.scrollView.delegate = self;
}

//custom method below
-(void)loadFromString:(NSString *)urlString {
    // Step 11: Typing urls without the http://
    // If the value of urlTextField does not begin with “http://”, use stringWithFormat to create a new NSString
    
    
    if (!([urlString containsString:@"http://"] ||  [urlString containsString:@"https://"])){
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadFromString:textField.text];

    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.networkActivityIndicator startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.networkActivityIndicator stopAnimating];
      // Step 14: The UITextField should update to display the current URL every time the user goes to a new web page. Look below
    
      // We make a variable currentUrl of type NSString then we request the webView's current URL and convert it to a string
    
    //reverse
    NSString *currentURL = [[self.webView.request URL] absoluteString];
    
    // We set our textfield's text to display the current
    self.urlTextField.text = currentURL;
    // NSLog(@"%@",[currentURL description]);
    
    // Step 15: How to set itemBar to
    NSString *currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.titleBar.title = currentTitle;
}

//
-(IBAction)onBackButtonPressed:(UIButton *)sender{
    if ([self.webView canGoBack])
        [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    if ([self.webView canGoForward])
        [self.webView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}



// Step 12: Add a UIButton to the Button View and make it’s text +
// When the + button is pressed, display a UIAlertViewController displaying the string, “Coming soon!”
- (IBAction)onPlusButtonPressed:(UIButton *)sender {
    UIAlertController *teaserAlertController = [UIAlertController alertControllerWithTitle:@"Teaser Alert" message:@"Coming soon!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    // handler used to perform code when user taps on Okay button
    
    [teaserAlertController addAction:okButton];
    
    // completion allows us to put a block of code we could execute but we dont need too here
    [self presentViewController:teaserAlertController animated:YES completion:nil];
}

// Step 13: When scrolling down, alter the location and opacity of the UITextField to hide it or show it based on scroll direction
// scrollViewDidScroll is a delegate method from our scroll view delegate

// You could had just put 0 < scrollView.contentOffset.y
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.firstContentOffset < scrollView.contentOffset.y){
        self.urlTextField.alpha = 0.3;
    }
    else{
        self.urlTextField.alpha = 1.0;
    }
    self.firstContentOffset = scrollView.contentOffset.y;
    
}



@end
