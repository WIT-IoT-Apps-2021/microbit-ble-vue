<template>
  <h2>Connection</h2>
  <div class="btn-group" role="group" aria-label="micro:bit controlls">
    <button type="button" class="btn btn-success" @click="connectMicrobit()" v-if="!microbit.isConnected">Connect to micro:bit</button>
    <button type="button" class="btn btn-danger" @click="disconnectMicrobit()" v-if="microbit.isConnected">Disconnect</button>
    <button type="button" class="btn btn-primary" @click="playSound()">Play sound</button>
  </div>
  <p>microbit: {{ microbit }}</p>
</template>

<script>
import { requestMicrobit, getServices } from 'microbit-web-bluetooth';
import * as Tone from 'tone';

export default {
  name: 'Microbit',
  data() {
    return {
      microbit: {
        isConnected: false,
        device: null
      }
    };
  },
  methods: {
    eventHandler(event) {
      if (event.type == 'accelerometerdatachanged') {
        console.log(event.detail);
        console.log(this.microbit.services);
      }
    },
    async connectMicrobit() {
      console.log('Requesting Bluetooth Device...');
      console.log(navigator);

      this.microbit.device = await requestMicrobit(window.navigator.bluetooth);
      if (this.microbit.device) {
        this.microbit.isConnected = true;
        this.microbit.services = await getServices(this.microbit.device);

        if (this.microbit.services.deviceInformationService) {
          console.log(await this.microbit.services.deviceInformationService.readDeviceInformation());
        }

        if (this.microbit.services.ledService) {
          await this.microbit.services.ledService.writeMatrixState([
            [1, 0, 1, 0, 0],
            [1, 1, 1, 1, 1],
            [0, 0, 1, 0, 0],
            [0, 1, 0, 1, 0],
            [1, 0, 0, 0, 1]
          ]);
          console.log(await this.microbit.services.ledService.readMatrixState());

          await this.microbit.services.ledService.setScrollingDelay(50);
          console.log(await this.microbit.services.ledService.getScrollingDelay());

          await this.microbit.services.ledService.writeText('Hello, world');
        }

        if (this.microbit.services.buttonService) {
          this.microbit.services.buttonService.addEventListener('buttonastatechanged', this.eventHandler);
          this.microbit.services.buttonService.addEventListener('buttonbstatechanged', this.eventHandler);
        }

        if (this.microbit.services.accelerometerService) {
          await this.microbit.services.accelerometerService.setAccelerometerPeriod(640);
          console.log(await this.microbit.services.accelerometerService.getAccelerometerPeriod());
          this.microbit.services.accelerometerService.addEventListener('accelerometerdatachanged', this.eventHandler);
        }
      }
    },
    async disconnectMicrobit() {
      console.log('Disconnecting...');
      if (this.microbit.device) {
        this.microbit.device.gatt.disconnect();
        if (!this.microbit.device.gatt.connected) {
          this.microbit.isConnected = false;
          console.log('Disconnect success');
        }
      }
    },
    playSound() {
      //create a synth and connect it to the main output (your speakers)
      const synth = new Tone.Synth().toDestination();

      //play a middle 'C' for the duration of an 8th note
      synth.frequency(262).playSound();
    }
  }
};
</script>
