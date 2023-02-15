import requests
import json

def get_instance_metadata(key):
    metadata_url = f'http://metadata.google.internal/computeMetadata/v1/instance/{key}'
    headers = {'Metadata-Flavor': 'Google'}
    response = requests.get(metadata_url, headers=headers)

    if response.status_code == 200:
        metadata = {key: response.text}
    else:
        metadata_url = 'http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true'
        response = requests.get(metadata_url, headers=headers)

        metadata = {}
        for line in response.text.splitlines():
            k, v = line.split(':', 1)
            metadata[k] = v.strip()

    return json.dumps(metadata)

if __name__ == '__main__':
    key = input("Enter the key name to retrieve: ")
    result = get_instance_metadata(key)
    print(result)
