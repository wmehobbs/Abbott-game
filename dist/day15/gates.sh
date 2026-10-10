#!/bin/bash
# Day 15 gates: compile, selftest, playtest, two rides. One Godot at a time.
cd /e/Workspace/Madison
TAG=$1
S="/c/Users/ErnieHobbs/AppData/Roaming/Godot/app_userdata/Abbott/abbott_save.json"
timeout 400 python dist/day12/run_script.py res://tools/compile_check.gd compile_check_d15_$TAG.log > /dev/null 2>&1
echo "COMPILE $(grep -c 'COMPILE ok' dist/day12/compile_check_d15_$TAG.log) errors=$(grep -c 'SCRIPT ERROR' dist/day12/compile_check_d15_$TAG.log)"
timeout 700 python dist/_run_userarg.py --selftest > /dev/null 2>&1
grep -E "SELFTEST (FAIL|SUMMARY)" dist/selftest_day.log
timeout 1900 python dist/_run_userarg.py --playtest > /dev/null 2>&1
grep -E "PLAYTEST (clear|refuse|rail|done)" dist/playtest_day.log | tail -4
for id in hk_les_001 hk_beg_035; do
  timeout 1700 python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-show --ridecert-jumpoff --ridecert-id $id > /dev/null 2>&1
  cp dist/ridecert_fresh.log dist/day15/$id.$TAG.log
  grep -E "^RIDECERT $id style" dist/day15/$id.$TAG.log | sed -E 's/(faults=[0-9]+).*(jumped=[^ ]+ t=[0-9.]+ teleported=[a-z]+).*/\1 \2/'
  grep -E "RIDECERT done" dist/day15/$id.$TAG.log | tr '\n' ' '; echo
done
cmp -s "$S" dist/day15/save_snapshot.json && echo SAVE_MATCH || echo SAVE_CHANGED
echo GATES_DONE
