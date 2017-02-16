@interface SPTPlaylistAddToPlaylistViewController : UIViewController
@end

static BOOL isTargetAlert = NO;
static SPTPlaylistAddToPlaylistViewController* playlistView;

%hook SPTPlaylistAddToPlaylistViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;
    
    playlistView = self;
    isTargetAlert = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    %orig;
    
    playlistView = nil;
    isTargetAlert = NO;
}

%end



%hook UIAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *action))handler {
    if (isTargetAlert) {
        // Is the desired alert; check if this is the desired action.
        if ([title isEqualToString:@"Cancel"]) {
            isTargetAlert = NO;
            UIAlertAction *newCancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                                   handler:^(UIAlertAction * action) {
                                                                                       // dismiss ViewController
                                                                                       [playlistView dismissViewControllerAnimated:YES completion:nil];
                                                                                   }];

            return newCancelAction;
        }
    }
    
    return %orig();
}

%end
