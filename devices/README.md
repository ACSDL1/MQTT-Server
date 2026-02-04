# Device Sketches

A collection of Arduino sketches for each module in the MQTT tower system. Each sketch is organized by device type in its own sketch folder, as required by the Arduino framework.

## Hardware

ESP32-based modules (Olimex ESP32-POE-ISO).

## Workflow

### Arduino CLI

1. **Install Arduino CLI**: Follow instructions at https://arduino.github.io/arduino-cli/latest/installation/
- Currently using version 1.4.1 (W26 term)


#### Linux / macOS

Navigate to the sketch folder and compile/upload:

```bash
cd <path_to_sketch>
arduino-cli compile --fqbn esp32:esp32:esp32-poe-iso <sketch_name>.ino
arduino-cli upload -p <PORT> --fqbn esp32:esp32:esp32-poe-iso <sketch_name>.ino
```

#### Windows

Navigate to the sketch folder and compile/upload (using Command Prompt or PowerShell):

```cmd
cd <path_to_sketch>
arduino-cli compile --fqbn esp32:esp32:esp32-poe-iso <sketch_name>.ino
arduino-cli upload -p <PORT> --fqbn esp32:esp32:esp32-poe-iso <sketch_name>.ino
```

**Note**: On Windows, `<PORT>` is typically `COM3`, `COM4`, etc. On Linux/macOS, it's typically `/dev/ttyUSB0` or `/dev/ttyACM0`.