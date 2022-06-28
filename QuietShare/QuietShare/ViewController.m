//
//  ViewController.m
//  QuietShare
//
//  Created by Chandra Pasumarthi on 2/5/19.
//  Copyright © 2019 Chandra Pasumarthi. All rights reserved.
//

#import "ViewController.h"
#import <QuietModemKit/QuietModemKit.h>
#import "Singleton.h"

static QMFrameReceiver *rx;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [[AVAudioSession sharedInstance] requestRecordPermission:perm_grant_callback];
    
    _profilePicker.delegate = self;
    _profilePicker.dataSource = self;
    _profilePicker.showsSelectionIndicator = YES;
    _selectedProfile = nil;
    _txtToSend.text = @"did:knox:z6MkpZuXCV3Niv7izQi2N46RBFKD771MeQMXAxw9yd8Pdejv";//
    //_txtToSend.text = @"Version: 0.1.0 ID: 2bd8c786-4836-4bc1-9df2-ca20d54c3d45 Date Issued: 2022-02-07 21:12:21 Currency: USD Amount: 0.01 Owned By: 5d282cd21e9abe57fae7f62cf07e7be5931073da1b522790e63834fe17a4c2be Authority: 650ace8a112e1f3c050c1a923a0abc6e1a254ba177906f0d26b1f5db205b7a8c Issued By: b4faa8601b468d7402452ecf6977581968c038da38b46fa4c4569fc4abe5970c Block Depth: 2 Secured Signature: 346362052aa2254d47d1b2d1b6a5f1d9f3b1117980edf5e11d6911a9f6c5f5410792d2169fce0f81646f99bac56cfbe8d2be186027b3204057bf1d02ebcc6c09 Authorized Signature: db11696145212481e7bb160a8038e760370a1f35a9f9731df05c30f7f9952ceff2ac514330dfe354ced9f0fa097b80e7766a2bfe19a34e1b629e3ca55f03ae0f";
}


void (^recv_callback)(NSData*) = ^(NSData *frame){
    printf("%s\n", [frame bytes]);
};


- (IBAction)rcvText:(id)sender {
    
    QMReceiverConfig *rxConf = [[QMReceiverConfig alloc] initWithKey:_selectedProfile];
    rx = [[QMFrameReceiver alloc] initWithConfig:rxConf];
    [rx setBlocking:10 withNano:0];
    [rx setReceiveCallback:recv_callback];
    
    
    if (rx != nil) {
        NSString *temp = [NSString stringWithFormat:@"%s", [[rx receive] bytes]];
        [rx close];
        self.receivText.text = temp;
        [rx close];
    }
}

- (IBAction)sendText:(id)sender {
    
    // setup the timer with a 1 second repeat
    self.sendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendSound) userInfo:nil repeats:YES];
    
    self.sendBtn.enabled = NO;
    self.cancelBtn.enabled = YES;
}


- (void)sendSound{
    NSLog(@"sendSound Method Called");
    QMTransmitterConfig *txConf = [[QMTransmitterConfig alloc] initWithKey:_selectedProfile];
    
    QMFrameTransmitter *tx = [[QMFrameTransmitter alloc] initWithConfig:txConf];
    
    //1. get the promissoryfile.ae content
    //2. send its content as string to another device in 'receive' mode
    //_txtToSend.text = @"Version: 0.1.0 ID: 2bd8c786-4836-4bc1-9df2-ca20d54c3d45 Date Issued: 2022-02-07 21:12:21 Currency: USD Amount: 0.01 Owned By: 5d282cd21e9abe57fae7f62cf07e7be5931073da1b522790e63834fe17a4c2be Authority: 650ace8a112e1f3c050c1a923a0abc6e1a254ba177906f0d26b1f5db205b7a8c Issued By: b4faa8601b468d7402452ecf6977581968c038da38b46fa4c4569fc4abe5970c Block Depth: 2 Secured Signature: 346362052aa2254d47d1b2d1b6a5f1d9f3b1117980edf5e11d6911a9f6c5f5410792d2169fce0f81646f99bac56cfbe8d2be186027b3204057bf1d02ebcc6c09 Authorized Signature: db11696145212481e7bb160a8038e760370a1f35a9f9731df05c30f7f9952ceff2ac514330dfe354ced9f0fa097b80e7766a2bfe19a34e1b629e3ca55f03ae0f";
    NSString *stringContent;
    if ([_txtToSend.text length] == 0) {
        stringContent = @"did:knox:z6MkpZuXCV3Niv7izQi2N46RBFKD771MeQMXAxw9yd8Pdejv";
    } else {
        stringContent = _txtToSend.text;
    }
    NSData *frame = [stringContent dataUsingEncoding:NSUTF8StringEncoding];
    [tx send:frame];
    [tx close];
}



- (IBAction)cancelAction:(id)sender {
    
    // stop timer
    [self.sendTimer invalidate];
    self.sendTimer = nil;
    
    self.sendBtn.enabled = YES;
    
    self.receivText.text = @"";
    [self.rcvTimer invalidate];
    
    [rx close];
}


- (void)rcvSound{
    Singleton *globaleIns = [Singleton sharedInstance];
    
    if(globaleIns.str ) {
        [self.rcvTimer invalidate];
        self.receivText.text = globaleIns.str;
    }
}


- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}


void (^perm_grant_callback)(BOOL) = ^(BOOL granted){
    NSLog(@"granted is %d", granted);
};


#pragma  picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch(row) {
        case 0:
            _selectedProfile =@"ultrasonic-experimental";
            break;
    }
    
    return _selectedProfile;
}
@end
