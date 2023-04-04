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

    # <Find_device_ID>
    request = event.get_json()
    digital_twin_id = request["twin"]["deviceId"]
    # <Find_device_ID>

    deleted_twin = service_client.delete_digital_twin(digital_twin_id)
    logging.info('Deleted Digital Twin: %s', deleted_twin)
    
