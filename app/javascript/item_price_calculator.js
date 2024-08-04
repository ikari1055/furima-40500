function initializePriceCalculation() {
  const priceInput = document.getElementById('item-price');
  const taxPriceElem = document.getElementById('add-tax-price');
  const profitElem = document.getElementById('profit');

  if (!priceInput || !taxPriceElem || !profitElem) {
    console.error('必要な要素が見つかりません。');
    return;
  }

  const calculatePrices = () => {
    const price = parseFloat(priceInput.value) || 0;
    const taxRate = 0.1; // 10% 手数料
    const taxPrice = price * taxRate;
    const profit = price - taxPrice;

    taxPriceElem.textContent = Math.floor(taxPrice);
    profitElem.textContent = Math.floor(profit);

    // 販売手数料を表示する処理
    const addTaxDom = document.getElementById('販売手数料を表示する場所のid');
    if (addTaxDom) {
      addTaxDom.innerHTML = `販売手数料は ${Math.floor(taxPrice)} 円です`;
    }
  };

  priceInput.addEventListener('input', calculatePrices);
}

window.addEventListener('turbo:load', () => {
  initializePriceCalculation();
});

window.addEventListener('turbo:render', () => {
  initializePriceCalculation();
});
