import json
import logging
import os
import requests
import sys
import uuid
import azure.functions as func
from azure.identity import DefaultAzureCredential
from azure.digitaltwins.core import DigitalTwinsClient

adtInstanceUrl = os.getenv("ADT_SERVICE_URL") 

def main(event: func.EventGridEvent):
    credential = DefaultAzureCredential()
    service_client = DigitalTwinsClient(adtInstanceUrl, credential)
    logging.info('ADT service client connection created.')
    
    result = json.dumps({
        'id': event.id,
        'data': event.get_json(),
        'topic': event.topic,
        'subject': event.subject,
        'event_type': event.event_type,
    })
    logging.info('Python EventGrid trigger processed an event: %s', result)

    # <Find_device_ID_and_temperature>
    request = event.get_json()
    deviceId = request["body"]["deviceId"]
    temperature = request["body"]["rand_int"]
    # <Find_device_ID_and_temperature>

    logging.info("Device: %s Temperature is: %s", deviceId, str(temperature))

    # <Update_twin_with_device_temperature>
    digital_twin_id = deviceId
    patch = [
        {
            "op": "add",
            "path": "/Temperature",
            "value": temperature
        }
    ]
    service_client.update_digital_twin(digital_twin_id, patch)
    # <Update_twin_with_device_temperature>

    logging.info('Client updated: %s', patch)



