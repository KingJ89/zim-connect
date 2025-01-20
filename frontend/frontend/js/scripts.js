document.addEventListener('DOMContentLoaded', () => {
  // Dark mode toggle
  const darkModeToggle = document.getElementById('toggle-darkmode');
  darkModeToggle.addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
  });

  // Currency switcher
  const currencySwitcher = document.getElementById('currency');
  currencySwitcher.addEventListener('change', (event) => {
    alert('Currency changed to: ' + event.target.value);
  });
});
