WITH categorized_data AS(
    SELECT 
        gpu_id,
        bus AS bus_interface,
        mem_bus_width,
        CASE
            WHEN mem_type LIKE 'HBM%' THEN 'Enterprise Compute'
            WHEN mem_type LIKE 'GDDR%' THEN 'Consumer Gaming'
            WHEN mem_type IN ('DDR','DDR3','DDR4','LPDDR4X','LPDDR5','System Shared') THEN  'System Memory(Integrated/Budget)'
            WHEN mem_type IN ('VRAM','SDR','EDO','FPM','SGRAM','CDRAM','DRAM') THEN 'Legacy/Vintage'
            WHEN mem_type LIKE 'eDRAM%' THEN 'Embedded cache'
            ELSE 'Unknown'
        END AS mem_category
    FROM
        gpu_specs
    WHERE 
        bus LIKE 'PCIe%'
        AND mem_bus_width IS NOT NULL
),
aggregated_stats AS
(
    SELECT
        bus_interface,
        mem_category,
        COUNT(gpu_id) AS total_models,
        ROUND(AVG(mem_bus_width)::numeric,0) AS avg_bus_width,
        MAX(mem_bus_width) AS max_bus_width
    FROM
        categorized_data
    GROUP BY
        bus_interface,
        mem_category
),
baseline AS
(
    SELECT
        avg_bus_width AS standard_width
    FROM
        aggregated_stats
    WHERE
        bus_interface = 'PCIe 4.0 x16' 
        AND mem_category = 'Consumer Gaming'
)

SELECT
    agg.bus_interface,
    agg.total_models,
    agg.mem_category,
    agg.avg_bus_width
    /*ROUND((agg.avg_bus_width/base.standard_width )*100::numeric,2) AS rel_performance*/
FROM
    aggregated_stats AS agg
/*CROSS JOIN
    baseline AS base*/
WHERE agg.mem_category = 'Unknown'
ORDER BY 
    agg.avg_bus_width DESC;

SELECT
    agg.bus_interface,
    agg.mem_category
FROM
    aggregated_stats AS agg
WHERE
    agg.mem_category = 'Unknown'
ORDER BY
    agg.avg_bus_width
