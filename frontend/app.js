const app = document.getElementById('app');

// Example: Dynamic product loading
fetch('http://localhost:3000/products')
  .then(response => response.json())
  .then(products => {
    app.innerHTML = products.map(product => ).join('');
  })
  .catch(err => console.error('Failed to load products:', err));
