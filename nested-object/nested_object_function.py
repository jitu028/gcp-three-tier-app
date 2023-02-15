import json

def get_value_from_nested_object(obj, key):
    keys = key.split('/')
    val = obj
    for k in keys:
        if k in val:
            val = val[k]
        else:
            return None
    return val

if __name__ == '__main__':
    obj_str = input('Enter the nested object in JSON format as {"a": {"b": {"c": "d"}}} : ')
    obj = json.loads(obj_str)
    key = input('Enter the key in the format of a/b/c: ')

    result = get_value_from_nested_object(obj, key)
    print(result)
