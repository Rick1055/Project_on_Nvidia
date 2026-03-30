SELECT 
    release_year,
    ROUND(AVG(mem_size)::numeric,4) As avg_memory_size,
    ROUND(AVG(mem_bus_width)::numeric,4) As avg_memory_bus
FROM gpu_specs
WHERE
    release_year IS NOT NULL 
GROUP BY
    release_year
ORDER BY
    release_year
