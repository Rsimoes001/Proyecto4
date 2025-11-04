from flask import Flask, jsonify, request
import random

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"message": "Aplicación desplegada correctamente"})

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    result = random.choice(["positivo", "negativo", "neutral"])
    return jsonify({"input": data, "prediccion": result})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
