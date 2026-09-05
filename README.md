# Customer Churn Analysis

## Project Description
An end-to-end analysis of customer churn for a telecommunications company, combining SQL
querying, statistical hypothesis testing, and machine learning classification to identify
which customers are most likely to churn and why.

## Business Problem
Customer churn directly erodes recurring revenue. The company wants to understand which
customer segments and behaviors are most strongly associated with churn, and to build a
model that can flag at-risk customers so retention efforts can be targeted proactively
rather than reactively.

## Data Source
[IBM Telco Customer Churn dataset](https://raw.githubusercontent.com/IBM/telco-customer-churn-on-icp4d/master/data/Telco-Customer-Churn.csv)
— 7,043 customer records including demographics, account/contract details, subscribed
services, billing information, and churn status (Yes/No).

## Approach
1. **SQL:** Loaded the dataset into a SQLite database and wrote a series of queries
   (in `churn_queries.sql`) covering customer overview, demographics, contract/tenure
   breakdowns, service and billing aggregations, churn-rate-by-segment analysis, and a
   top-5 highest-churn-segment query.
2. **Statistics:** Computed descriptive statistics (mean/median/std) for tenure, monthly
   charges, and total charges; ran a chi-square test of independence between contract type
   and churn; ran an independent t-test comparing monthly charges between churned and
   retained customers.
3. **Machine Learning:** Cleaned and encoded the data, trained a Logistic Regression
   baseline plus Decision Tree and Random Forest classifiers, evaluated all three on
   accuracy/precision/recall/F1, and examined Random Forest feature importances.

## Key Findings
- **Contract type is significantly associated with churn** (chi-square p ≈ 5.9e-258):
  month-to-month customers churn far more than one- or two-year contract customers.
- **Monthly charges differ significantly between churned and retained customers**
  (t-test p ≈ 8.6e-73): churned customers pay ~£74.44/month on average vs. ~£61.27/month
  for retained customers.
- **Logistic Regression was the most accurate model** (80.6% accuracy), slightly
  outperforming the Decision Tree (79.6%) and Random Forest (78.6%) — suggesting the churn
  signal is largely linear rather than driven by complex feature interactions.
- **`TotalCharges`, `tenure`, and `MonthlyCharges` are the three most predictive features**
  in the Random Forest model, together outweighing every other feature combined.
- **Recommendation:** target new, high-paying, month-to-month customers early with
  discounted incentives to switch to longer contracts, and bundle in security/tech-support
  add-ons, since both factors are statistically linked to lower churn.

## Tools Used
- Python (pandas, NumPy)
- SQLite / `sqlite3`
- SciPy (chi-square test, t-test)
- scikit-learn (Logistic Regression, Decision Tree, Random Forest, train/test split, metrics)
- Matplotlib / Seaborn (visualisations)
- Jupyter Notebook

## How to Run the Notebook
1. Clone this repository:
   ```
   git clone https://github.com/<your-username>/customer-churn-analysis.git
   cd customer-churn-analysis
   ```
2. Install dependencies:
   ```
   pip install pandas numpy scipy scikit-learn matplotlib seaborn jupyter
   ```
3. Launch Jupyter and open the notebook:
   ```
   jupyter notebook Customer_Churn_Analysis.ipynb
   ```
4. Run all cells (`Cell → Run All`). The notebook downloads the dataset directly from the
   IBM GitHub repository, so no manual data download is required.
5. To inspect the raw SQL separately, open `churn_queries.sql`.
