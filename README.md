# GPU Specs Analysis

A data analysis project examining GPU specifications across NVIDIA, AMD, and Intel — covering decades of GPU history, architectural trends, memory technology evolution, and performance scaling. Results are presented through two interactive Tableau Public dashboards.

---

## • Table of Contents

→ [Project Overview](#project-overview)  
→ [Dataset](#dataset)  
→ [Tech Stack](#tech-stack)  
→ [GPU Tier Classification](#gpu-tier-classification)  
→ [Analysis Performed](#analysis-performed)  
→ [Key Insights](#key-insights)  
→ [Tableau Dashboards](#tableau-dashboards)  
→ [How to Explore the Dashboards](#how-to-explore-the-dashboards)  
→ [Roadmap](#roadmap)  
→ [Project Structure](#project-structure)  
→ [Getting Started](#getting-started)  
→ [Acknowledgements](#acknowledgements)  

---

## • Project Overview

This project analyses historical and current GPU specifications across the three major manufacturers — NVIDIA, AMD, and Intel. The goal was to find patterns in GPU development, understand how memory technology and bus interfaces have changed over time, compare how manufacturers position their products across price tiers, and examine the relationship between hardware scaling and performance metrics.

The pipeline works as follows: raw data is first cleaned and enriched using **Python (Pandas)**, then loaded into a **PostgreSQL** database where all core analysis is done through SQL queries. The entire setup is **containerized with Docker**, so the database environment can be reproduced on any machine without manual configuration. Findings are then visualized through two interactive **Tableau Public** dashboards.

---

## • Dataset

| Property | Details |
|---|---|
| **Source** | [Kaggle — GPU Specifications Dataset](https://www.kaggle.com) |
| **Manufacturers Covered** | NVIDIA, AMD, Intel |
| **Total GPU Models** | 5,090+ distinct entries |
| **Key Columns** | Manufacturer, Architecture, Release Year, VRAM (GB), Memory Type, Bus Interface, Unified Shaders, Clock Speed, TDP, GPU Type |

---

## • Tech Stack

| Tool | Purpose |
|---|---|
| **Python** | Data cleaning, transformation, and pipeline scripting |
| **Pandas** | Cleaning raw data, type coercion, deduplication, and engineering the `gpu_id` column |
| **PostgreSQL** | Core analysis engine — all aggregations, comparisons, baselining, and trend queries |
| **Docker & Docker Compose** | Containerizing the PostgreSQL environment for reproducibility across systems |
| **Tableau Public** | Dashboard design and visualization |
| **GitHub** | Version control and project hosting |

---

## • GPU Tier Classification

GPUs in this project are grouped into four tiers based on **VRAM capacity**, which serves as a practical proxy for market positioning:

| Tier | VRAM Criteria | Description |
|---|---|---|
| **Entry** | < 8 GB or iGPU | Budget and integrated graphics |
| **Mid-Range** | >= 8 GB and <= 12 GB | Mainstream consumer gaming |
| **High-End** | > 12 GB and <= 24 GB | Enthusiast gaming and prosumer workloads |
| **Enthusiast** | > 24 GB | Workstation, AI/ML, and professional compute |

---

## • Analysis Performed

Three types of analysis were carried out, with all core querying done in **PostgreSQL** and results pulled into Tableau for visualization:

**1. Exploratory Data Analysis (EDA)**  
Profiling the dataset to understand distributions, null values, outliers, and feature relationships. This included tier breakdowns per manufacturer and overall market composition, queried via `card_type_count.sql` and `VRAM_tiers.sql`.

**2. Brand Comparison (NVIDIA vs AMD vs Intel)**  
A comparison of how each manufacturer distributes their GPU portfolio across tiers, how their VRAM figures compare within equivalent tiers, and which architectures have produced the most cards over the longest periods. Powered by `vram_comparison.sql` and `architecture_usage.sql`.

**3. Trend Analysis Over GPU Generations**  
A look at how key metrics — VRAM capacity, memory technology, clock speeds, unified shader counts, and bus interface standards — have changed across release years. This covers periods such as the Crypto Mining Boom, Node Stagnation, and the Chiplet Revolution. The PCIe bandwidth study was done via `relative_bandwidth_baselining.sql`.

---

## • Key Insights

---

### 1. Market Share by Tier

NVIDIA leads the GPU market at every tier. AMD holds a consistent second position. Intel is largely an integrated graphics manufacturer with a small but growing discrete GPU presence.

| Tier | NVIDIA | AMD | Intel |
|---|---|---|---|
| Entry | 2,069 | 973 | 27 |
| Mid-Range | 244 | 180 | 20 |
| High-End | 127 | 60 | 16 |
| Enthusiast | 61 | 31 | 4 |

Entry-level cards make up the vast majority of the total market with **4,349 distinct models**, followed by mid-range (444), high-end (203), and enthusiast (96).

---

### 2. AMD Offers More VRAM Per Tier Than NVIDIA

Despite NVIDIA's volume advantage, AMD cards provide more VRAM on average across all four tiers, with an overall average difference of **1.95 GB**. The gap is largest in the Mid-Range segment, where AMD leads by approximately **3.96 GB**.

#### Why: The iGPU / Cloud GPU / Unknown Bucket — Hardware Validation

Before comparing VRAM across manufacturers, a data validation step was needed. Not all machines use a dedicated GPU — consumer hardware handles graphics in two other ways:

→ **Integrated GPUs (iGPUs):** These are GPUs built directly into the CPU die. They do not have dedicated video memory and instead share the CPU's RAM for graphical processing. Because there is no physical memory bus of their own, their `memory_bus_width` value is stored as `NULL` in the database. Including these in a VRAM comparison would pull averages down and misrepresent what dedicated graphics cards actually deliver.

→ **Cloud Computing GPUs:** A user with only an iGPU can access high-end GPU compute remotely through cloud services. In these cases, the data records the cloud GPU's manufacturer (AMD or NVIDIA) as the source, but since no local dedicated memory bus exists on the end-user's machine, `memory_bus_width` is again stored as `NULL`.

These two scenarios create an **iGPU / Cloud / Unknown bucket** — entries that carry a manufacturer label but a `NULL` bus width, which cannot be meaningfully compared on VRAM metrics. Filtering this bucket out was necessary to ensure the comparison only covers **discrete, locally-installed GPU hardware** and reflects real-world purchasing conditions.

#### Verdict

With data integrity confirmed, the result is clear: **AMD provides more VRAM at every tier than NVIDIA**. This is not accidental — it reflects a deliberate competitive position. NVIDIA holds a strong advantage in software and professional ecosystems: their **CUDA platform** is the standard for machine learning and AI compute, and technologies like **DLSS** give NVIDIA cards a measurable edge in gaming performance. Competing on software is not a short-term option for AMD, so they compete on raw hardware value instead. Their consistent approach over recent generations has been to offer larger VRAM buffers at lower price points, targeting budget-conscious consumers and gamers who want to future-proof their builds — a segment where extra VRAM has real and perceived value.

---

### 3. PCIe Generational Performance — Consumer vs Enterprise

Using **relative baselining on bus width**, a comparative PCIe performance table was built. Key findings:

| Transition | Consumer Gaming Impact | Enterprise Computing Impact |
|---|---|---|
| PCIe 2.0 to 3.0 x16 | ~2% improvement | ~2% improvement |
| PCIe 3.0 to 4.0 x16 | **~40% improvement** *(largest consumer jump)* | Moderate |
| PCIe 4.0 to 4.0 x16 (enterprise config) | — | **~262% improvement** |
| PCIe 4.0 to 5.0 x16 (enterprise) | Not commonly used in gaming | **~544% improvement** |

> The PCIe 3.0 to 4.0 x16 transition is the single largest generational bandwidth jump for consumer gaming. PCIe 5.0 x16 is currently used in enterprise and AI compute contexts and has not been widely adopted in the consumer gaming market.

---

### 4. NVIDIA — Most Prolific Architectures

| Architecture | Era Span | Cards Released |
|---|---|---|
| NVIDIA Legacy (GeForce 1–7 series) | ~23 years | 251 cards |
| NVIDIA Fermi (GTX 400/500 series) | ~24 years | 251 cards |
| NVIDIA Kepler (GTX 600/700 series) | ~15 years | 237 cards |

NVIDIA's early architectures remained in production or derivative form for long stretches of time, reflecting broad market coverage across budget to enthusiast segments.

---

### 5. AMD — Most Prolific Architectures

| Architecture | Era Span | Cards Released |
|---|---|---|
| ATI/AMD Radeon Legacy | ~17 years | 77 cards |
| AMD Polaris (RX 400/500 series) | ~8 years | 55 cards |
| AMD RDNA 2 (RX 6000 series) | ~18 years | 42 cards |

AMD's RDNA 2 has maintained a long production run, reflecting its competitive position across mainstream and high-end segments.

---

### 6. Intel — Architecture Snapshot

| Architecture | Era Span | Cards Released |
|---|---|---|
| Intel Integrated Graphics | ~11 years | 102 cards |
| Intel Arc (Alchemist) | ~1 year | 9 cards |

Intel's GPU presence is almost entirely integrated graphics. The Arc Alchemist release marks Intel's first serious entry into the discrete GPU market.

---

## • Tableau Dashboards

---

### Dashboard 1 — GPU Market Landscape

An overview of the GPU market focused on manufacturer strategy, portfolio distribution, and memory trends.

**Line Chart — VRAM Evolution Over Time**  
Tracks how average VRAM per GPU has changed year-over-year. Filters based on selections made in the architecture bar chart.

**Stacked Horizontal Bar Chart — Architectures by Card Count**  
Lists each manufacturer's architectures with the number of GPU models per architecture. Each bar is broken down by tier (Entry / Mid-Range / High-End / Enthusiast), allowing cross-architecture and cross-tier comparisons.

**Donut Chart — Tier Distribution by Manufacturer**  
The centre of the donut shows the total GPU count per company. The outer ring breaks this into the four tiers, giving a direct view of each company's product spread.

**Interactivity**  
Clicking any bar in the architecture chart cross-filters both the line chart and the donut chart, isolating that architecture's VRAM trends and tier breakdown. A toggle control allows integrated GPUs to be included or excluded from all views.

---

### Dashboard 2 — Hardware Scaling and Technology Evolution

A technical dashboard focused on how GPU internals have developed over time and how compute scaling relates to memory growth.

**Line Chart — Clock Speed and Shader Correlation Over Time**  
Plots GPU clock speed trends alongside unified shader counts per year. Reference bands mark three notable periods in GPU history:

→ **Crypto Mining Era** (2017–2020)  
→ **Node Stagnation Era** (2012–2016)  
→ **Chiplet Revolution Era** (2020–2025)  

Each era has its own toggle button. Annotations on the chart explain key spikes and anomalies directly.

**Line Chart — Memory Type Usage Trends**  
Tracks which memory technologies have grown and declined in adoption across years. Five memory categories are covered:

→ Consumer Gaming: GDDR1 through GDDR7  
→ Enterprise/HPC: HBM1, HBM2, HBM3  
→ System Memory: LPDDR, DDR variants  
→ Embedded Cache: eDRAM  
→ Legacy/Vintage: SDRAM, DRAM, VRAM, CDRAM, SGR, FPM, EDO  

Tooltips show which specific memory subtype is dominant within each broader category for a given year.

**Scatter Plot — Hardware Scaling (Unified Shaders vs VRAM)**  
Plots unified shader count against VRAM allocation to show how compute capacity and memory have scaled together across architectures. Acts as a global filter for both line charts. Outliers are annotated with architectural context.

**Interactivity**  
All three charts are cross-linked. Selecting a cluster in the scatter plot filters the line charts to show how those architectures affected clock speed trends and memory technology adoption. Tooltips are available on every data point across all charts.

Both dashboards use dynamic sizing and are built for readability across screen resolutions.

---

## • How to Explore the Dashboards

→ Open the dashboard on **Tableau Public** via the link in this repo, or download the `.twbx` file and open it in the free Tableau Public desktop app.  
→ Start with **Dashboard 1** for an overview of the GPU market.  
→ Click any architecture bar to cross-filter the VRAM line chart and donut chart.  
→ Use the **iGPU toggle** to compare the market with and without integrated graphics.  
→ Move to **Dashboard 2** for a hardware-level breakdown.  
→ Toggle GPU eras on and off on the clock speed chart to isolate specific periods.  
→ Click on scatter plot clusters to filter memory and clock speed trends by architecture.  
→ Hover over any data point to access detailed tooltips.  

---

## • Roadmap

Possible extensions ranked by effort and impact:

---

### Priority 1 — High Impact, Low Effort

**Price-Performance Analysis**  
Join current GPU prices from sources like PCPartPicker or Newegg and calculate a performance-per-dollar score. This is one of the most common GPU buying questions and would make the project directly useful.

**Statistical Hypothesis Testing**  
Use t-tests or Mann-Whitney U tests to confirm whether AMD's VRAM advantage over NVIDIA is statistically significant across tiers, rather than just observed in averages.

**Correlation Heatmap**  
Build a Pearson or Spearman correlation matrix across numeric features (VRAM, TDP, clock speed, shader count, bus width) to identify relationships between hardware specs.

---

### Priority 2 — Intermediate Extensions

**GPU Clustering with K-Means**  
Cluster GPUs by spec profile rather than manufacturer-defined tiers. The key question: does the data-driven grouping match the VRAM-based tier system used in this project?

**Power Efficiency Analysis**  
Plot shader count or benchmark performance against TDP to identify which architectures deliver the most compute per watt — relevant given rising energy costs in AI and ML workloads.

**Streamlit Web App**  
Convert key analyses into a Streamlit app so anyone can interact with the data in a browser without needing Tableau or Python.

---

### Priority 3 — Advanced Extensions

**Price Prediction Model**  
Train a regression model (Random Forest or XGBoost) to predict GPU price from specs. Identify which features — VRAM, architecture generation, bus interface — carry the most weight.

**Time Series Forecasting**  
Extend the VRAM and clock speed trend lines into a forecast. Use Prophet or ARIMA to estimate what GPU specs might look like by 2027–2028 based on historical growth.

**Sentiment Analysis on GPU Reviews**  
Scrape user reviews for major GPU releases and run sentiment analysis. Cross-reference results against spec data to see whether user satisfaction tracks with objective hardware metrics.

---

## • Project Structure

```
GPU_specs_Analysis/
│
├── transform.py                           # Data cleaning pipeline (Pandas)
│                                          # → Cleans raw Kaggle CSV, fixes types,
│                                          #   handles nulls, and engineers gpu_id
│
├── docker-compose.yaml                    # Docker Compose configuration
│                                          # → Spins up a PostgreSQL container with
│                                          #   the cleaned dataset pre-loaded
│
├── Analysis/
│   ├── VRAM_tiers.sql                     # Classifies GPUs into Entry/Mid/High/Enthusiast tiers
│   ├── vram_comparison.sql                # NVIDIA vs AMD VRAM comparison by tier
│   ├── architecture_usage.sql             # Card counts and longevity per architecture
│   ├── card_type_count.sql                # Total model counts by manufacturer and tier
│   └── relative_bandwidth_baselining.sql  # PCIe generation performance comparison
│
└── README.md
```

---

## • Getting Started

---

### Prerequisites

| Prerequisite | Why It's Needed |
|---|---|
| [Python 3.8+](https://www.python.org/downloads/) | To run `transform.py` for data cleaning |
| [Pandas](https://pandas.pydata.org/) | Used inside `transform.py` for cleaning and transformation |
| [Docker Desktop](https://www.docker.com/products/docker-desktop/) | To spin up the PostgreSQL container via Docker Compose |
| [PostgreSQL client](https://www.postgresql.org/download/) *(optional)* | To connect to the running container and run SQL queries — pgAdmin or DBeaver both work |
| [Tableau Public](https://public.tableau.com/en-us/s/download) *(free)* | To open and interact with the dashboards |

> **Note on PostgreSQL:** You do not need to install a PostgreSQL server locally — Docker handles that entirely. A client like [pgAdmin](https://www.pgadmin.org/) or [DBeaver](https://dbeaver.io/) is only needed if you want to run or inspect queries interactively.

---

### Installation and Setup

#### Step 1 — Clone the repository

```bash
git clone https://github.com/Rick1055/GPU_specs_Analysis.git
cd GPU_specs_Analysis
```

#### Step 2 — Install Python dependencies

```bash
pip install pandas
```

#### Step 3 — Run the data cleaning pipeline

```bash
python transform.py
```

> `transform.py` reads the raw Kaggle GPU dataset, applies all cleaning steps (type coercion, null handling, deduplication), and generates a `gpu_id` column. This synthetic identifier was necessary because many GPUs share the same product name but come in different VRAM configurations — for example, the same model sold as 8 GB and 12 GB variants. Without `gpu_id`, these entries would be indistinguishable in the database.

#### Step 4 — Start the PostgreSQL container

```bash
docker-compose up -d
```

> This reads `docker-compose.yaml` and starts a pre-configured **PostgreSQL container** with the cleaned dataset loaded and ready to query. **No local PostgreSQL installation is required.** Docker was used deliberately — it ensures anyone cloning this repo gets an identical database environment regardless of operating system, removing setup inconsistencies.

#### Step 5 — Run the SQL analyses

Connect to the running container using your preferred PostgreSQL client (pgAdmin, DBeaver, or `psql`) with the credentials in `docker-compose.yaml`, then open and run any file from the `Analysis/` folder:

| File | What It Does |
|---|---|
| `VRAM_tiers.sql` | Assigns each GPU to a tier based on VRAM thresholds |
| `vram_comparison.sql` | Compares average VRAM between NVIDIA and AMD per tier |
| `architecture_usage.sql` | Ranks architectures by card count and calculates their active lifespan |
| `card_type_count.sql` | Counts total GPU models per manufacturer and tier |
| `relative_bandwidth_baselining.sql` | Baselines PCIe bus widths to compare generational bandwidth gains |

#### Step 6 — Explore the Dashboards

Open the Tableau Public link in this repo or download the `.twbx` file and open it in the Tableau Public desktop app.

---

### Stopping the Container

```bash
docker-compose down
```

---

## • Acknowledgements

→ Dataset sourced from [Kaggle](https://www.kaggle.com)  
→ GPU architectural history referenced from the TechPowerUp GPU Database and Wikipedia  
→ Tableau Public community for dashboard design reference  

---

*First serious data analysis project. Feedback is welcome.*
