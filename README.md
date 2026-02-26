# 🛒 Retail Orders Data Analysis

![Python](https://img.shields.io/badge/Python-3.13-blue?logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.x-green?logo=pandas&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.x-orange?logo=mysql&logoColor=white)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-2.x-red?logo=sqlalchemy&logoColor=white)
![Kaggle](https://img.shields.io/badge/Dataset-Kaggle-20BEFF?logo=kaggle&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📌 Project Overview

An end-to-end data analytics project on a **retail orders dataset** sourced from Kaggle. The pipeline covers data ingestion via the Kaggle API, cleaning and transformation using Python & Pandas, loading into MySQL, and deep-dive business analysis using SQL.

The project answers **8 critical business questions** around revenue, regional performance, and year-over-year growth.

---

## 🏗️ Project Architecture

![Architecture](images/architecture.png)

```
Kaggle API
    │
    ▼  Download Dataset
Python (Raw Data)
    │
    ▼  Data Cleaning & Processing (Pandas)
Python - Pandas (Cleaned Data)
    │
    ▼  Load Data
SQL Server / MySQL
    │
    ▼  Data Analysis using SQL
Business Insights
```

---

## 🎯 Business Questions Answered

| # | Analysis |
|---|----------|
| 1 | 🔝 Top 10 highest revenue generating products |
| 2 | 🔻 Top 10 lowest revenue generating products |
| 3 | 🏷️ Revenue breakdown by product category |
| 4 | 🌍 Revenue breakdown by region |
| 5 | 📦 Top 5 best-selling products in each region |
| 6 | 📅 Month-over-month sales growth: 2022 vs 2023 |
| 7 | 🗓️ Best performing sales month for each category |
| 8 | 📈 Sub-category with highest profit growth (2023 vs 2022) |

---

## 🗂️ Project Structure

```
📦 retail-orders-analysis
 ┣ 📂 notebooks/
 ┃ ┗ 📓 Data_Analysis.ipynb      # Data ingestion, cleaning & loading pipeline
 ┣ 📂 sql/
 ┃ ┗ 📄 Analysis.sql             # All SQL business analysis queries
 ┣ 📂 images/
 ┃ ┗ 🖼️  architecture.png        # Project pipeline architecture diagram
 ┣ 📂 data/
 ┃ ┗ 📄 .gitkeep                 # Placeholder (data downloaded via Kaggle API)
 ┣ 📄 requirements.txt           # Python dependencies
 ┣ 📄 .gitignore                 # Files excluded from version control
 ┣ 📄 LICENSE                    # MIT License
 ┗ 📄 README.md
```

---

## 🧹 Data Cleaning Steps

The raw dataset required several cleaning steps before analysis:

1. **Handling missing/inconsistent values** — `'Not Available'` and `'unknown'` in `ship_mode` were treated as null values using `na_values` during CSV load
2. **Column name standardization** — All column names converted to lowercase with spaces replaced by underscores (`order_date`, `sub_category`, etc.)
3. **Feature engineering** — Three new columns were derived:
   - `discount_price` = `list_price × discount_percent × 0.01`
   - `sale_price` = `list_price − discount_price`
   - `profit` = `sale_price − cost_price`
4. **Data type correction** — `order_date` converted from `object` to `datetime64` using `pd.to_datetime()`
5. **Column removal** — Dropped `cost_price`, `list_price`, and `discount_percent` after deriving needed values

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Python 3.13 | Core scripting language |
| Pandas | Data cleaning & transformation |
| Kaggle API | Dataset ingestion |
| SQLAlchemy + PyMySQL | Loading cleaned data to MySQL |
| MySQL | Business analysis via SQL queries |
| Jupyter Notebook | Interactive analysis environment |

---

## ⚙️ Setup & How to Run

### Prerequisites
- Python 3.8+
- MySQL Server running locally
- Kaggle account with API credentials (`kaggle.json`)

### 1. Clone the repository
```bash
git clone https://github.com/chandupeddi/retail-orders-analysis.git
cd retail-orders-analysis
```

### 2. Install dependencies
```bash
pip install -r requirements.txt
```

### 3. Set up Kaggle API credentials
Place your `kaggle.json` file at:
```
~/.kaggle/kaggle.json   # Mac/Linux
C:\Users\<username>\.kaggle\kaggle.json  # Windows
```

### 4. Set up MySQL database
```sql
CREATE DATABASE orders;
```
Update your MySQL credentials in the notebook (cell with `create_engine`).

### 5. Run the Jupyter Notebook
```bash
jupyter notebook notebooks/Data_Analysis.ipynb
```
This will download the dataset, clean it, and load it into MySQL.

### 6. Run SQL Analysis
Open `sql/Analysis.sql` in **MySQL Workbench** (or any MySQL client) and run the queries.

---

## 📊 Key Insights

- 📦 Identified top and bottom 10 revenue-driving products to guide inventory decisions
- 🌍 Regional sales breakdown revealed West and East as highest-performing regions
- 📅 Month-over-month comparison between 2022 and 2023 tracked growth trends
- 🏷️ Category and sub-category analysis highlighted where profit margins were strongest
- 📈 YoY profit growth analysis pinpointed the fastest-growing sub-category in 2023

---

## 📁 Dataset

- **Source:** [Kaggle — Retail Orders by Ankit Bansal](https://www.kaggle.com/datasets/ankitbansal06/retail-orders)
- **License:** CC0 1.0 (Public Domain)
- **Records:** ~9,994 retail transactions
- **Period:** 2022–2023
- **Key Fields:** `order_id`, `order_date`, `ship_mode`, `segment`, `region`, `category`, `sub_category`, `product_id`, `sale_price`, `profit`

> **Note:** The raw dataset is not committed to this repository. It is downloaded automatically via the Kaggle API when running the notebook.

---

## 🔑 SQL Highlights

The SQL analysis file includes advanced techniques:

- **Window Functions** — `ROW_NUMBER() OVER (PARTITION BY region ORDER BY sales DESC)` for top-N per group
- **CTEs (Common Table Expressions)** — For readable multi-step aggregations
- **Conditional Aggregation (PIVOT)** — `SUM(CASE WHEN year = 2022 THEN sales ELSE 0 END)` for YoY comparison
- **Year-over-Year Growth %** — `ROUND(((sales_2023 - sales_2022) * 100.0) / sales_2022, 2)`

---

## 📋 Requirements

```
kaggle==2.0.0
pandas>=2.0.0
sqlalchemy>=2.0.0
pymysql>=1.1.0
jupyter>=1.0.0
notebook>=7.0.0
```

---

## 🙋 Author

**Peddi Chandu**

[![GitHub](https://img.shields.io/badge/GitHub-chandupeddi-181717?logo=github&logoColor=white)](https://github.com/chandupeddi)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-peddi--chandu-0A66C2?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/peddi-chandu/)

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
