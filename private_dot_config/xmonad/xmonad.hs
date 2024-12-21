import Data.Ratio ((%))
import System.Exit (exitSuccess)
import XMonad
import XMonad.Actions.AfterDrag (afterDrag)
import XMonad.Actions.CycleWS
  ( Direction1D (Next, Prev),
    WSType (Not, (:&:)),
    emptyWS,
    hiddenWS,
    ignoringWSs,
    moveTo,
    nextScreen,
    swapNextScreen,
  )
import XMonad.Actions.FlexibleResize qualified as Flex
import XMonad.Actions.FloatSnap (snapMagicMove, snapMagicResize)
import XMonad.Actions.Launcher (LauncherConfig (LauncherConfig), defaultLauncherModes, launcherPrompt)
import XMonad.Actions.UpdatePointer (updatePointer)
import XMonad.Hooks.DynamicLog
  ( PP
      ( ppCurrent,
        ppHidden,
        ppHiddenNoWindows,
        ppSep,
        ppTitle,
        ppTitleSanitize,
        ppUrgent,
        ppVisible
      ),
    filterOutWsPP,
    shorten,
    wrap,
    xmobarBorder,
    xmobarColor,
    xmobarStrip,
  )
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageHelpers (isDialog)
import XMonad.Hooks.RefocusLast (refocusLastLogHook)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.StatusBar
  ( defToggleStrutsKey,
    statusBarProp,
    withEasySB,
  )
import XMonad.Layout.BinarySpacePartition
  ( BinarySpacePartition,
    Direction2D (D, L, R, U),
    emptyBSP,
  )
import XMonad.Layout.Magnifier (magnifier', magnifiercz')
import XMonad.Layout.PerScreen (ifWider)
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import XMonad.Prompt.ConfirmPrompt (confirmPrompt)
import XMonad.StackSet qualified as W
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.EZConfig
  ( additionalKeysP,
    additionalMouseBindings,
    removeKeys,
  )
import XMonad.Util.Loggers (logTitles, logTitles')
import XMonad.Util.NamedScratchpad
  ( NamedScratchpad (NS),
    allNamedScratchpadAction,
    customFloating,
    namedScratchpadAction,
    namedScratchpadManageHook,
    nsHideOnFocusLoss,
  )
import XMonad.Util.SpawnOnce (spawnOnce)

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (clickablePP myXmobarPP)) defToggleStrutsKey
    $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig {modMask = m} = (m, xK_b)

myConfig =
  def
    { modMask = mod4Mask, -- Use Super instead of Alt
      terminal = "alacritty",
      layoutHook = myLayout,
      startupHook = myStartupHook,
      normalBorderColor = "#bdc7f0",
      focusedBorderColor = "#3d59a1",
      manageHook = manageHook def <> namedScratchpadManageHook scratchpads <> myManageHook,
      workspaces = myWorkspaces,
      logHook = updatePointer (1 % 2, 1 % 10) (0, 0) <> refocusLastLogHook >> nsHideOnFocusLoss scratchpads <> logHook def
    }
    `removeKeys` [ (mod4Mask .|. mod, n)
                   | n <- [xK_1 .. xK_9],
                     mod <- [shiftMask, 0]
                 ]
    `additionalMouseBindings` [ ((mod4Mask, button1), \w -> focus w >> mouseMoveWindow w >> afterDrag (withFocused $ windows . W.sink)),
                                ((mod4Mask, button2), \w -> focus w >> mouseMoveWindow w),
                                ((mod4Mask, button3), \w -> focus w >> Flex.mouseResizeWindow w)
                              ]
    `additionalKeysP` [ ("C-S-o f", spawn "firefox -P"),
                        ("C-S-o e", spawn "emacsclient -c"),
                        ("C-S-o p", spawn "printscreen"),
                        ("C-S-o w", namedScratchpadAction scratchpads "whats"),
                        ("C-S-o c", namedScratchpadAction scratchpads "calendar"),
                        ("C-S-o s", namedScratchpadAction scratchpads "spotify"),
                        ("M-w", spawn "firefox"),
                        ("C-q", kill),
                        ("M-<Tab>", nextScreen),
                        ("M-S-<Tab>", swapNextScreen >> nextScreen),
                        ("M-.", nextWSused),
                        ("M-S-.", nextWSempty),
                        ("M-,", prevWSused),
                        ("M-S-,", prevWSempty),
                        ("M-S-<Space>", namedScratchpadAction scratchpads "dropdown"),
                        ("M-M1-<Space>", spawn "rofi -show combi"),
                        ("M-<Up>", windows W.focusUp),
                        ("M-<Down>", windows W.focusDown),
                        ("M-u", windows W.focusUp),
                        ("M-l", windows W.focusDown),
                        ("M-<Left>", sendMessage Shrink),
                        ("M-<Right>", sendMessage Expand),
                        ("M-S-<Up>", windows W.swapUp),
                        ("M-S-<Down>", windows W.swapDown),
                        ("M-S-u", windows W.swapUp),
                        ("M-S-l", windows W.swapDown),
                        ("M-S-q", confirmPrompt def "exit" $ io exitSuccess),
                        ("M-m", withFocused $ windows . W.sink),
                        ("M-S-<Return>", windows W.focusMaster)
                      ]
    ++ [ ("M-" ++ mod ++ [key], action i)
         | (i, key) <- zip myWorkspaces "arstgkneio",
           (action, mod) <- [(windows . W.view, ""), (windows . shiftAndView, "S-")]
       ]
  where
    shiftAndView i = W.view i . W.shift i
    nextWSused = moveTo Next $ hiddenWS :&: Not emptyWS :&: ignoringWSs ["NSP"]
    prevWSused = moveTo Prev $ hiddenWS :&: Not emptyWS :&: ignoringWSs ["NSP"]
    nextWSempty = moveTo Next $ emptyWS :&: ignoringWSs ["NSP"]
    prevWSempty = moveTo Prev $ emptyWS :&: ignoringWSs ["NSP"]

