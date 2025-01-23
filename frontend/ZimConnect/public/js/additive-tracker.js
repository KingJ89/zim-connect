document.addEventListener('DOMContentLoaded', () => {
    const additives = [
        { name: 'Discount on Product 1', status: 'Active' },
        { name: 'Free Shipping over $100', status: 'Expired' },
        { name: '10% Off Product 2', status: 'Active' }
    ];

    const additiveList = document.getElementById('additive-list');
    additives.forEach(additive => {
        const listItem = document.createElement('li');
        listItem.textContent = `${additive.name} - ${additive.status}`;
        additiveList.appendChild(listItem);
    });
});
