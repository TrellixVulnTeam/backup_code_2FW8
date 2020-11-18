from flask import jsonify


def return_json_state(statecode):
    return jsonify({
        'code': statecode
    })
