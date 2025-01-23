document.addEventListener('DOMContentLoaded', async () => {
    const additiveList = document.getElementById('additive-list');

    try {
        const response = await fetch('http://localhost:3000/api/additives');
        const additives = await response.json();

        additives.forEach(additive => {
            const listItem = document.createElement('li');
            listItem.textContent = `${additive.name} - ${additive.status}`;
            additiveList.appendChild(listItem);
        });
    } catch (error) {
        console.error('Error fetching additives:', error);
    }
});
