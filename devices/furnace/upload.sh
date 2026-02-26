#!/bin/bash

# Furnace Linear Actuator Safety Client Upload Script
# Uses Arduino CLI to compile and upload to ESP32-POE-ISO

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKETCH_FILE="$SCRIPT_DIR/Furnace_Safety_client/Furnace_Safety_client.ino"
BOARD="esp32:esp32:esp32"
BUILD_DIR="/tmp/furnace_safety_build"

# Auto-detect port (first ESP32 found)
PORT="${1:-}"
if [ -z "$PORT" ]; then
    echo "[INFO] Auto-detecting ESP32 port..."
    PORT=$(arduino-cli board list --format json | \
           jq -r '.[] | select(.boards[0].name == "ESP32 Dev Module" or .boards[0].fqbn | contains("esp32")) | .port' | head -1)
    
    if [ -z "$PORT" ]; then
        echo "[ERROR] No ESP32 port detected. Please specify port as argument:"
        echo "  ./upload.sh /dev/ttyUSB0"
        echo ""
        echo "Available ports:"
        arduino-cli board list
        exit 1
    fi
fi

echo "[INFO] Using port: $PORT"
echo "[INFO] Sketch: $SKETCH_FILE"
echo "[INFO] Board: $BOARD"
echo ""

# Verify sketch exists
if [ ! -f "$SKETCH_FILE" ]; then
    echo "[ERROR] Sketch not found: $SKETCH_FILE"
    exit 1
fi

# Compile
echo "[COMPILE] Building sketch..."
mkdir -p "$BUILD_DIR"
arduino-cli compile \
    --fqbn "$BOARD" \
    --build-path "$BUILD_DIR" \
    "$SKETCH_FILE"

if [ $? -ne 0 ]; then
    echo "[ERROR] Compilation failed!"
    exit 1
fi

echo "[COMPILE] ✓ Success"
echo ""

# Upload
echo "[UPLOAD] Uploading to $PORT..."
arduino-cli upload \
    --fqbn "$BOARD" \
    --port "$PORT" \
    --build-path "$BUILD_DIR" \
    "$SKETCH_FILE"

if [ $? -ne 0 ]; then
    echo "[ERROR] Upload failed!"
    exit 1
fi

echo "[UPLOAD] ✓ Success"
echo ""
echo "[INFO] Furnace Linear Actuator Safety Client uploaded successfully!"
echo "[INFO] Device IP: 192.168.0.53"
echo "[INFO] MQTT broker: 192.168.0.100"
echo "[INFO] Commands: FORWARD, REVERSE, STOP, FORWARD:<ms>, REVERSE:<ms>"
echo ""
echo "Monitor serial output:"
echo "  arduino-cli monitor --port $PORT --config baudrate=115200"
