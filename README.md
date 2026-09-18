<p align="center">
  <img src="Img/project_logo-noBG.png" alt="Hotel Booking Analysis logo" width="480">
</p>

<h1 align="center">Hotel Booking Analysis</h1>

<p align="center">
  An end-to-end data analysis project exploring booking, cancellation, and revenue patterns
  for a City Hotel and a Resort Hotel using <b>SQL</b>, <b>Power BI</b>, and <b>Tableau</b>.
</p>

---

## 📌 Overview

This project analyzes ~117K hotel booking records (2015–2017) to understand what drives
revenue, cancellations, and guest behavior across two hotel types. Raw booking data is
cleaned and modeled, queried with SQL to answer specific business questions, and
visualized through interactive Power BI and Tableau dashboards.

## 🗂️ Repository Structure

```
Hotel-Booking-Analysis/
├── Data/
│   ├── hotel_booking.csv            # Raw booking dataset
│   └── hotel_bookings_cleaned.csv   # Cleaned dataset used for analysis
├── Sql/
│   ├── sales.sql                    # Revenue, ADR, and lost-revenue queries
│   └── Marketing.sql                # Segment, channel, and agent performance queries
├── Power Bi/
│   └── hotel.pbix                   # Power BI dashboard
├── Tableau/
│   └── marketing.twb                # Tableau workbook
├── Img/                             # Logo and dashboard icons
└── README.md
```

## 📊 Dataset

The data covers bookings for a **Resort Hotel** and a **City Hotel** between **2015 and
2017**, with 36 fields per booking, including:

- **Stay details** — lead time, arrival date, weekend/week nights, room type
- **Guest details** — adults, children, babies, repeat-guest flag, country
- **Booking behavior** — market segment, distribution channel, deposit type, booking changes
- **Financials** — average daily rate (ADR), agent/company, special requests
- **Outcome** — cancellation status and reservation status date

`hotel_bookings_cleaned.csv` is the analysis-ready version: personally identifiable
fields (name, email, phone number, credit card) were removed, duplicates/nulls handled,
and derived fields added (`total_stay`, `total_guests`, `reservation_year`,
`reservation_month`, `room_type_changed`).

## 🔍 Key Insights

- **117,398** bookings analyzed after cleaning, split between **City Hotel** (~78K) and
  **Resort Hotel** (~39K) — City Hotel accounts for roughly two-thirds of all bookings.
- **~37% overall cancellation rate**, making cancellations one of the biggest levers on
  realized revenue.
- **Portugal (PRT)** is by far the largest source market, followed by the **UK, France,
  Spain, and Germany**.
- Revenue, ADR, and lead time vary meaningfully **by market segment and distribution
  channel**, highlighting which channels bring in higher-value, lower-risk bookings.

## 🛠️ Analysis Components

### SQL (`/Sql`)
- **`sales.sql`** — total and lost revenue by hotel, average daily rate by month,
  revenue by meal plan, and top revenue-generating countries.
- **`Marketing.sql`** — top countries and market segments by revenue, cancellation
  rate by distribution channel, top-performing agents, repeat-guest behavior, and
  average lead time by segment.

### Power BI (`/Power Bi`)
Interactive `hotel.pbix` dashboard summarizing bookings, cancellations, revenue, and
guest trends across hotel types and time.

### Tableau (`/Tableau`)
`marketing.twb` workbook focused on marketing-side metrics — segment performance,
channel mix, and booking share.

## 🧰 Tools Used

| Tool | Purpose |
|------|---------|
| SQL (T-SQL) | Data querying and business-question answering |
| Power BI | Interactive dashboarding |
| Tableau | Marketing-focused visualization |
| CSV / Excel | Raw and cleaned data storage |

## 🚀 Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/Nofal91/Hotel-Booking-Analysis.git
   ```
2. Load `Data/hotel_bookings_cleaned.csv` into your SQL environment as
   `hotel_bookings_cleaned.csv` (or update the table name in the queries) and run the
   scripts in `/Sql`.
3. Open `Power Bi/hotel.pbix` in Power BI Desktop, or `Tableau/marketing.twb` in
   Tableau, to explore the dashboards.

## 👤 Author

**Nofal91** — [github.com/Nofal91](https://github.com/Nofal91)

---
<p align="center"><i>Feel free to fork, explore, and reach out with questions or suggestions.</i></p>
