#!/usr/bin/env python3

import json
import os
import subprocess


def run_cmd(cmd):
    # print(" ".join(cmd))
    proc = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        shell=False
    )
    stdout, _ = proc.communicate()
    return stdout.decode("utf-8").splitlines()


def fill_panes(all_sessions):
    cmd = [
        "tmux", "list-panes", "-a", "-F",
        "#S\t#W\t#D\t#{pane_current_path}",
    ]
    for line in run_cmd(cmd):
        (session, window, _, path) = line.split()
        if session not in all_sessions:
            all_sessions[session] = {}
        if window not in all_sessions[session]:
            all_sessions[session][window] = []
        all_sessions[session][window].append(path)


def save_session():
    all_sessions = {}
    fill_panes(all_sessions)
    with open(os.path.join(os.environ["HOME"], ".tmux-session"), "wt") as fp:
        all_info = json.dumps(all_sessions, indent=4)
        print(all_info)
        fp.write(all_info)


def create_panes(all_sessions):
    for session, windows in all_sessions.items():
        print(f"creating session {session}")
        run_cmd(["tmux", "new-session", "-d", "-s", session, "-n", "dummy"])
        for window, panes in windows.items():
            print(f"\tcreating window {window}")
            run_cmd(["tmux", "new-window", "-d", "-t",
                    f"{session}:", "-n", window])
            for pane in panes:
                print(f"\t\tcreating pane {pane}")
                run_cmd(["tmux", "split-window", "-c",
                        pane, "-t", f"{session}:{window}"])
                run_cmd(["tmux", "select-layout", "-t",
                        f"{session}:{window}", "tiled"])
            print(f"\t\tkill dummy pane")
            run_cmd(["tmux", "kill-pane", "-t", f"{session}:{window}.0"])
            print(f"\t\ttiled layout")
            run_cmd(["tmux", "select-layout", "-t",
                    f"{session}:{window}", "tiled"])
        print(f"\tkill dummy window")
        run_cmd(["tmux", "kill-window", "-t", f"{session}:dummy"])
    for line in run_cmd(["tmux", "ls"]):
        print(line.strip())


def load_session():
    if os.path.exists(os.path.join(os.environ["HOME"], ".tmux-session")):
        with open(os.path.join(os.environ["HOME"], ".tmux-session"), "rt") as fp:
            all_sessions = json.load(fp)
            all_info = json.dumps(all_sessions, indent=4)
            print(all_info)
            create_panes(all_sessions)
    else:
        print("No saved sessions")


if __name__ == "__main__":
    my_name = os.path.basename(__file__)
    if my_name.startswith("tmux-save"):
        save_session()
    elif my_name.startswith("tmux-load"):
        load_session()
