import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myManageHook = composeAll
   [ className =? "Gimp" --> doFloat
   , className =? "Emacs" --> doFloat
   ]

main = do
   xmproc <- spawnPipe "/usr/bin/xmobar /home/me/.xmobarrc"
   xmonad $ defaultConfig
      { manageHook = manageDocks <+> myManageHook
                      <+> manageHook defaultConfig
      , layoutHook = avoidStruts $ layoutHook defaultConfig
      , logHook = dynamicLogWithPP $ xmobarPP
                       { ppOutput = hPutStrLn xmproc
                       , ppTitle = xmobarColor "green" "" . shorten 50
                       }
      , modMask = mod4Mask
      , terminal = "urxvt"
      } `additionalKeys`
      [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
      , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
      , ((0, xK_Print), spawn "scrot")
      ]