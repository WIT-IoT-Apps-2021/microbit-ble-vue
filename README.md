# micro:bit BLE Vue

<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-8-orange.svg?style=for-the-badge)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

[![micro:bit](https://img.shields.io/badge/micro%3Abit-v2-%2300ED00?style=for-the-badge&logo=micro:bit)](https://microbit.org/new-microbit/)
[![Node](https://img.shields.io/badge/Node-v14%20LTS-%23339933?style=for-the-badge&logo=node.js)](#requirements)
[![Vue](https://img.shields.io/badge/Vue-3-%234FC08D?style=for-the-badge&logo=vue.js)](https://v3.vuejs.org/)

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/WIT-IoT-Apps-2021/microbit-ble-vue/build?style=for-the-badge)](https://github.com/WIT-IoT-Apps-2021/microbit-ble-vue/actions/workflows/build-docker.yml)

A Vue.JS web app that communicates with a [micro:bit](https://microbit.org/) using Bluetooth Low Energy (BLE) and the [Web Bluetooth API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Bluetooth_API).

## Requirements

- Node v14 (Current LTS)
- A device that supports Bluetooth Low Energy (BLE)
- A Chromium-based browser is required for Web Bluetooth support see ([here](https://caniuse.com/web-bluetooth))

## Development

Clone the repository from GitHub.

Install dependencies:

```bash
npm install
```

Run development server:

```bash
npm run serve
```

This will expose a development server on your local network (usually on port 8080). The web app should be accessible at http://localhost:8080/.

### Windows-specific Issues

If you encounter an error relating to `node-gyp` on Windows, you may needs to install some additional dependencies ([see here](https://github.com/nodejs/node-gyp#on-windows)). One of the easiest ways to do this is to install `windows-build-tools` with NPM (administrator privileges may be required).

```bash
npm install -g windows-build-tools
```

**Note:** This will install Python 2 along with some Visual Studio C++ build tools on your system.

## Running

There are multiple ways that this app can be run, the three options described below will expose a server on port 8080 over plain HTTP. Remember that HTTPS is required to use Web Bluetooth (see [ngrok](#ngrok) section).

### Option 1 - NPM

If you have the code cloned locally, you can run the development server by running:

```bash
npm run serve
```

### Option 2 - Docker

The web app can alternatively be run using Docker. To do this run:

```bash
docker run -it --rm -d -p 8080:80 --name microbit-ble-vue ghcr.io/wit-iot-apps-2021/microbit-ble-vue:latest
```

### Option 3 - Docker Compose

```yaml
version: '3.8'

services:
  microbit-ble-vue:
    image: ghcr.io/wit-iot-apps-2021/microbit-ble-vue:latest
    container_name: microbit-ble-vue
    restart: unless-stopped
    network_mode: bridge
    ports:
      - 8080:80
    security_opt:
      - no-new-privileges:true
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
```

To run using docker-compose, save the above as docker-compose.yml and run `docker-compose up -d` to bring up the container and `docker-compose down` to bring the container down when it is no longer needed

### Ngrok

A trusted HTTPS certificate is required to use Web Bluetooth. One of the easiest ways to do this is to use something like [ngrok](https://ngrok.com/).

ngrok can be downloaded as an executable or installed using NPM (this may require administrator privileges.)

```bash
npm install --global ngrok
```

to run ngrok, run:

```bash
ngrok http -region=eu 8080
```

**Note:** If you are using a port other than 8080, don't forget to update it here.

This will provide you with a HTTP and HTTPS URL that you can use to access you're development server over HTTPS and/or outside of your network.

### micro:bit

Don't forget to flash the micro:bit with firmware that enables the required Bluetooth services. See the [microbit](/microbit) folder for more details.

### Connecting the micro:bit to a desktop/laptop

You may have to enable a flag in the browser to allow Web Bluetooth connections on desktop. To do this go to the flags page, enable the `Experimental Web Platform Features` flag and re-launch the browser.

#### Browser Flags (Experiments) Page Locations

Enter the URL below in the address bar of your preferred browser to access the flags (Experiments) page

- Google Chrome/Chromium: `chrome://flags/#enable-experimental-web-platform-features`
- Microsoft Edge: `edge://flags/#enable-experimental-web-platform-features`

## Useful Tools

Some tools that you may find useful

#### [scrcpy](https://github.com/Genymobile/scrcpy)

scrcpy is a utility that provides display and control of Android devices over a USB/Wireless ADB connection.

#### [Chrome Remote Debugging](https://developers.google.com/web/tools/chrome-devtools/remote-debugging)

Chrome Remote Debugging allows you to connect the Chrome browser on your phone to Chrome DevTools on your PC. One of the main benefits of this is the ability to view the console of the page that is running on the phone.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/DylanGore"><img src="https://avatars.githubusercontent.com/u/2760449?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Dylan Gore</b></sub></a><br /><a href="https://github.com/DylanGore/microbit-ble-vue/commits?author=DylanGore" title="Code">💻</a> <a href="#ideas-DylanGore" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/JackP2112"><img src="https://avatars.githubusercontent.com/u/35736615?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jack Power</b></sub></a><br /><a href="#ideas-JackP2112" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/aaccttrr"><img src="https://avatars.githubusercontent.com/u/34109635?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Adam Cotter</b></sub></a><br /><a href="#ideas-aaccttrr" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/maxlkin"><img src="https://avatars.githubusercontent.com/u/16273613?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Max Larkin</b></sub></a><br /><a href="#ideas-maxlkin" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/robert-solomon12"><img src="https://avatars.githubusercontent.com/u/35696882?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Robert Solomon</b></sub></a><br /><a href="#ideas-robert-solomon12" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/junshuong"><img src="https://avatars.githubusercontent.com/u/45827759?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jun-Shuo Ng</b></sub></a><br /><a href="#ideas-junshuong" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://www.wit.ie/"><img src="https://avatars.githubusercontent.com/u/48127747?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Ashraf Mustafa</b></sub></a><br /><a href="#ideas-ashraf-mustafa" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/ewanhills"><img src="https://avatars.githubusercontent.com/u/23585924?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Ewan Hills</b></sub></a><br /><a href="#ideas-ewanhills" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.

## Thanks

Based on code from [https://github.com/ngammarano/microbit-web-bluetooth](https://github.com/ngammarano/microbit-web-bluetooth) and [https://github.com/thegecko/microbit-web-bluetooth](https://github.com/thegecko/microbit-web-bluetooth).
