function initializePriceCalculation() {
  const priceInput = document.getElementById('item-price');
  console.log(priceInput);
  const taxPriceElem = document.getElementById('add-tax-price');
  const profitElem = document.getElementById('profit');

  if (!priceInput || !taxPriceElem || !profitElem) {
    console.error('必要な要素が見つかりません。');
    return;
  }

  const calculatePrices = () => {
    const price = parseFloat(priceInput.value) || 0;
    console.log(`入力された価格: ${price}`); // 入力された価格をコンソールに表示
    const taxRate = 0.1; // 10% 手数料
    const taxPrice = price * taxRate;
    const profit = price - taxPrice;

    console.log('イベント発火'); // イベント発火を確認するためのコンソールログ
    taxPriceElem.textContent = Math.floor(taxPrice);
    profitElem.textContent = Math.floor(profit);

    // 販売手数料を表示する処理
    const addTaxDom = document.getElementById('販売手数料を表示する場所のid');
    if (addTaxDom) {
      addTaxDom.innerHTML = `販売手数料は ${Math.round(taxPrice)} 円です`;
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
