# TDBT
DBT learning
📌 Project Overview

This project demonstrates a production-grade analytics engineering workflow using dbt Cloud integrated with GitHub and Snowflake as the data warehouse.

The goal is to transform raw e-commerce data from MercuryMart into governed, tested, and analytics-ready data marts, following modern best practices in:

Data modeling

Testing & governance

Incremental processing

Documentation & lineage

CI/CD & deployment automation

🏢 Business Context

MercuryMart is an online retail platform. Analytics teams depend on accurate data for:

Customer analytics

Revenue & finance reporting

Marketing performance

Web & conversion analytics

Raw data is ingested as CSVs and seeded into Snowflake, then transformed using dbt.

🧱 Data Sources (Seeded into Snowflake)

RAW_CUSTOMERS

RAW_ORDERS

RAW_ORDER_ITEMS

RAW_PAYMENTS

RAW_REFUNDS

RAW_PRODUCTS

RAW_SUPPLIERS

RAW_COUPONS

RAW_MARKETING_CAMPAIGNS

RAW_WEB_SESSIONS

RAW_WEB_EVENTS

RAW_INVENTORY_SNAPSHOTS

🚀 Project Stages
Stage 1: Project Setup – dbt Cloud + GitHub

What was done:

Created a dbt Cloud project connected to GitHub

Configured Snowflake connection and credentials

Set up separate environments:

DEV: per-developer schema

PROD: centralized production schema

Verified connectivity using dbt debug and initial runs

Outcome:
A deployment-ready dbt project with proper environment isolation.

Stage 2: Source Definitions & Staging Layer

What was done:

Defined dbt sources for raw tables

Implemented freshness checks for critical sources

Built staging models with:

Standardized column names

Type casting and cleaning

Deduplication logic

Created an ephemeral intermediate model for payment & refund aggregation

Key outputs:

stg_mercurymart__customers

stg_mercurymart__orders

stg_mercurymart__order_items

stg_mercurymart__products

stg_mercurymart__payments

stg_mercurymart__refunds

Outcome:
A clean, trusted staging layer acting as the foundation for analytics.

Stage 3: Core Data Models – Dimensions & Facts

What was done:

Dimension Models

dim_customers

Lifetime orders

Lifetime net spend

Loyalty tier

First order timestamp

dim_products

Category, brand, supplier

Price attributes

Fact Models

fct_orders_daily (incremental)

Grain: one row per order per day

Revenue, discounts, net sales

Payment status

fct_web_sessions (incremental)

Session duration

Engagement metrics

Conversion flag

Outcome:
Star-schema analytics marts optimized for BI and reporting.

Stage 4: Data Governance – Contracts & Versioning

What was done:

Enabled model contracts for critical models

Enforced strict schema matching

Introduced model versioning:

dim_customers → dim_customers_v2

Configured on_schema_change: fail for incremental facts

Outcome:
Strong governance with backward compatibility and schema safety.

Stage 5: Testing – Generic, Custom & Singular

What was done:

Generic tests:

unique and not_null on primary keys

relationships between facts and dimensions

accepted_values for product categories

Custom generic test:

Ensured net_sales >= 0

Singular test:

Validated no future-dated orders

Command used:

dbt test


Outcome:
Automated data quality guarantees across the warehouse.

Stage 6: Documentation, Lineage & Exposures

What was done:

Added model- and column-level documentation in schema.yml

Generated dbt Docs with full lineage

Defined BI exposures:

Revenue Performance Dashboard

Marketing Campaign Insights Report

Outcome:
Transparent, discoverable, BI-ready analytics layer.

Stage 7: Debugging, Error Handling & Recovery

What was demonstrated:

Contract enforcement failures (schema mismatch)

Missing dependency / broken lineage errors

Debugging via:

dbt logs

Compiled SQL (target/compiled)

Safe recovery using full refresh and schema alignment

Outcome:
Demonstrated operational readiness and debugging competency.

Stage 8: Performance Engineering & Incremental Optimization

What was done:

Optimized incremental models using is_incremental()

Date-based filtering to avoid full rebuilds

Explicit numeric casting to prevent schema drift

Compared full refresh vs incremental runs

Outcome:
Cost-efficient, scalable warehouse processing.

Stage 9: CI/CD & State-Aware Deployment

What was designed:

CI Pipeline (Pull Requests)
dbt build --select state:modified+


Runs only changed models + downstream dependencies

Enforces tests and contracts before merge

Production Job
dbt source freshness
dbt build


Scheduled runs

Retry logic for transient failures

Notifications on failure

Outcome:
Automated, governed deployment lifecycle from DEV to PROD.

Stage 10: Stretch Enhancements (Bonus)

What was implemented:

Model tagging (critical, finance) for selective runs

Prepared for future extensions:

Snapshots (SCD Type 2)


Example command:

dbt run --select tag:critical

🏁 Final Outcome

This project delivers a complete, enterprise-grade analytics engineering solution demonstrating:

Strong modeling fundamentals

Governance and data quality enforcement

Performance optimization

CI/CD readiness

Clear documentation and lineage
