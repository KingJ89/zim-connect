from flask import Flask, jsonify, request, redirect

app = Flask(__name__)

@app.route('/api/payment/paypal', methods=['GET'])
def paypal_payment():
    return redirect("https://www.paypal.com/checkoutnow")

@app.route('/api/payment/afterpay', methods=['GET'])
def afterpay_payment():
    return jsonify({"message": "Afterpay integration coming soon."})

@app.route('/api/payment/card', methods=['GET'])
def card_payment():
    return jsonify({"message": "Enter card details to proceed."})

if __name__ == '__main__':
    app.run(port=3000, debug=True)
