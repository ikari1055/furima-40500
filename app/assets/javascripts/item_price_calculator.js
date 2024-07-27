document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPriceElement = document.getElementById('add-tax-price');
  const profitElement = document.getElementById('profit');

  function calculate() {
    const price = parseInt(priceInput.value, 10);
    if (isNaN(price) || price < 300) {
      addTaxPriceElement.textContent = '0';
      profitElement.textContent = '0';
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = Math.floor(price - tax);

    addTaxPriceElement.textContent = tax;
    profitElement.textContent = profit;
  }

  priceInput.addEventListener('input', calculate);
});
