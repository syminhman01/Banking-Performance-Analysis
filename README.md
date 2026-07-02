# Banking Performance Analytics

## 1. Project Overview

This project analyzes banking performance across customers, CASA transactions, savings deposits, credit repayment, and collateral risk. The goal is to build a SQL Server and Power BI analytics solution that supports business monitoring and decision-making.

The dashboard follows the banking business flow:

Customer base  
→ CASA transactions  
→ Savings mobilization  
→ Credit disbursement and repayment  
→ Collateral risk exposure

## 2. Business Questions

1. How are customers distributed by branch, region, industry, age group, and customer type?
2. How do CASA inflow, outflow, net flow, and interbank transactions change over time?
3. How does actual savings mobilization compare with the business plan?
4. How much has the bank disbursed, how much principal remains outstanding, and which loans show overdue signs?
5. How well does collateral value cover outstanding loan exposure?

## 3. Tools Used

- SQL Server
- Power BI
- DAX
- Data Modeling
- SQL Views
- Dashboard Design

## 4. Data Model

The project uses a star-schema-oriented structure with dimension tables and fact views.

Main dimensions:

- Branch
- Customer
- Date
- Industry
- Region
- Collateral Type

Main fact views:

- Current Account Transactions
- Savings Deposits
- Mobilization Plan
- Loan Contracts and Repayments
- Collateral

## 5. Dashboard Pages

1. Executive Overview
2. Customer & Branch Analysis
3. CASA Transaction Analysis
4. Savings & Mobilization Plan
5. Credit & Repayment Analysis
6. Collateral & Risk Exposure

## 6. Key Deliverables

- SQL Server database script
- SQL fact and dimension views
- Power BI dashboard
- Data quality checks
- Dashboard screenshots
- Business insights

## 7. Dashboard Storytelling

This dashboard is designed to move from business scale monitoring to risk-oriented analysis.

First, the Customer Analysis page identifies customer distribution by branch, region, industry, age group, and customer type. Then, the CASA Transaction page analyzes money inflow, outflow, net flow, and interbank transaction behavior. After that, the Savings & Mobilization page compares actual savings deposits with the planned mobilization target.

The Credit & Repayment page focuses on loan disbursement, principal repayment, interest collection, outstanding principal, and overdue loan proxy. Finally, the Collateral & Risk Exposure page evaluates whether outstanding loans are sufficiently covered by collateral value.

## 8. Folder Structure

```text
Banking-Performance-Analytics/
│
├── 01_database/
├── 02_sql_analysis/
├── 03_powerbi/
├── 04_dashboard_screenshots/
└── 05_documentation/
