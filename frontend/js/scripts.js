document.getElementById("toggle-darkmode").addEventListener("click", function() {
    document.body.classList.toggle("dark-mode");
})i;

document.addEventListener('DOMContentLoaded', () => {
  // Dark Mode Toggle
  const toggleButton = document.getElementById('toggle-darkmode');
  toggleButton.addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');
    toggleButton.textContent = document.body.classList.contains('dark-mode')
      ? 'Light Mode'
      : 'Dark Mode';
  });

  // Currency Switcher
  const currencySelector = document.getElementById('currency');
  const productList = document.getElementById('product-list');

  // Sample products with prices in ZAR
  const products = [
    { name: 'Product 1', price: 100, image: 'https://via.placeholder.com/150' },
    { name: 'Product 2', price: 200, image: 'https://via.placeholder.com/150' },
    { name: 'Product 3', price: 300, image: 'https://via.placeholder.com/150' },
    { name: 'Product 4', price: 400, image: 'https://via.placeholder.com/150' },
    { name: 'Product 5', price: 500, image: 'https://via.placeholder.com/150' },
    { name: 'Product 6', price: 600, image: 'https://via.placeholder.com/150' },
    { name: 'Product 7', price: 700, image: 'https://via.placeholder.com/150' },
    { name: 'Product 8', price: 800, image: 'https://via.placeholder.com/150' },
    { name: 'Product 9', price: 900, image: 'https://via.placeholder.com/150' },
    { name: 'Product 10', price: 1000, image: 'https://via.placeholder.com/150' },
  ];

  // Currency conversion rates
  const exchangeRates = {
    ZAR: 1,
    USD: 0.07, // Example conversion rate
  };

  // Function to render products with selected currency
  function renderProducts(currency) {
    productList.innerHTML = ''; // Clear existing products
    products.forEach((product) => {
      const convertedPrice = (product.price * exchangeRates[currency]).toFixed(2);
      const productElement = `
        <div class="product">
          <img src="${product.image}" alt="${product.name}">
          <h3>${product.name}</h3>
          <p>${currency} ${convertedPrice}</p>
        </div>
      `;
      productList.innerHTML += productElement;
    });
  }

  // Initial render with default currency (ZAR)
  renderProducts(currencySelector.value);

  // Update products when currency is changed
  currencySelector.addEventListener('change', (e) => {
    renderProducts(e.target.value);
  });
});

