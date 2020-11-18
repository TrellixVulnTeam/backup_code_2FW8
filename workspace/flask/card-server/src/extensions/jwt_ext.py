import json
from flask_jwt_extended import (
    JWTManager, jwt_required, create_access_token,
    get_jwt_claims
)

jwt = JWTManager()

@jwt.user_claims_loader
def add_claims_to_access_token(identify):
    return json.loads(identify)