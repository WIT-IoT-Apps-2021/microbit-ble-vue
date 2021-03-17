<template>
  <h2>Connection</h2>
  <div class="btn-group" role="group" aria-label="micro:bit controlls">
    <button v-if="!microbit.isConnected" type="button" class="btn btn-success" @click="connectMicrobit()">Connect to micro:bit</button>
    <button v-if="microbit.isConnected" type="button" class="btn btn-danger" @click="disconnectMicrobit()">Disconnect</button>
    <button type="button" class="btn btn-primary" @click="playSound()">Play sound</button>
  </div>
  <p>microbit: {{ microbit }}</p>
</template>

<script>
// import { requestMicrobit, getServices } from 'microbit-web-bluetooth';
import * as Tone from 'tone';

export default {
  name: 'Microbit',
  data() {
    return {
      microbit: {
        isConnected: false,
        device: null,
        accelerometerDataCharacteristic: null,
        accelerometerPeriodCharacteristic: null,
        accelerometer: {
          x: 0,
          y: 0,
          z: 0
        }
      },
      microbitUuid: {
        /**
         * Services
         */
        genericAccess: ['00001800-0000-1000-8000-00805f9b34fb', 'Generic Access'],
        genericAttribute: ['00001801-0000-1000-8000-00805f9b34fb', 'Generic Attribute'],
        deviceInformation: ['0000180a-0000-1000-8000-00805f9b34fb', 'Device Information'],
        accelerometerService: ['e95d0753-251d-470a-a062-fa1922dfa9a8', 'Accelerometer Service'],
        magnetometerService: ['e95df2d8-251d-470a-a062-fa1922dfa9a8', 'Magnetometer Service'],
        buttonService: ['e95d9882-251d-470a-a062-fa1922dfa9a8', 'Button Service'],
        ioPinService: ['e95d127b-251d-470a-a062-fa1922dfa9a8', 'IO Pin Service'],
        ledService: ['e95dd91d-251d-470a-a062-fa1922dfa9a8', 'LED Service'],
        eventService: ['e95d93af-251d-470a-a062-fa1922dfa9a8', 'Event Service'],
        dfuControlService: ['e95d93b0-251d-470a-a062-fa1922dfa9a8', 'DFU Control Service'],
        temperatureService: ['e95d6100-251d-470a-a062-fa1922dfa9a8', 'Temperature Service'],
        uartService: ['6e400001-b5a3-f393-e0a9-e50e24dcca9e', 'UART Service'],
        /**
         * Characteristics
         */
        deviceName: ['00002a00-0000-1000-8000-00805f9b34fb', 'Device Name'],
        appearance: ['00002a01-0000-1000-8000-00805f9b34fb', 'Appearance'],
        peripheralPreferredConnectionParameters: ['00002a04-0000-1000-8000-00805f9b34fb', 'Peripheral Preferred Connection Parameters'],
        serviceChanged: ['00002a05-0000-1000-8000-00805f9b34fb', 'Service Changed'],
        modelNumberString: ['00002a24-0000-1000-8000-00805f9b34fb', 'Model Number String'],
        serialNumberString: ['00002a25-0000-1000-8000-00805f9b34fb', 'Serial Number String'],
        hardwareRevisionString: ['00002a27-0000-1000-8000-00805f9b34fb', 'Hardware Revision String'],
        firmwareRevisionString: ['00002a26-0000-1000-8000-00805f9b34fb', 'Firmware Revision String'],
        manufacturerNameString: ['00002a29-0000-1000-8000-00805f9b34fb', 'Manufacturer Name String'],
        accelerometerData: ['e95dca4b-251d-470a-a062-fa1922dfa9a8', 'Accelerometer Data'],
        accelerometerPeriod: ['e95dfb24-251d-470a-a062-fa1922dfa9a8', 'Accelerometer Period'],
        magnetometerData: ['e95dfb11-251d-470a-a062-fa1922dfa9a8', 'Magnetometer Data'],
        magnetometerPeriod: ['e95d386c-251d-470a-a062-fa1922dfa9a8', 'Magnetometer Period'],
        magnetometerBearing: ['e95d9715-251d-470a-a062-fa1922dfa9a8', 'Magnetometer Bearing'],
        magnetometerCalibration: ['e95db358-251d-470a-a062-fa1922dfa9a8', 'Magnetometer Calibration'],
        buttonAState: ['e95dda90-251d-470a-a062-fa1922dfa9a8', 'Button A State'],
        buttonBState: ['e95dda91-251d-470a-a062-fa1922dfa9a8', 'Button B State'],
        pinData: ['e95d8d00-251d-470a-a062-fa1922dfa9a8', 'Pin Data'],
        pinADConfiguration: ['e95d5899-251d-470a-a062-fa1922dfa9a8', 'Pin AD Configuration'],
        pinIOConfiguration: ['e95db9fe-251d-470a-a062-fa1922dfa9a8', 'Pin IO Configuration'],
        pwmControl: ['e95dd822-251d-470a-a062-fa1922dfa9a8', 'PWM Control'],
        ledMatrixState: ['e95d7b77-251d-470a-a062-fa1922dfa9a8', 'LED Matrix State'],
        ledText: ['e95d93ee-251d-470a-a062-fa1922dfa9a8', 'LED Text'],
        scrollingDelay: ['e95d0d2d-251d-470a-a062-fa1922dfa9a8', 'Scrolling Delay'],
        microbitRequirements: ['e95db84c-251d-470a-a062-fa1922dfa9a8', 'MicroBit Requirements'],
        microbitEvent: ['e95d9775-251d-470a-a062-fa1922dfa9a8', 'MicroBit Event'],
        clientRequirements: ['e95d23c4-251d-470a-a062-fa1922dfa9a8', 'Client Requirements'],
        clientEvent: ['e95d5404-251d-470a-a062-fa1922dfa9a8', 'Client Event'],
        dfuControl: ['e95d93b1-251d-470a-a062-fa1922dfa9a8', 'DFU Control'],
        temperature: ['e95d9250-251d-470a-a062-fa1922dfa9a8', 'Temperature'],
        temperaturePeriod: ['e95d1b25-251d-470a-a062-fa1922dfa9a8', 'Temperature Period'],
        txCharacteristic: ['6e400002-b5a3-f393-e0a9-e50e24dcca9e', 'Tx Characteristic'],
        rxCharacteristic: ['6e400003-b5a3-f393-e0a9-e50e24dcca9e', 'Rx Characteristic']
      }
    };
  },
  methods: {
    accelerometerDataChanged(event) {
      this.microbit.accelerometer.x = event.target.value.getInt16(0, true); // Little Endian
      this.microbit.accelerometer.y = event.target.value.getInt16(2, true); // Little Endian
      this.microbit.accelerometer.z = event.target.value.getInt16(4, true); // Little Endian

      console.log({ x: this.microbit.accelerometer.x, y: this.microbit.accelerometer.y, z: this.microbit.accelerometer.z });
      this.playSound(this.microbit.accelerometer.x);
    },
    async connectMicrobit() {
      console.log('Requesting micro:bit Bluetooth devices... ', false);
      if (!navigator.bluetooth) {
        console.error('Bluetooth not available in this browser or computer.');
      } else {
        navigator.bluetooth
          .requestDevice({
            // To accept all devices, use acceptAllDevices: true and remove filters.
            filters: [{ namePrefix: 'BBC micro:bit' }],
            optionalServices: [
              this.microbitUuid.genericAccess[0],
              this.microbitUuid.genericAttribute[0],
              this.microbitUuid.deviceInformation[0],
              this.microbitUuid.accelerometerService[0],
              this.microbitUuid.magnetometerService[0],
              this.microbitUuid.buttonService[0],
              this.microbitUuid.ioPinService[0],
              this.microbitUuid.ledService[0],
              this.microbitUuid.eventService[0],
              this.microbitUuid.dfuControlService[0],
              this.microbitUuid.temperatureService[0],
              this.microbitUuid.uartService[0]
            ]
          })
          .then((device) => {
            console.log("<font color='green'>OK</font>", true);
            this.microbit.device = device;
            console.log("Connecting to GATT server (name: <font color='blue'>" + device.name + "</font>, ID: <font color='blue'>" + device.id + '</font>)... ', false);
            device.addEventListener('gattserverdisconnected', this.onDisconnected);
            return device.gatt.connect();
          })
          .then((server) => {
            this.microbit.isConnected = true;
            console.log("<font color='green'>OK</font>", true);
            console.log('Getting Accelerometer service (UUID: ' + this.microbitUuid.accelerometerService[0] + ')... ', false);
            return server.getPrimaryService(this.microbitUuid.accelerometerService[0]);
          })
          .then((service) => {
            console.log("<font color='green'>OK</font>", true);
            console.log('Getting Accelerometer data characteristic... ', false);
            service
              .getCharacteristic(this.microbitUuid.accelerometerData[0])
              .then((dataChar) => {
                console.log("<font color='green'>OK</font>", true);
                this.microbit.accelerometerDataCharacteristic = dataChar;
                console.log('Starting accelerometer data notifications... ', false);
                return dataChar
                  .startNotifications()
                  .then(() => {
                    console.log("<font color='green'>OK</font>", true);
                    dataChar.addEventListener('characteristicvaluechanged', this.accelerometerDataChanged);
                    console.log('Getting Accelerometer period characteristic... ', false);
                    service
                      .getCharacteristic(this.microbitUuid.accelerometerPeriod[0])
                      .then((periodChar) => {
                        this.microbit.accelerometerPeriodCharacteristic = periodChar;
                        console.log("<font color='green'>OK</font>", true);
                      })
                      .catch((error) => {
                        console.error(error);
                      });
                  })
                  .catch((error) => {
                    console.error(error);
                  });
              })
              .catch((error) => {
                console.error(error);
              });
          })
          .catch((error) => {
            console.error(error);
          });
      }
    },
    playSound(x = 0) {
      var osc = new Tone.OmniOscillator().toDestination();
      osc.frequency.value = Math.abs(264 + x);
      osc.volume.value = -60;
      Tone.Transport.bpm.value = 60;
      var duration = 100;
      osc.start().stop('+' + duration);
    },
    disconnectMicrobit() {
      console.log('Disconnecting... ');
      if (!this.microbit.device) {
        console.error('There is no device connected.');
      } else {
        if (this.microbit.device.gatt.connected) {
          this.microbit.device.gatt.disconnect();
          if (!this.microbit.device.gatt.connected) {
            console.log("<font color='green'>OK</font>", true);
          }
        } else {
          console.error('There is no device connected.');
        }
      }
    },
    onDisconnected() {
      console.log('BLE Disconnect!');
      this.microbit.isConnected = false;
    }
  }
};
</script>