myLayout = ifWider 1000 (threeCol ||| Full) vTiled
  where
    threeCol = magnifiercz' 1.6 $ ThreeColMid 1 (3 / 100) (9 / 16)
    vTiled = Mirror $ Tall 1 (3 / 100) (1 / 2)

myWorkspaces = ["ᚪA", "ᚱR", "ᛊS", "ᛏT", "ᚵG", "ᚴK", "ᚿN", "ᛂE", "ᛁI", "ᚮO", "NSP"]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore"
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce "setxkbmap -option compose:ralt"
  spawnOnce ". /hdd/home/nardo/.screenlayout/monitorV.sh"
  spawnOnce "systemctl restart --user emacs.service"
  spawn "xcompmgr"
  spawnAllScratchpads
  setWMName "LG3D"
  where
    spawnAllScratchpads = mapM_ (namedScratchpadAction scratchpads) ["dropwdown", "spotify", "whats", "calendar"]

scratchpads :: [NamedScratchpad]
scratchpads =
  [ NS "dropdown" "alacritty --class dropdown" (className =? "dropdown") wideRect,
    NS "spotify" "spotify" (className =? "Spotify") floatRect,
    NS "whats" "whatsapp" (className =? "FFPWA-01J94H8C566XT94XFNY2BA3BHR") floatRect,
    NS "calendar" "calendar" (className =? "FFPWA-01J94JMGJSGCKP105KWM7N5BF0") floatRect
  ]
  where
    floatRect = customFloating $ W.RationalRect (1 % 10) (1 % 10) (4 % 5) (4 % 5)
    wideRect = customFloating $ W.RationalRect 0 (1 % 6) 1 (2 % 3)

myXmobarPP :: PP
myXmobarPP =
  filterOutWsPP
    ["NSP"]
    def
      { ppCurrent = wrapPgap (focused "ᛥ") . border blueTag,
        ppVisible = wrapPgap (visible "ᛝ") . border grey,
        ppHidden = fg . wrapPgap "",
        ppHiddenNoWindows = fgLow . wrapPgap "",
        ppUrgent = red . wrapPgap (yellow "!"),
        ppSep = focused " ᛜ ",
        ppTitleSanitize = xmobarStrip,
        ppTitle = focused . shorten 40
      }
  where
    wrapPgap :: String -> String -> String
    wrapPgap s = wrap (" " ++ s) s
    border c = xmobarBorder "VBoth" c 1
    blueTag = "#3d59a1"
    greenTag = "#73daca"
    cyanTag = "#b4f9f8"
    grey = "#8189af"
    fg = xmobarColor "#bdc7f0" ""
    fgLow = xmobarColor "#555872" ""
    darkBlue = xmobarColor "#565f89" ""
    focused = xmobarColor blueTag ""
    visible = xmobarColor grey ""
    green = xmobarColor "#73daca" ""
    teal = xmobarColor "#2ac3de" ""
    red = xmobarColor "#f7768e" ""
    yellow = xmobarColor "#e0af68" ""

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "matplotlib" --> floatRect,
      isDialog --> doFloat
    ]
  where
    floatRect = customFloating $ W.RationalRect (1 % 5) (1 % 5) (3 % 5) (3 % 5)
