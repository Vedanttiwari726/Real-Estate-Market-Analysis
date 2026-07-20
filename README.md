# 🏠 Real Estate Market Analysis — Mumbai/Thane Region

An end-to-end data analytics project that cleans, explores, and visualizes a real-world real estate listings dataset using **Python (Pandas)**, **MySQL**, and **Power BI**. The project covers the full pipeline — from raw data ingestion to an interactive business dashboard — and answers key questions about pricing, location, developers, and property types in the Mumbai/Thane real estate market.

![Dashboard Preview](Real_Estate_Market_analysis.png)

---

## 📌 Project Overview

This project analyzes **13,000+ property listings** to help buyers, sellers, and analysts understand:

- Where properties are concentrated and which areas command premium prices
- How BHK configuration, property type, and furnishing status impact pricing
- Which developers dominate the market
- How price relates to covered area and other property attributes

The workflow mirrors a real-world data analyst task: **ingest → clean → store in a database → query with SQL → visualize in Power BI.**

---

## 🧰 Tech Stack

| Layer | Tools Used |
|---|---|
| Data Cleaning & EDA | Python, Pandas, Matplotlib, Jupyter Notebook |
| Database | MySQL (via SQLAlchemy + PyMySQL) |
| Querying & Analysis | SQL (MySQL) |
| Visualization | Power BI |
| Data Source | `properties.csv` (raw scraped property listings) |

---

## 📁 Repository Structure

```
├── properties.csv                              # Raw dataset (13k+ property listings, 140+ columns)
├── Real_Estate.ipynb                            # Python notebook: data cleaning + EDA
├── Real_Estate.sql                              # SQL scripts: business queries + advanced analysis
├── Real_Estate_Market_Analysis_Dashboard.pbix   # Power BI dashboard file
├── Real_Estate_Market_analysis.png              # Dashboard preview screenshot
└── README.md                                    # Project documentation
```

---

## 🧹 Step 1: Data Cleaning (Python / Pandas)

The raw dataset has 140+ columns covering pricing, amenities, location, and property specs. Cleaning steps performed in `Real_Estate.ipynb`:

- Inspected null values and duplicate rows across the full dataset
- Selected **business-relevant columns** (Price, Area Name, Location, City, Bedroom, Bathroom, Covered Area, Carpet Area, Type of Property, Developer, Floor No, Parking, Furnished Type, Facing, etc.)
- Dropped rows with missing critical fields (`Price`, `Bathroom`)
- Imputed missing values:
  - `Covered Area` / `Carpet Area` → filled with median
  - `Furnished Type`, `Ownership Type` → filled with `"Unknown"`
  - `Parking` → filled with `"Unknown"`
  - `Developer` → filled with `"Unknown"`
  - `Facing` → filled with `"Not Specified"`
- Removed a clear outlier record with an erroneous price value
- Loaded the cleaned dataset into **MySQL** using SQLAlchemy for downstream SQL analysis

---

## 📊 Step 2: Exploratory Data Analysis (Python)

Key questions explored directly in the notebook:

1. **Price distribution** — average, minimum, maximum, and top 10 most expensive listings
2. **Area-wise listings** — top 10 areas by number of properties
3. **Top 10 expensive areas** — by average price
4. **BHK distribution** — most commonly listed configuration
5. **Property type distribution** — Apartment vs. Villa vs. Penthouse vs. Builder Floor
6. **Furnished type analysis** — Furnished vs. Semi-Furnished vs. Unfurnished
7. **Top developers** — by listing volume
8. **Parking availability** across listings
9. **Price vs. Covered Area** — scatter plot to check correlation
10. **Correlation matrix** across all numeric fields

---

## 🗄️ Step 3: SQL Analysis (`Real_Estate.sql`)

The cleaned data was loaded into a MySQL database (`real_estate_db`) and queried across 6 structured sections:

| Section | Focus |
|---|---|
| **1. Business Overview** | Total properties, average/highest/lowest price, unique developer count |
| **2. Location Analysis** | Top areas by listing count and average price, areas with 100+ listings, areas priced above ₹2 Cr |
| **3. Property Configuration** | BHK-wise listings & pricing, property type and furnished-type distribution/pricing |
| **4. Developer Analysis** | Top developers by volume, average price per developer (min. 10 listings), developers with 50+ listings |
| **5. Price Analysis** | Top 10 most/least expensive properties, properties priced above overall average |
| **6. Advanced SQL** | `DENSE_RANK()` window function to rank areas by average price, properties priced above their own area's average, and a reusable **SQL View** (`Premium_Properties`) for listings above ₹5 Crore |

This section demonstrates aggregate functions, `GROUP BY`/`HAVING`, subqueries, correlated subqueries, window functions, and views.

---

## 📈 Step 4: Power BI Dashboard

The `Real_Estate_Market_Analysis_Dashboard.pbix` file presents an interactive dashboard with:

**KPI Cards**
- Total Properties: **13K**
- Average Property Price: **₹23.17M**
- Highest Property Price: **₹2.80Bn**
- Total Areas Covered: **357**

**Visuals**
- Top 10 Areas by number of property listings (bar chart)
- Average price by property type (Penthouse, Villa, Apartment, Residential, Builder Floor)
- Top 10 developers by listing count
- Count of properties by property type (donut chart)
- Count of properties by furnished type (donut chart)
- Searchable/filterable Area Name slicer panel

---

## 🔍 Key Insights

- **Apartments** dominate the listings, making up the overwhelming majority of the market.
- **Penthouses and Villas** command the highest average prices, far above standard apartments.
- A small number of **top developers** account for a disproportionately large share of listings.
- **Unfurnished** properties are the most common, followed by semi-furnished units.
- Certain areas have average prices well above ₹2 Crore, indicating strong premium micro-markets, while a much larger set of areas cater to the mid/affordable segment.

---

## 🚀 How to Reproduce

1. **Clone the repo** and install dependencies:
   ```bash
   pip install pandas sqlalchemy pymysql matplotlib jupyter
   ```
2. **Run the notebook** (`Real_Estate.ipynb`) to clean the raw CSV and push it into MySQL.
3. **Set up MySQL** locally and update the connection string in the notebook:
   ```python
   engine = create_engine("mysql+pymysql://<user>:<password>@localhost:3306/real_estate_db")
   ```
4. **Run the SQL scripts** (`Real_Estate.sql`) against the `real_estate_db` database to reproduce all business queries.
5. **Open the Power BI file** (`Real_Estate_Market_Analysis_Dashboard.pbix`) in Power BI Desktop to explore the dashboard interactively.

---

## 📬 Notes

- Dataset covers listings primarily from the **Mumbai/Thane** region.
- This project is intended for portfolio/learning purposes and demonstrates a complete analyst workflow: data cleaning → database design → SQL analysis → BI visualization.
