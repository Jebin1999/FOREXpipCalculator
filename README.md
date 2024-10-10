
# FOREX Pip and Profit Calculator

This Jupyter Notebook helps Forex traders calculate pip values and potential profits based on currency pairs, lot sizes, and pip movements. It fetches live exchange rates using Yahoo Finance and provides real-time calculations for pip values and profit estimation.

## Features
- **Live Exchange Rate Fetching**: Fetches live exchange rates for various currency pairs using the `yfinance` API.
- **Pip Value Calculation**: Calculates pip values based on the currency pair, lot size, and exchange rate.
- **Profit Calculation**: Estimates potential profit based on the number of pips the market has moved.
- **User Inputs**: The user can input the currency pair, lot size, and expected pip movement for instant calculations.

## How It Works

### 1. User Inputs
Users provide the following inputs:
- **Currency Pair**: e.g., `EURUSD`, `GBPJPY`
- **Lot Size**: e.g., `1.0`, `0.1`, or `0.01`
- **Pip Movement**: The expected change in pips (positive for profit, negative for loss)

### 2. Live Exchange Rate Fetching
The notebook fetches the **live exchange rate** for the selected currency pair using the Yahoo Finance API (`yfinance`).

### 3. Pip Value Calculation
The pip value is calculated based on the lot size and the exchange rate of the currency pair. The formula used is:

$$
\text{Pip Value} = \frac{\text{Pip Size}}{\text{Exchange Rate}} \times \text{Lot Size}
$$

Where:
- **Pip Size** is `0.0001` for most currency pairs, but for pairs involving JPY, it's `0.01`.
- **Exchange Rate** is the live exchange rate of the currency pair.
- **Lot Size** is the number of units being traded.

For example, in the case of EURUSD with a lot size of `1.0` and an exchange rate of `1.0965`:
$$
\text{Pip Value} = \frac{0.0001}{1.0965} \times 1.0 = 0.0000912 \, \text{USD}
$$

### 4. Profit Calculation
The profit or loss from the trade is calculated using the following formula:

$$
\text{Profit/Loss} = \text{Pip Value} \times \text{Pip Movement}
$$

Where:
- **Pip Value** is the value of one pip for the given currency pair and lot size.
- **Pip Movement** is the number of pips the market moves (can be positive for gains or negative for losses).

For example, if the pip movement is `50 pips` and the pip value is `0.0000912 USD`, the profit would be:

$$
\text{Profit} = 0.0000912 \times 50 = 0.00456 \, \text{USD}
$$

### 5. Output
The notebook provides the following outputs:
- **Live Exchange Rate** for the selected currency pair.
- **Pip Value** based on the given lot size and exchange rate.
- **Estimated Profit or Loss** based on the pip movement and pip value.

## Example Workflow

For a user trading the **EUR/USD** pair with a **lot size of 1.0** and an expected **pip movement of 50 pips**:
- If the live exchange rate is `1.0965`, the pip value will be calculated as:

  $$
  \frac{0.0001}{1.0965} \times 1.0 = 0.0000912 \, \text{USD}
  $$

- If the market moves **50 pips**, the estimated profit would be:

  $$
   0.0000912 \times 50 = 0.00456 \, \text{USD}
  $$

The notebook provides an easy way to estimate how much profit or loss a trader can expect from their trade.

## Prerequisites

Before running the notebook, install the necessary dependencies:
- **Python 3.x**
- **pandas** for data manipulation
- **yfinance** for fetching live exchange rates

You can install the required libraries using the following command:

```bash
pip install pandas yfinance
```

## How to Run the Notebook

1. Clone or download the repository.
2. Install the dependencies:
   ```bash
   pip install pandas yfinance
   ```
3. Open the `FOREXpipCalc.ipynb` notebook and run all cells.
4. Provide the required inputs (currency pair, lot size, pip movement) and view the results.

## Future Enhancements
- **Live Alerts**: Integrate live alerts for specific currency movements.
- **Leverage Support**: Add leverage calculations to estimate profit/loss with leverage.
- **Historical Data**: Add an option to analyze historical data for better trade planning.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
