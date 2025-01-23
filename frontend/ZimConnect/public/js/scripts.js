let cart = [];

function addToCart(product, price) {
    cart.push({ product, price });
    updateCartUI();
}

function updateCartUI() {
    const cartItemsDiv = document.getElementById('cart-items');
    cartItemsDiv.innerHTML = cart.map(item => `<p>${item.product}: R${item.price}</p>`).join('');
}

function checkout() {
    if (cart.length === 0) {
        alert('Cart is empty!');
    } else {
        alert('Checkout successful!');
        cart = [];
        updateCartUI();
    }
}

// Toggle dark mode
document.getElementById('toggle-darkmode').addEventListener('click', () => {
    document.body.classList.toggle('darkmode');
});
