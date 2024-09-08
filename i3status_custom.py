#!/usr/bin/env python3

import sys
import json
import subprocess
from datetime import datetime

def get_cpu_usage():
    cmd = "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1\"%\"}'"
    return subprocess.check_output(cmd, shell=True).decode('utf-8').strip()

def get_memory_usage():
    cmd = "free -m | awk '/Mem:/ { printf(\"%3.1f%%\", $3/$2*100) }'"
    return subprocess.check_output(cmd, shell=True).decode('utf-8').strip()

def get_battery():
    try:
        with open("/sys/class/power_supply/BAT0/capacity", "r") as f:
            capacity = int(f.read().strip())
        with open("/sys/class/power_supply/BAT0/status", "r") as f:
            status = f.read().strip()

        if status == "Charging":
            icon = "🔌"
        elif capacity < 20:
            icon = "🪫"
        elif capacity < 50:
            icon = "🔋"
        else:
            icon = "🔋"

        return f"{icon} {capacity}%"
    except FileNotFoundError:
        return ""

def print_line(message):
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def main():
    print_line(json.dumps({"version": 1}))
    print_line("[")
    print_line("[],")

    while True:
        cpu = get_cpu_usage()
        mem = get_memory_usage()
        battery = get_battery()
        date = datetime.now().strftime("%H:%M")

        data = [
            {"full_text": f"💻 {cpu}", "color": "#FF7373"},
            {"full_text": f"🧠 {mem}", "color": "#FFA500"},
            {"full_text": battery, "color": "#00BFFF"},
            {"full_text": f"🕒 {date}", "color": "#FFFFFF"}
        ]

        print_line(json.dumps(data) + ',')

if __name__ == "__main__":
    main()