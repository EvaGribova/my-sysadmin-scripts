#!/usr/bin/env bash

INTERVAL=10
LOG_FILE="monitor.log"

if ! command -v free >/dev/null 2>&1; then
    echo "Ошибка: команда free не найдена." >&2
    exit 1
fi

if ! command -v df >/dev/null 2>&1; then
    echo "Ошибка: команда df не найдена." >&2
    exit 1
fi

if ! command -v uptime >/dev/null 2>&1; then
    echo "Ошибка: команда uptime не найдена." >&2
    exit 1
fi

if ! touch "$LOG_FILE" 2>/dev/null; then
    echo "Ошибка: невозможно создать или открыть файл $LOG_FILE." >&2
    exit 1
fi

while true; do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free 
        df 
        uptime
        echo
    } >> "$LOG_FILE"

    sleep "$INTERVAL"
done
