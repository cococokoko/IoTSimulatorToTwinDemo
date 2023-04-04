import json
import logging
import os
import azure.functions as func
from azure.identity import DefaultAzureCredential
from azure.digitaltwins.core import DigitalTwinsClient

adtInstanceUrl = os.getenv("ADT_SERVICE_URL") 

def main(event: func.EventGridEvent):
    result = json.dumps({
        'id': event.id,
        'data': event.get_json(),
        'topic': event.topic,
        'subject': event.subject,
        'event_type': event.event_type,
    })
    logging.info('Python EventGrid trigger processed an event: %s', result)

    credential = DefaultAzureCredential()
    service_client = DigitalTwinsClient(adtInstanceUrl, credential)
    logging.info('ADT service client connection created.')

    # <Find_device_ID_and_choose_model>
    request = event.get_json()
    digital_twin_id = request["twin"]["deviceId"]
    properties = {"$metadata": { "$model": "dtmi:contosocom:DigitalTwins:Thermostat;1"}, "Temperature": 0.0}
    # <Find_device_ID_and_choose_model>

    created_twin = service_client.upsert_digital_twin(digital_twin_id, properties)
    logging.info('Created Digital Twin: %s', created_twin)
    

