import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import Data.Ratio ((%))
import Data.Map    (fromList)
import Data.Monoid (mappend)
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWindows
import XMonad.Actions.CycleWS 
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.GridSelect
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.ManageHelpers
import XMonad.Actions.Warp
import XMonad.Layout.Spiral

baseConfig = desktopConfig

main = xmonad =<< statusBar myBar myPP toggleStrutsKey ( ewmh $ myConfig )

myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)



myConfig = baseConfig
  { terminal            = "urxvtc"
  , modMask             = mod4Mask
  , borderWidth         = 1
  , focusedBorderColor  = "#00FFFF"
  , normalBorderColor   = "#222430"
  , layoutHook          = layout'
  , keys = keys def `mappend`
    \c -> fromList 
    [ ((0, 0x1008FF13), spawn "pactl set-sink-mute 0 0 && pactl set-sink-volume 0 +1%")
    , ((0, 0x1008FF12), spawn "pactl set-sink-mute 0 toggle")
    , ((0, 0x1008FF11), spawn "pactl set-sink-mute 0 0 && pactl set-sink-volume 0 -1%")
    , ((0, 0x1008ff1b), spawn "~samuele/.toggleTouch")
    , ((0, 0x1008FF02), spawn "xbacklight +7")
    , ((0, 0x1008FF03), spawn "xbacklight -7")
    ]
  } `additionalKeysP` myKeysP

myKeysP = 
  [ ("M-c",         spawn "google-chrome-stable")
  , ("M-p",         spawn "exe=`/home/samuele/.cabal-sandbox/bin/yeganesh -x` && eval exec $exe" )
  , ("M-S-l",       spawn "slock")
  , ("M-<Tab>",     prevScreen)
  , ("M-S-<Tab>",   nextScreen)
  , ("M-<Right>",   nextWS)
  , ("M-<Left>",    prevWS)
  , ("M-S-<Right>", shiftToNext)
  , ("M-S-<Left>",  shiftToPrev)
  ]
    
layout' = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| Full ))
          where
            tiled = Tall nmaster delta ratio
            nmaster = 1     -- The default number of windows in the master pane
            ratio   = 2%3   -- Default proportion of screen occupied by master pane
            delta   = 5%100 -- Percent of screen to increment by when resizing panes


-- Important for focus on floating windows that gets resized (intellij)
--pointerFollowsFocus :: Rational -> Rational -> X ()
--pointerFollowsFocus h v = do
--  dpy <- asks display
--  root <- asks theRoot
--  withFocused $ \w -> do
--    wa <- io $ getWindowAttributes dpy w
--    (sameRoot,_,w',_,_,_,_,_) <- io $ queryPointer dpy root
--    if (sameRoot && w == w') then
--      return ()
--    else
--      io $ warpPointer dpy none w 0 0 0 0
--        (fraction h (wa_width wa)) (fraction v (wa_height wa))
--  where fraction x y = floor (x * fromIntegral y)
