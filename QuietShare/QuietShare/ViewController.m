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
}


void (^recv_callback)(NSData*) = ^(NSData *frame){
    printf("%s\n", [frame bytes]);
};


- (IBAction)rcvText:(id)sender {
    
    QMReceiverConfig *rxConf = [[QMReceiverConfig alloc] initWithKey:_selectedProfile];
    rx = [[QMFrameReceiver alloc] initWithConfig:rxConf];
    [rx setBlocking:30 withNano:0];
    [rx setReceiveCallback:recv_callback];
    
    
    if (rx != nil) {
        printf("rx value is  %s\n", [[rx receive] bytes]);
        self.receivText.text = [NSString stringWithUTF8String:[[rx receive] bytes]];
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

    QMTransmitterConfig *txConf = [[QMTransmitterConfig alloc] initWithKey:_selectedProfile];
    
    QMFrameTransmitter *tx = [[QMFrameTransmitter alloc] initWithConfig:txConf];
    
    NSDictionary* task1 = [NSDictionary
                           dictionaryWithObjectsAndKeys:_txtToSend.text, @"payeeCashTag", _txtToSend.text, @"payeeAccount", nil];
    
    NSData* encodedData = [NSJSONSerialization dataWithJSONObject:task1 options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    
    NSData *frame = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [tx send:frame];
    [tx close];
}



- (IBAction)cancelAction:(id)sender {
    
    // stop timer
    [self.sendTimer invalidate];
    self.sendTimer = nil;
    
    self.sendBtn.enabled = YES;
    //    self.cancelBtn.enabled = NO;
    
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"result"]) {
        
        NSLog(@"%@", change);
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
    return 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch(row) {
        case 0:
            _selectedProfile =@"audible";
            break;
        case 1:
            _selectedProfile =@"ultrasonic";
            break;
        case 2:
            _selectedProfile =@"ultrasonic-experimental";
            break;
    }
    
    return _selectedProfile;
}
@end
