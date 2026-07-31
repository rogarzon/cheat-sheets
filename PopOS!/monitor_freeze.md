# Monitor Freeze Troubleshooting Guide

Emergency and diagnostic commands for when the UI freezes. You don't need to reboot — the TTY2 you already reach is enough to fix it without rebooting.

## When the UI freezes

When the UI freezes but TTY2 still works, you have three escalation levels. Try them in order — each one is cheaper than a reboot.

## Level 1 — fix the frozen session (no apps lost)

You went to TTY2 with `Ctrl+Alt+F2`. From there, the offending session is on a different TTY (the compositor is usually on TTY1 or TTY7 depending on config). First, find it:

```bash
# What is the current session and which TTY are we on?
loginctl list-sessions
who
fgconsole
```

`loginctl list-sessions` shows each session with its TTY. The frozen COSMIC session is the one with `Service=cosmic-greeter` and `State=active`.

```bash
# If you have sudo (your account is in sudoers)
sudo loginctl terminate-user omen
```

**Purpose**: `loginctl terminate-user omen` sends SIGTERM to every process owned by your user — Wayland compositor, COSMIC apps, everything. After ~90 seconds systemd escalates to SIGKILL. Cleaner than `reboot` because it shuts down the user's processes properly, flushes files, and then drops you back to the greeter for a new login. The OS keeps running, other users/TUIs/VMs are unaffected.

After this, `Ctrl+Alt+F1` (or whatever TTY the greeter is on) brings you back to the login screen.

## Level 2 — kill only the compositor (keep everything else)

If you don't want to lose your running apps, just restart the compositor itself. The frozen session ID is the one from `loginctl list-sessions` (in your case it's `3`).

```bash
# Find COSMIC's compositor PID
ps -o pid,sid,comm -C cosmic-comp
# Show which PID owns the Wayland session
loginctl show-session 3 -p Leader
```

```bash
# Replace 3602 with the actual PID of cosmic-comp
kill -TERM 3602
```

**Purpose of `kill -TERM`**: sends a clean shutdown signal. cosm-comp will save its state, close Wayland sockets, and exit. The greeter notices and respawns a fresh compositor. Your apps **get terminated** (Wayland has no way to keep them alive across compositor restart), but the kernel and any background services keep running — much faster than rebooting everything.

If `cosmic-comp` ignores SIGTERM (it sometimes does on a frozen GPU stack):

```bash
# Harder kill - this is the equivalent of "end task" in a task manager
kill -KILL 3602
```

**Purpose**: SIGKILL cannot be caught or ignored. The kernel immediately reclaims the process. Use this only when SIGTERM does nothing — apps don't get to save state.

After the compositor dies, `greetd` automatically respawns a new `cosmic-comp` and you can log back in. Forcing a re-login is the standard way out of a frozen compositor.

## Level 3 — diagnose while it's still stuck

This is the important one — without logs from the moment of the freeze, you'd be guessing. Run these **before** Levels 1 and 2 so you capture the broken state:

```bash
# 1. Save the journal for the current boot to a file you can read after restarting
journalctl -b -p err --no-pager > /tmp/freeze-errors.log
journalctl -b -g -iE 'gpu|drm|nvidia|cosmic|smithay|wayland|rust' --no-pager > /tmp/freeze-gpu.log

# 2. Snapshot process state - what was running, who was eating CPU
ps auxf > /tmp/freeze-ps.txt
# 'D' state = uninterruptible sleep, usually I/O wait. If you see a process
# stuck in D for a long time, that's the culprit doing disk I/O.
# 'R' state = running on CPU
ps -eo pid,stat,pcpu,pmem,etime,comm --sort=-pcpu | head -20 > /tmp/freeze-top.txt

# 3. Memory pressure - is the system thrashing?
cat /proc/pressure/memory > /tmp/freeze-mem-pressure.txt
cat /proc/pressure/cpu > /tmp/freeze-cpu-pressure.txt
free -h > /tmp/freeze-mem.txt

# 4. NVIDIA GPU state - is the GPU hung?
nvidia-smi > /tmp/freeze-nvidia-smi.txt
# If nvidia-smi itself hangs, the GPU is locked up. That's a strong signal.
# You can give it a timeout:
timeout 10 nvidia-smi > /tmp/freeze-nvidia-smi.txt 2>&1

# 5. DRM/HPD state - was the monitor link bouncing?
for c in /sys/class/drm/card*-*; do
  [ -e "$c/status" ] && echo "$c: $(cat $c/status)  $(wc -c < $c/edid 2>/dev/null) bytes EDID"
done > /tmp/freeze-drm.txt

# 6. Stuck kernel work - anything waiting on I/O?
cat /proc/sys/kernel/stack-trace-enabled  # usually 0
# Show what blocked processes are waiting on:
for pid in $(ls /proc | grep -E '^[0-9]+$'); do
  [ -e /proc/$pid/wchan ] && echo "PID $pid ($(cat /proc/$pid/comm 2>/dev/null)) wchan=$(cat /proc/$pid/wchan 2>/dev/null)"
done | grep -v 'wchan=0' > /tmp/freeze-wchan.txt
```

