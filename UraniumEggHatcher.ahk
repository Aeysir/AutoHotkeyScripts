; Go back and forth in front of the daycare in Pokemon Uranium
; Start from the middle

#MaxThreadsPerHotkey 2
#SingleInstance force

$runTimeRight := 2200
$runTimeLeft := 3100

f5::
   $stop := 0
   Loop,
   {
      Send {Right down}
      Sleep $runTimeRight
      Send {Right up}
      Send {Left down}
      Sleep $runTimeRight
      if ($stop) {
         Send {Left up}
         return
      }
      Sleep $runTimeLeft
      Send {Left up}
      Send {Right down}
      Sleep $runTimeLeft
      if ($stop) {
         Send {Right up}
         return
      }
}

f6:: $stop := 1
