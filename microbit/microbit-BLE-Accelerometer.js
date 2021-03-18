bluetooth.onBluetoothConnected(function () {
  basic.showIcon(IconNames.Yes);
  basic.clearScreen();
});
bluetooth.onBluetoothDisconnected(function () {
  basic.showIcon(IconNames.No);
  basic.clearScreen();
});
bluetooth.startAccelerometerService();
