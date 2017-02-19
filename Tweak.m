@interface SPTPlaylistAddToPlaylistViewController : UIViewController
- (void)executeSkipAction;
@end

%hook SPTPlaylistAddToPlaylistViewController


- (void)executeSkipAction {
    %orig;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

%end
