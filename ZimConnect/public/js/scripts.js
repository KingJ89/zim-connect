document.addEventListener('DOMContentLoaded', () => {
    // Dark Mode Toggle
    const toggleDarkMode = document.getElementById('toggle-darkmode');
    toggleDarkMode.addEventListener('click', () => {
        document.body.classList.toggle('dark-mode');
    });

    // Currency Switcher
    const currencySwitcher = document.getElementById('currency');
    currencySwitcher.addEventListener('change', (event) => {
        const selectedCurrency = event.target.value;
        updatePrices(selectedCurrency);
    });

    // Cart Preview
    const cartItems = [];
    window.addToCart = (productName, price) => {
        cartItems.push({ name: productName, price });
        updateCartPreview();
    };

    const updateCartPreview = () => {
        const cartPreviewList = document.getElementById('cart-preview-list');
        cartPreviewList.innerHTML = '';
        cartItems.forEach(item => {
            const li = document.createElement('li');
            li.textContent = `${item.name} - R${item.price.toFixed(2)}`;
            cartPreviewList.appendChild(li);
        });
    };

    // Update Prices Based on Currency
    const updatePrices = (currency) => {
        const products = document.querySelectorAll('.product-item');
        products.forEach(product => {
            const priceElement = product.querySelector('.price');
            const basePrice = parseFloat(priceElement.textContent.replace('R', '').replace('$', ''));
            if (currency === 'USD') {
                priceElement.textContent = `$${(basePrice / 18).toFixed(2)}`;
            } else {
                priceElement.textContent = `R${basePrice.toFixed(2)}`;
            }
        });
    };

    // Checkout (Mockup)
    window.checkout = () => {
        if (cartItems.length === 0) {
            alert('Your cart is empty!');
        } else {
            alert('Proceeding to checkout...');
        }
    };
});

