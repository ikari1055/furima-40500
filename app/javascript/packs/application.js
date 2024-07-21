document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const price = priceInput.value;
    if (price >= 300 && price <= 9999999) {
      const tax = Math.floor(price * 0.1);
      const profitValue = price - tax;
      addTaxPrice.textContent = tax;
      profit.textContent = profitValue;
    } else {
      addTaxPrice.textContent = '';
      profit.textContent = '';
    }
  });
});
