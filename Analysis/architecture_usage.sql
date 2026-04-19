/*
Question: What GPU architectures have been the most heavily utilized by manufacturers, and 
          what are the top 3 most widely utilized chip designs by the big three:NVIDIA,AMD and Intel?
- Created a dedicated column containing the architecture being used by the GPU chip by leveraging the
  manufacturer and gpu_chip column.
- Aggregrates the data to calculate the total number of distinct GPUs being manufactured utilizing the
  specified architecture.
- Utilizes CTEs for better understanding and modularity of query and then physically stacks the result
  sets into a single continuous output table using the UNION ALL operator.
- Why? This metric highlights manufacturing scale/reliability and chip lifespan.It reveals how much use a 
       company gets out ofa specific chip blueprint before retiring it.By isolating the most prolific architectures
       stakeholders can pinpoint which were short-lived,transitional designs.
*/
WITH arch_count AS
(
    SELECT 
        gpu_id,
        manufacturer,
        product_name,
        release_year,
        CASE-- Creates the bucket for various chip architectures for easier and clearer identification
            --NVIDIA Architecture
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'AD1%' THEN 'NVIDIA Ada Lovelace (RTX 40-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'GA1%' THEN 'NVIDIA Ampere (RTX 30-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'TU1%' THEN 'NVIDIA Turing (RTX 20-series/GTX 16)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'GP1%' THEN 'NVIDIA Pascal (GTX 10-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'GM2%' THEN 'NVIDIA Maxwell 2.0 (GTX 900-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'GK%' THEN 'NVIDIA Kepler (GTX 600/700-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'GF%' THEN 'NVIDIA Fermi (GTX 400/500-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'GT2%' THEN 'NVIDIA Tesla (GTX 200-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'G9%' THEN 'NVIDIA G9x (8800/9800-series)'
            WHEN manufacturer = 'NVIDIA' AND gpu_chip LIKE 'NV%' THEN 'NVIDIA Legacy (GeForce 1-7)'

            --AMD/ATI Architectures
            WHEN manufacturer = 'AMD' AND gpu_chip LIKE 'Navi 3%' THEN 'AMD RDNA 3 (RX 7000-series)'
            WHEN manufacturer = 'AMD' AND gpu_chip LIKE 'Navi 2%' THEN 'AMD RDNA 2 (RX 6000-series)'
            WHEN manufacturer = 'AMD' AND gpu_chip LIKE 'Navi 1%' THEN 'AMD RDNA 1 (RX 5000-series)'
            WHEN manufacturer = 'AMD' AND gpu_chip LIKE 'Vega%' THEN 'AMD Vega'
            WHEN manufacturer = 'AMD' AND (gpu_chip LIKE 'Polaris' OR gpu_chip LIKE 'Ellesmere%' OR gpu_chip LIKE 'Baffin%') THEN 'AMD Polaris (RX 400/500)'
            WHEN manufacturer = 'AMD' AND (gpu_chip LIKE 'RV%' OR gpu_chip LIKE 'R3%' OR gpu_chip LIKE 'R4%' OR gpu_chip LIKE 'R5%') THEN 'ATI/AMD Radeon Legacy'

            --Intel Graphics
            WHEN manufacturer = 'Intel' AND (gpu_chip LIKE '%GT1' OR gpu_chip LIKE '%GT2%' OR gpu_chip LIKE '%GT3%') THEN 'Intel Integrated Graphics'
            WHEN manufacturer = 'Intel' AND gpu_chip LIKE '%DG2%' THEN 'Intel Arc (Alchemist)'

            --Game Consoles
            WHEN gpu_chip IN ('Oberon','Scarlett','Prospero') THEN 'Current Gen Console (PS5/XSX)'
            WHEN gpu_chip IN ('Liverpool','Durango','Neo','Scorpio') THEN 'Last Gen Console (PS4/Xbox One)'
            WHEN gpu_chip LIKE 'Xenos%' THEN 'Xbox 360'
            WHEN gpu_chip IN ('Flipper','Hollywood') THEN 'Nintendo GameCube/Wii'

            ELSE 'Other/Unknown'
        END AS architecture_group
    FROM
        gpu_specs
)

(
    SELECT
        manufacturer,
        architecture_group,
        (MAX(release_year)-MIN(release_year)) AS active_years, --calculates the years in which the chip architecture was being utilized by NVIDIA
        COUNT(gpu_id) AS no_of_cards
    FROM 
        arch_count
    WHERE
        architecture_group LIKE 'NVIDIA%' 
    GROUP BY 
        manufacturer,
        architecture_group
    ORDER BY
        no_of_cards DESC
    LIMIT 3
)

UNION ALL

(
    SELECT
        manufacturer,
        architecture_group,
        (MAX(release_year)-MIN(release_year)) AS active_years, --calculates the years in which the chip architecture was being utilized by AMD/ATI
        COUNT(gpu_id) AS no_of_cards
    FROM 
        arch_count
    WHERE
        architecture_group LIKE 'ATI/AMD%' OR architecture_group LIKE 'AMD%'
    GROUP BY 
        manufacturer,
        architecture_group
    ORDER BY
        no_of_cards DESC
    LIMIT 3
)

UNION ALL
(
    SELECT
        manufacturer,
        architecture_group,
        (MAX(release_year)-MIN(release_year)) AS active_years, --calculates the years in which the chip architecture was being utilized by Intel
        COUNT(gpu_id) AS no_of_cards
    FROM 
        arch_count
    WHERE
        architecture_group LIKE 'Intel%'
    GROUP BY 
        manufacturer,
        architecture_group
    ORDER BY
        no_of_cards DESC
    LIMIT 3
)


/*
[
  {
    "manufacturer": "NVIDIA",
    "architecture_group": "NVIDIA Legacy (GeForce 1-7)",
    "active_years": "23",
    "no_of_cards": "251"
  },
  {
    "manufacturer": "NVIDIA",
    "architecture_group": "NVIDIA Fermi (GTX 400/500-series)",
    "active_years": "24",
    "no_of_cards": "251"
  },
  {
    "manufacturer": "NVIDIA",
    "architecture_group": "NVIDIA Kepler (GTX 600/700-series)",
    "active_years": "15",
    "no_of_cards": "237"
  },
  {
    "manufacturer": "AMD",
    "architecture_group": "ATI/AMD Radeon Legacy",
    "active_years": "17",
    "no_of_cards": "77"
  },
  {
    "manufacturer": "AMD",
    "architecture_group": "AMD Polaris (RX 400/500)",
    "active_years": "8",
    "no_of_cards": "55"
  },
  {
    "manufacturer": "AMD",
    "architecture_group": "AMD RDNA 2 (RX 6000-series)",
    "active_years": "18",
    "no_of_cards": "42"
  },
  {
    "manufacturer": "Intel",
    "architecture_group": "Intel Integrated Graphics",
    "active_years": "11",
    "no_of_cards": "102"
  },
  {
    "manufacturer": "Intel",
    "architecture_group": "Intel Arc (Alchemist)",
    "active_years": "1",
    "no_of_cards": "9"
  }
]
*/
