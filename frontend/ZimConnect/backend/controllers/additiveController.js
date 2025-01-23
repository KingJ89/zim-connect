const additives = [
    { id: 1, name: 'Discount on Product 1', status: 'Active' },
    { id: 2, name: 'Free Shipping over $100', status: 'Expired' },
    { id: 3, name: '10% Off Product 2', status: 'Active' }
];

exports.getAdditives = (req, res) => {
    res.json(additives);
};
