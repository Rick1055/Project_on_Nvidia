
/*
Question: Does the data support the market consensus of AMD equipping its GPUs with more VRAM than NVIDIA?
- Focusses on modern as well as older GPUs
- Uses internal memory bus width to maintain a fair comparison between the two giants at every level of GPUs to provide a more comprehensive information.
- BONUS: Pivots the data to display NVIDIA and AMD side-bye-side for readability,and calculating the VRAM difference in each level
- Why? Demonstrates to verify market consensus using real life data and judge whether the claims are true or not.Pivoting the data makes the data more readable
       and easier to follow through,dashboard-format ready for stakeholders or buisnesses.
*/
WITH mem_bus_category AS
(
    SELECT
        gpu_id,
        manufacturer,
        mem_size AS vram,
        CASE                    -- creates hardware-tiers for a fair comparison in each category
            WHEN mem_bus_width IS NULL THEN '3-Entry/Budget(iGPU/Cloud GPUs/Unknown)'
            WHEN mem_bus_width <= 128 THEN '3-Entry/Budget'
            WHEN mem_bus_width > 128 AND mem_bus_width <=192 THEN '2-Mid-Range'
            WHEN mem_bus_width > 192 THEN '1-High-End'
        END AS mem_bus_category
    FROM
        gpu_specs
    WHERE 
        manufacturer IN ('NVIDIA','AMD')
)
SELECT
    mem_bus_category,
    ROUND(AVG(CASE WHEN manufacturer = 'NVIDIA' THEN vram END)::numeric,2) AS nvidia_avg_vram,  --pivots the data to a separate table containing just the NVIDIA average VRAM in each category mentioned above
    ROUND(AVG(CASE WHEN manufacturer = 'AMD' THEN vram END)::numeric,2) AS amd_avg_vram,         --pivots the data to a separate table containing just the AMD average VRAM in each category mentioned above
    ROUND(
        AVG(CASE WHEN manufacturer = 'AMD' THEN vram END)::numeric-
        AVG(CASE WHEN manufacturer = 'NVIDIA' THEN vram END)::numeric,2) 
     AS amd_vram_advantage   --calculates the average difference in the VRAM between AMD and NVIDIA's GPUs
FROM
    mem_bus_category
GROUP BY
    mem_bus_category
ORDER BY
   mem_bus_category

/* Why the creation of of the iGPU/Cloud GPUs/Unknown bucket is important for hardware validation?
   - All personal computers,laptops etc. do not always have dedicated GPUs for graphical processing. These machines may have 
     utilise GPUs in two ways:
       <i> Internal GPUs
       <ii> Cloud computing 
   - Internal GPUs: These are the GPUs which are built into the CPU utilised by the PC or laptop.They do not have a dedicated 
                    memory provided for their graphical processing needs instead sharing the CPUs memory space. Hence, during 
                    data entry their dedicated memory bus width gets stored as NULL in SQL.
   - Cloud Computing:  The user can also avail high level computation on their local hardware , if they want to do high-level 
                       computing while having an iGPU. This would lead the data collection to record a NULL for the memory bus 
                       width even though they are using a GPU from either AMD or NVIDIA on the cloud being recorded as manufacturer.

  The Verdict of the analysis:
   - It becomes clear from the result table that AMD provides more VRAM in each tier of graphics card as compared to NVIDIA.
   - As NVIDIA holds a massive advantage in software and professional ecosystems- like their CUDA platform for machine learning
     and DLSS for smoother gaming eperience, AMD has to compete aggressively on raw hardware value. Their primary tactic for the 
     last few generations has been offering larger VRAM buffers at lower price point to win over budget-conscious consumers and 
       bgamers who want to future-proof their builds.
*/
/*
[
  {
    "mem_bus_category": "1-High-End",
    "nvidia_avg_vram": "10.32",
    "amd_avg_vram": "11.73",
    "amd_vram_advantage": "1.41"
  },
  {
    "mem_bus_category": "2-Mid-Range",
    "nvidia_avg_vram": "6.15",
    "amd_avg_vram": "10.13",
    "amd_vram_advantage": "3.98"
  },
  {
    "mem_bus_category": "3-Entry/Budget",
    "nvidia_avg_vram": "1.60",
    "amd_avg_vram": "2.64",
    "amd_vram_advantage": "1.04"
  },
  {
    "mem_bus_category": "3-Entry/Budget(iGPU/Cloud GPUs/Unknow)",
    "nvidia_avg_vram": "3.40",
    "amd_avg_vram": "4.58",
    "amd_vram_advantage": "1.19"
  }
]
*/