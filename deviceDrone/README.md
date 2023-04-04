# Generate Azure IoT Device Telemetry Simulator using Docker

### Creating simulation devices using the project IotSimulatorDeviceProvisioning:

docker run -it -e "IotHubConnectionString=HostName=IoTCoco.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey=<your-iothub-key>" -e DevicePrefix= "thermostat”  mcr.microsoft.com/oss/azure-samples/azureiot-simulatordeviceprovisioning 


*Specific device thermostat67:*

az iot hub device-identity create --device-id thermostat67 --hub-name IoTCoco --resource-group ResourceCoco

docker run -it -e "IotHubConnectionString=HostName=IoTCoco.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey=<your-iothub-key>" -e DeviceList="thermostat67" -e Template="{ \"deviceId\": \"$.DeviceId\", \"rand_int\": $.Temp, \"rand_double\": $.DoubleValue, \"Ticks\": $.Ticks, \"Counter\": $.Counter, \"time\": \"$.Time\" }" -e Variables="[{name: \"Temp\", \"random\": true, \"max\": 33, \"min\": 23}, {\"name\":\"Counter\", \"min\":100, \"max\":102} ]" mcr.microsoft.com/oss/azure-samples/azureiot-telemetrysimulator


*Monitoring the IoTHub*
az iot hub monitor-events --output table --device-id thermostat67 --hub-name IoTCoco
az iot hub monitor-events --output table --hub-name IoTCoco 


### Furhter information and customizable variables 
https://learn.microsoft.com/en-us/samples/azure-samples/iot-telemetry-simulator/azure-iot-device-telemetry-simulator/


### Install dependencies
pip install azure-iot-device
