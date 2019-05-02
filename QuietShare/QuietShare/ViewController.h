//
//  ViewController.h
//  QuietShare
//
//  Created by Chandra Pasumarthi on 2/5/19.
//  Copyright © 2019 Chandra Pasumarthi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *profilePicker;

@property (weak, nonatomic) IBOutlet UITextField *txtToSend;
- (IBAction)rcvText:(id)sender;
- (IBAction)sendText:(id)sender;
- (IBAction)cancelAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *receivText;
@property (weak, nonatomic) IBOutlet UIButton *rcvBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) NSTimer *sendTimer;
@property (strong, nonatomic) NSTimer *rcvTimer;
- (void)sendSound;
- (void)rcvSound;
@property (strong, nonatomic) NSString *selectedProfile;

@end

