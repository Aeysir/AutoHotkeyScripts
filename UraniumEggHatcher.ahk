; Go back and forth in front of the daycare in Pokemon Uranium
;
; To use:
; Go to middle of long stretch directly south of daycare.
; Use F5 to start moving back and forth (at bicycle speed)
; or schedule a stop.
; Use F6 to stop right away.

#MaxThreadsPerHotkey 2
#SingleInstance force
#NoEnv

runTimeRight := 2200
runTimeLeft := 3100

runner := null

class LoopRunner {
   __New() {
      this.stopReq := 0
      this.killed := 0
   }

   travelToEndAndReturn(time, dir1, dir2) {
      Send, % "{" . dir1 . " down}"
      Sleep time
      if (this.killed) {
         return 0
      }
      Send, % "{" . dir1 . " up}"
      Send, % "{" . dir2 . " down}"
      Sleep time
      if (this.killed) {
         return 0
      }
      if (this.stopReq) {
         Send, % "{" . dir2 . " up}"
         this.kill()
         return 0
      }
      return 1
   }

   runLoop() {
      global runTimeRight
      global runTimeLeft
      Loop {
         if !this.travelToEndAndReturn(runTimeRight, "Right", "Left") {
            break
         }
         if !this.travelToEndAndReturn(runTimeLeft, "Left", "Right") {
            break
         }
      }
   }

   requestStop() {
      this.stopReq := 1
   }

   kill() {
      this.killed := 1
   }

   stop() {
      this.kill()
      Send {Right up}
      Send {Left up}
   }
}

; Start back and forth runs (from centre)
; Or again to bring to a nice stop at the centre.
f5::
   if (runner != null and runner.killed) {
      runner := null
      FileAppend, Clear runner`n, *
   }
   if (runner == null) {
      FileAppend, New runner`n, *
      runner := New LoopRunner()
      runner.runLoop()
   } else {
      FileAppend, Request Stop`n, *
      runner.requestStop()
   }
   return

; Stop Immediately
f6::
   if (runner != null) {
      FileAppend, Stop`n, *
      runner.stop()
      runner := null
   }
   return
