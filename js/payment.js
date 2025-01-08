function payWithPayPal() {
  alert("Redirecting to PayPal...");
  window.location.href = "/api/payment/paypal";
}

function payWithAfterpay() {
  alert("Redirecting to Afterpay...");
  window.location.href = "/api/payment/afterpay";
}

function payWithCard() {
  alert("Redirecting to Card Payment...");
  window.location.href = "/api/payment/card";
}
