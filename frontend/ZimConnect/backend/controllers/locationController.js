exports.getLocation = (req, res) => {
    const location = {
        latitude: -17.8292, // Harare coordinates
        longitude: 31.0522
    };
    res.json(location);
};