**Purpose of each**:
- `journalctl -p err` — every error from current boot. NVIDIA, cos-comp, ACPI, kernel all flow here.
- `journalctl -g gpu|drm|...` — narrower filter for the GPU/compositor stack that's the suspect.
- `ps auxf` — full process tree. Tells you what spawned what. Frozen children of a hung parent are easy to spot.
- `ps -eo stat,...` — sort by CPU. The smoking gun is usually a process eating 100% CPU when the UI locked up.
- `/proc/pressure/*` — Linux pressure stall information. If `some avg10 > 30%`, you were thrashing memory or CPU.
- `free -h` — quick memory check. If `available` is near 0 and `swap` is at 100%, you OOM'd.
- `nvidia-smi` — direct GPU query. If it hangs, the dGPU is locked up. If it returns, look at the `Gpu Util` column and `Processes` section.
- `/sys/class/drm/...` — connector state. If `DP-2` flipped from `connected` to `disconnected` around the freeze, the link dropped.
- `/proc/$pid/wchan` — kernel wait channel. `wchan=0` means running. Common values: `nvidia_wait` (GPU blocked), `inode_wait` (filesystem), `futex_wait_queue_me` (waiting on a lock).

Once you've captured these, run Level 1 or Level 2 to recover. Then from the new session, read the files — `/tmp/freeze-*.log` survives reboots but not the OS, so get them out of the system before shutting down:

```bash
# Copy out via USB, network, or just paste the contents to me in a future session
cp /tmp/freeze-*.log /home/omen/
ls -la /home/omen/freeze-*
```

## A one-liner to keep ready

Save this as `/home/omen/bin/freeze-debug.sh` and run it from TTY2 next time:

```bash
mkdir -p ~/bin
cat > ~/bin/freeze-debug.sh <<'EOF'
#!/bin/bash
set -e
outdir=/tmp/freeze-$(date +%Y%m%d-%H%M%S)
mkdir -p "$outdir"
journalctl -b -p err --no-pager > "$outdir/journal-err.log"
journalctl -b -g -iE 'gpu|drm|nvidia|cosmic|smithay|wayland' --no-pager > "$outdir/journal-gpu.log"
ps auxf > "$outdir/ps.txt"
ps -eo pid,stat,pcpu,pmem,etime,comm --sort=-pcpu > "$outdir/ps-top.txt"
free -h > "$outdir/mem.txt"
cat /proc/pressure/memory > "$outdir/psi-mem.txt" 2>/dev/null
cat /proc/pressure/cpu > "$outdir/psi-cpu.txt" 2>/dev/null
timeout 10 nvidia-smi > "$outdir/nvidia-smi.txt" 2>&1
for c in /sys/class/drm/card*-*; do
  [ -e "$c/status" ] && echo "$c: $(cat $c/status)  $(wc -c < $c/edid 2>/dev/null) bytes EDID"
done > "$outdir/drm.txt"
echo "Saved to $outdir"
ls -la "$outdir"
EOF
chmod +x ~/bin/freeze-debug.sh
```

Next time it freezes, from TTY2:

```bash
~/bin/freeze-debug.sh
```

Then either:

```bash
sudo loginctl terminate-user omen   # full session reset
# or
kill -KILL $(pgrep cosmic-comp)     # compositor-only reset
```

Once you've recovered, the output is in `/tmp/freeze-DATE/` and you can show it to me so I can tell you exactly what went wrong.

## TL;DR cheat sheet

| Want | Command |
|---|---|
| Kill whole session, get login screen | `sudo loginctl terminate-user omen` |
| Kill only the compositor, keep OS alive | `kill -KILL $(pgrep cosmic-comp)` |
| Capture diagnostics before resetting | `~/bin/freeze-debug.sh` |
| Check if GPU is hung | `timeout 10 nvidia-smi` |
| See what's eating CPU | `ps -eo pid,stat,pcpu,pmem,etime,comm --sort=-pcpu \| head -20` |
| Read recent errors | `journalctl -b -p err --no-pager \| tail -50` |
| Find which TTY I'm on | `fgconsole` |
| List all sessions | `loginctl list-sessions` |
| Last resort (avoid) | `sudo reboot` |

If you can run the debug script before resetting and share the contents of `/tmp/freeze-DATE/` next time, I can pinpoint the cause instead of guessing.
