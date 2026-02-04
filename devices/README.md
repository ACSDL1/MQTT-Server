# Device Sketches

A collection of Arduino sketches for each module in the MQTT tower system. Each sketch is organized by device type in its own sketch folder, as required by the Arduino framework.

Arduino IDE or Arduino CLI can be used to compile and upload these sketches to the respective hardware modules.

The Arduino CLI method is recommended for better version control and automation, especially when working in a team or managing multiple devices.

## Hardware

ESP32-based modules (Olimex ESP32-POE-ISO).

## Workflow

### Arduino CLI

1. **Install Arduino CLI**: Follow instructions at https://arduino.github.io/arduino-cli/latest/installation/

	- Currently using version 1.4.1 (W26 term)

2. **Install the ESP32 board package:**

```bash
arduino-cli core update-index
arduino-cli core install esp32:esp32
```

3. **Install required libraries:** (Arduino IDE can also be used here via Library Manager if preferred)

	**Arduino CLI libraries**

	```bash
	arduino-cli lib install "WiFi"
	arduino-cli lib install "PubSubClient"
	arduino-cli lib install "Adafruit ADS1X15"
	arduino-cli lib install "AutoPID"
	```

	**Manual installs (from vendor GitHub)**

	- SparkFun Qwiic Relay
	- SparkFun SerLCD


#### Compile and Upload

Navigate to the sketch folder and compile/upload:

```bash
cd <path_to_sketch>
arduino-cli compile --fqbn esp32:esp32:esp32-poe-iso <sketch_name>.ino
arduino-cli upload -p <PORT> --fqbn esp32:esp32:esp32-poe-iso <sketch_name>.ino
```

**Note**: On Windows, `<PORT>` is typically `COM3`, `COM4`, etc. On Linux/macOS, it's typically `/dev/ttyUSB0` or `/dev/ttyACM0`.