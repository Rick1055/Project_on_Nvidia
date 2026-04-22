/* Question: What is the tier of the GPU?
    - Identify the target audience for the GPU
    - Removes the GPUs which have memory size listed as nulls(to avoid taking integrated gpus into consideration)
    -Why? A clear distinction between tiers of GPU facilitates customers or new pc builders to make an informed choice on the GPU 
     they purchase based on their needs
*/
WITH vram_tier AS
(
  SELECT
    gpu_id,
    manufacturer,
    product_name,
    igp,
    mem_size AS vram,
    CASE
         WHEN mem_size < 8 OR igp = 'Yes'  THEN 'Entry Level Card'
         WHEN mem_size >= 8 AND mem_size <=12 THEN 'Mid Level Card'
         WHEN mem_size > 12 AND mem_size <=24 THEN 'High Level Card'
         WHEN mem_size > 24 THEN 'Enthusiast Card'
    END AS vram_category
  FROM
      gpu_specs
  WHERE  
      mem_size IS NOT NULL --filters out the data which is completely missing from the database
)
SELECT
   vram_category,
   COUNT(gpu_id) AS no_of_cards
FROM
  vram_tier
GROUP BY
  vram_category

/* Why the categorization of all integrated graphics cards into entry level cards?
   -Integrated GPUs have always been disregarded by the newcomers in the GPU community due to the belief that they don't hold a candle to the 
    power of a dedicated GPU, which was true until the few the recent years.

   -The integrated graphics card that our generation grew up with(Mostly Intel UHD and older HD lines) were notoriously weak in handling gaming 
    or any kind of 3D work and were only good at rendering basic desktop environments.

   -All of this changed when AMD introduced their Ryzen Processors paired with their Vega Integrated Graphics.By combining their higly efficient
    CPU architecture and their esatblished Radeon Graphics technology, AMD created the APUs that could finally consistently handle gaming and 3D
    workloads at 720p or 1080p.The sales spoke for themselves and turned the heads of the giants in the industry.

   -This forced the industry to stop viewing integrated GPUs as an afterthought but rather as a means to expand their market into the huge domain 
    of customer pool which consisted of people who wanted to game or perform 3D rendering but were on a tight budget.

   -Since then the giants of the CPU industry have not stopped in making their integrated GPU better and better ,with the year 2020 beginning the
    huge shift. This year saw Intel completely overhauled their architecture with their 11th-Gen "Tiger Lake" processors ,IrisXe effectively doubled 
    the performance of their older UHD graphics.Along with this, Apple also abandoned Intel processors and introduced their own propietory ARM-based
    System on a Chip(SoC).The M1 featured a "Unified Memory Architecture" making it ultra fast and consistently beating out or matching mid-range 
    laptop GPUs of the time.

   -Currently,the Intel Arc series and AMD Radeon series of processors have shown to match and beat the performance of older generation entry-level
    cards and natively run modern AAA-titles natively along with features like hardware accelarated ray-tracing.
*/

/*
[
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4050",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A350M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A370M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A380",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A550M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A730M",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A770",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A770M",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A780",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arctic Sound-M",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX550",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX570",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 8 GB GA107",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 OEM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Ti GA103",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti 20 GB",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3090 Ti",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4080",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4080 Ti",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4090",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 PCIe",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 SXM5",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6400",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6300M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6400",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6500 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6500M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600S",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6650 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6650M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6650M XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700S",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6750 XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800S",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6850M XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6950 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7700 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7800 XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7900 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5500",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5500 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Steam Deck GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A10 PCIe",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 PCIe 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A10G",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A16 PCIe",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A2",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A30 PCIe",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arctic Sound 1T",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arctic Sound 2T",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 170HX",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 30HX",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 40HX",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 50HX",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 70HX",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 90HX",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1010",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1010 DDR4",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2050 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Ti Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Ti Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 GA104",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "PG506-232",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "PG506-242",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1200 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI210",
    "igp": "No",
    "vram": 64,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI250",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI250X",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V620",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6600",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6600M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6800",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6800X",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6800X Duo",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6900X",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700 XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700M",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800M",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A1000 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 Embedded",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4000",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4000 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Embedded",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Mobile",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A500 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5000",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5000 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T1000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T1000 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T400",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T400 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T600",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T600 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 PCIe",
    "igp": "No",
    "vram": 40,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 SXM4 40 GB",
    "igp": "No",
    "vram": 40,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 SXM4 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A40 PCIe",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "AeroBox GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Atari VCS 400 GPU",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Atari VCS 800 GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 GDDR6",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Ti Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Ti Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Ti Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 TU106",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 TU116",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX330",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX450 25W",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX450 30.5W 10Gbps",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX450 30.5W 8Gbps",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 TU104",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Max-Q Refresh",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Mobile Refresh",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 SUPER Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 SUPER Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 SUPER Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 SUPER Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Ti",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3090",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID A100A",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID A100B",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-16",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-4",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-8",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "H3C XG310",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Iris Xe MAX Graphics",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 5 GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000 Mobile Refresh",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 6000 Mobile",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1000 Mobile GDDR6",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI100",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5300",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5500 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5600M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5700",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5700 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V520",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro VII",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5500",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5500M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5300",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5600 OEM",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5600 XT",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5600M",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 590 GME",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6900 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A6000",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T500 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox Series S GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox Series X GPU",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Mobile 3 GB",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 SUPER",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 SUPER",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 Ti",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 Ti Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 Ti Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX150 GP107",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX230",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX250",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX250",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Max-Q Refresh",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Mobile Refresh",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 SUPER",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 SUPER",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 SUPER",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P106M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2000 Mobile",
    "igp": "No",
    "vram": 3.75,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2200",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P520 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 3000 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 3000 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 3000 Mobile Refresh",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 4000 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 4000 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1000 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T2000 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T2000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 540 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 540X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 610 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon VII",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 620 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 625 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 630 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9390 PCIe",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9560 PCIe",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5300M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5500M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 570X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 575X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 580X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 48",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 64X",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega II",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega II Duo",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5300M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5700",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5700X",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 3200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 3200 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350 640SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5300 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5300M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5500 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5500 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5500M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700 XT 50th Anniversary",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 640 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Switch GPU 16nm",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla PG500-216",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla PG503-216",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM2 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100S PCIe 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1030 DDR4",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1030 GK107",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 3 GB",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB GDDR5X",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB GP104",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB Rev. 2",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 GDDR5X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 Ti",
    "igp": "No",
    "vram": 11,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P102-100",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P102-101",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P104-101",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro GV100",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P3200 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P3200 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4200 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P500 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5200 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5200 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P620",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P620 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 4000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 6000",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 6000 Passive",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 8000",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 8000 Passive",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 540X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550X 640SP",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550X Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI50",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI60",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 555X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 560X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V340",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 16",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 20",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 8200",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX Vega M GL",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 540X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550X 640SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560DX",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580 2048SP",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580G",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580X Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 590",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 56 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega M GH",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega M GL",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla T4",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 DGXS 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 DGXS 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 FHHL",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 PCIe 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM2 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM3 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN RTX",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN V CEO Edition",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Zhongshan Subor Z+ GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1030",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 5 GB",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB 9Gbps",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 Ti",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 11Gbps",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Ti",
    "igp": "No",
    "vram": 11,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX110",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX130",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX150",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX150",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P104-100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P106-090",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P106-100",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M1200 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M2200 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M520 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M620 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P1000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P1000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P1000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2000",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P3000 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P400",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4000 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4000 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5000 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P600",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P600 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 520 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 520 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 530 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 530X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 535 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9171 MCM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9172 MXM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9173 PCIe",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9174 MXM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9175 PCIe",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI25",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 555",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 560",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 570",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 575",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 580",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Duo Polaris",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro SSG",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V320",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 56",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 64",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 2100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 3100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4130 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4150 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4170 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 7100 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 7130 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 8100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 9100",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 460 1024SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 540 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550 512SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550 640SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 896SP",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M420",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560D",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570 X2",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 56",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 64",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 64 Limited Edition",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 64 Liquid Cooling",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Vega Frontier Edition",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Vega Frontier Edition Watercooled",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Switch GPU 20nm",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P6",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 PCIe 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM2 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN V",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN Xp",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox One X GPU",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7100X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7150",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7150 x2",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9300 X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 920MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 930MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940MX",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 945M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 3 GB",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 3 GB GP104",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950 Low Power",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980MX",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M10-8Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M3-3020",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M40",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 4 Pro GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 4 Slim GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro GP100",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M2000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M3000 SE",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M500M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M5500 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M6000 24 GB",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5000",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P6000",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9260 MXM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9260 PCIe",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9550 MXM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI6",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI8",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 450",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 455",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 460",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Duo",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 5100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 7100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 430 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 435 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M430",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M430",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M430",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M435",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M445",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M465",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 430 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 435 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 450 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M440",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M445",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M460",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M465",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M465",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M465X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M470",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M470X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M485X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 455 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 460",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 460 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 470",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 470 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 470D",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 480",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 480 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580 OEM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M10",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P10",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 DGXS",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 PCIe 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 PCIe 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 SXM2",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P4",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P40",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN X Pascal",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox One S GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9170",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4130M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4150M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4190M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4300",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5130M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W6150M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W7170M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 810M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 820M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 845M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 845M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 910M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 920A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 920M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 930A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 930M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 945A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 945M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750 GM206",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 860M OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980 Ti",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN X",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-1Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-2Q",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-4A",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-8Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M6-8Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 810",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K1200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K620M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M1000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M2000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M3000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M4000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M4000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M5000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M5000M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M6000",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M600M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6465",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E8870",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E8950",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 310 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 310 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 330 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 340 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 340X OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A320",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A330",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A335",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M315",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M320",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M330",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M335",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 340 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 340 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350X OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 360 896SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 360E",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 370",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A360",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M260X",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M340",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M340",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M350",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M365X",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M370",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M380",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 270 1024SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 360 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 370",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 370 1024SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 370X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 380",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 380 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 380X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 390",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 390 X2",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 390X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 A375",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 FURY",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 FURY X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M270X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M280X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M280X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M360",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M365X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M370X Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M375",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M375X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M380",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M380 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M385",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M385X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M390 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M390X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M395 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M395X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M395X Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 Nano",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M4",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M40",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M40 24 GB",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M6",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M60",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro D300",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro D500",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro D700",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S10000 Passive 12GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S4000X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9050",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9100",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9150",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W2100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W6170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W7100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W8100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W9100",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 720A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 800A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 800A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 800M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 805A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 810A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 810M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 820A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 825M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 830A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 830M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 840A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 840M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 705 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710 PCIe x1",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 Rev. 2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 745 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750 Ti",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750 Ti OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 850A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 850M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 860M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 860M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 870M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 880M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 970",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 970M",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 970M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN BLACK",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN Z",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K120Q",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K220Q",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K500",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K520Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K540Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K560Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K100M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K200M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2200M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K420",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5200",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K620",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E8860",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8530M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 230",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A220",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A230",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A240",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A240",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A255",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230 Rebrand",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M240",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M240 Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M255",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250X",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250XE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 265X OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A260",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M260",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M270",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 280",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 285",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 290X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 295X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M265X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M270X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M275",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M275X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M290X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M290X Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M295X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M295X Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K8",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K80",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M3100",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M4100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M4150",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M5100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M6100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro R5000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5000 DVI",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 505 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 505 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 720M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 820M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 625 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630 Rev. 2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630 Rev. 2 PCIe x8",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640 Rev. 2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 735M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 745A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 745M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 745M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 750M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 750M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 755M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 755M Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 820M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 645 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650 Ti Boost",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650 Ti OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 675MX Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 OEM Rebrand",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 Ti OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 Ti OEM Rebrand",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 X2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 765M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 770",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 770M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 775M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 Rev. 2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 Ti",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780M Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K1",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K100",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K140Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K160Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K180Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K200",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K240Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K260Q",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K280Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K340",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K520",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 315",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 28nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 4 GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K1100M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2000D",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2100M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K3100M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4000",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4100M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000 SYNC",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5100M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K510M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K600",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K6000",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K6000 SDI",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6610",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770 Green Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870 1600SP Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7570 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M XT",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7720 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7790",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Mac Edition",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7990",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8350 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8450 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8470 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8490 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8550 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570 OEM Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8590M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8690M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8730 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8730A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8730M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8740 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8750A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8750M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8760 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8770 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8770M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8790M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8830M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8850M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8860 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8870 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8870M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8950 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8950M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8970 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8970M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8990 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 220 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 230 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 235 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 235X OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 240 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230 Rebrand",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 240",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 240",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 240 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250E",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 260",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 260X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 255 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 260 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 270",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 270X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 280X",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 280X2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 290",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 290X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Sky 500",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Sky 700",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Sky 900",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20m",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20s",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40c",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40d",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40m",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40s",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40st",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40t",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 E GPU",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox One GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 5120D",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 7120P",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 7120X",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M2000",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M4000",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M6000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S10000",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S10000 Passive",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9010",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V3900",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7760",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W600",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W7000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W8000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W9000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 605 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 615",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 620M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT Rev. 3",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 PCIe x1",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 625M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640 OEM Rebrand",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M LE",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M LE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 645 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 645M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 650M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 650M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 Rev. 3",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 SE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650 Ti",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 Ti",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 670",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 670M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 670MX",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 675M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 675MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680MX Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 690",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 310",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 510",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5200M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5200M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5400M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 40nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 410",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 7000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K1000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K3000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000 Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K500M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5470",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5490",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850 1440SP Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7330M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7350 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7350 OEM PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7350M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7370M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7430M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7450 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7450A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7450M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7490M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7510M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7530M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7590M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7630M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7650A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7650M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7650M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M XT Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7730M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7750M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7770 GHz Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7770M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7850",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7850M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7870 GHz Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7870 XT",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7870M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Boost",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Monica BIOS 1",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Monica BIOS 2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970 GHz Edition",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970 X2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K10",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20c",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20X",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20Xm",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Wii U GPU",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 3120A",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 5110P",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi SE10X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro 2270",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro 2270 PCIe x1",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M5950",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M8900",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V4900",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V5900",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7800P",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V7900",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V7900 SDI",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315 OEM",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 410M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 GS Rev. 2",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 435M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 440",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 440 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 PCI",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 PCIe x1",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520MX",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 525M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 530 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 540M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 545",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 545 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 Rev. 2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 v2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 v2 ES",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 485M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 550 Ti",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 555 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 OEM",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti 448",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti OEM",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 570M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 580 Rev. 2",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 580M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 590",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 300",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 4200M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation Vita GPU",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 1000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 2000D",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 2000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 3000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 400",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4000 Mac Edition",
    "igp": "No",
    "vram": 1.792,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5000",
    "igp": "No",
    "vram": 2.5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5000 SDI",
    "igp": "No",
    "vram": 2.5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 500M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5010M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 6000 SDI",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 7000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6460",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6760 MXM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6760 PCIe",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4450",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4580",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4720",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5530",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5630",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5690",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6230",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6250",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6290",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6350",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6350A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6390",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6430M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6470M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6490",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6490M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6490M Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6510",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6510",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6530",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6550A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6625M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6630M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6630M Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6650A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6650M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6670",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6730M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6750M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6750M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6790",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6830M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850 X2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6930",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6950M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6990",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6990M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6990M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2050",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2070",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2075",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2090",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2050",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2070",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2070-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2075",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2090",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S2050",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla X2070",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla X2090",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Aubrey Isle",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2460 Multi-View",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M3900",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M5800",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M7820",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro RG220",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro RG220A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V3800",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V4800",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V5800",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V5800 DVI",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7800",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8800",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V9800",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V9800P",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9370",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 305M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS Rev. 3",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 240M LE",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 320 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 320M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 325M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330 OEM",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 335M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 340 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 415 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 415M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 420 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 420M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 425M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 430",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 430 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 430 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 435M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 440 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 445M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 445M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 350M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 360M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 275 PhysX Edition",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 285M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 SE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 SE v2",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 465",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 480",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 480M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 570",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 570 Rev. 2",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 580",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4550",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5145",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5165",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 530v",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 540v",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5430",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5450",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5450",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 545v",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5470",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 550v",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 560v",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5650",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 565v",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5670 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5830",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5850 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5870",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 2100M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 3100M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5100M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 2000",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5000M",
    "igp": "No",
    "vram": 1.792,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 600",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 6000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 380M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 880M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3570",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4855",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5450",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5450 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5450 PCIe x1",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5550",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5670",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5670 640SP Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5770 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5770 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5830",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5870 Eyefinity 6",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5870 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6330M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6350M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6370M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6530M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6950",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 S GPU",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2450 Multi-View",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2450 Multi-View PCIe x1",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M5725",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M7740",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 205 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210 Rev. 2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GTX+",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G100 OEM",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G103M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G105M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G105M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G105M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G110M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G210 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G210 OEM Rev. 2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G210M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 130 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 130M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 140 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 230",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 230 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 230M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 240",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 240M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 320M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 150 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 150M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 160M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 240 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 250M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 260M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 OEM",
    "igp": "No",
    "vram": 1.792,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 275",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 280M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 285 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 295",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5725",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4330",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4350",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4530",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4570",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4650",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4670",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4670 Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4830",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4850 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4850 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4860",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4870 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1800",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1800M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2800M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 380",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 380 LP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3800",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 580",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 295",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 420",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E4690 MXM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E4690 MXM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E4690 PCIe",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3410",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3610",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4250",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4520",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4570 Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4670 AGP",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4730",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4750",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4770",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4810",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4860",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4870 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4890",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5870",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5970",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570M Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C1060",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla T10 Processor",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder HD 3650",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2260",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2260 PCIe x1",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2400 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2400 PCIe x1",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2260 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V3700",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V3750",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V5700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8700",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8750",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9270",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 X2 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GS",
    "igp": "No",
    "vram": 0.384,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GS Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9200M GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 GE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300M G",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300M GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GS Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT Rev. 3",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500M G",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GS OEM",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GSO",
    "igp": "No",
    "vram": 0.384,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GSO 512",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GT Green Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GT Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600M GS",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600M GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9650M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9650M GT",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9700M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9700M GTS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GT Rebrand",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GX2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GTS",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GTS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GTX",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800S",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120M Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 130 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 Core 216",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 Core 216 Rev. 2",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 Rev. 2",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 280",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 285",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3410",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3430",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3470",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3650",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3670",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3850",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3850 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3870 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 65nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro CX",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1700 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1700M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2700M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3600M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3600M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 370 LP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3700M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 370M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3800M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4700 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4800",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4800 Mac Edition",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5800",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 770M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 150M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 160M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 1000 Model II",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 1000 Model IV",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2100 D4",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2100 S4",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2200 D2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2200 S4",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro VX 200",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3470",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3550",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3650 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3690",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3730",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3750",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3830",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350 PCIe x1",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4550",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4650 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4670",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4670 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4710",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4730 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4830",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4850",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4850 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4870 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M1060",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S1070",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S1075",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 GPU 65nm",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5600",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7600",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V8600",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V8650",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2250",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2250 PCIe x1",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9170",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7950 GT AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8300 GS",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS PCI Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400M G",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400M GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8500 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GT Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GTS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GTS Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8700M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS 320",
    "igp": "No",
    "vram": 0.32,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS 512",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS Core 112",
    "igp": "No",
    "vram": 0.64,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 Ultra",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800M GTS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800M GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5250",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2400 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2400 XT Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2600 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2700",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1600 Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1900",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2300 HD",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2500",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 65nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation Portable GPU 65nm",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1600M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3500M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 360M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 370",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4600",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4600 SDI",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5600",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5600 Mac Edition",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 570",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 570M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 130M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 135M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 140M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 290",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 320M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E2400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2350 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 PRO PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 PRO AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 PRO",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 XT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550 AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1700 FSC",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1700 SE",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 PRO DUAL",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XTX Uber Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550 XTX",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C870",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla D870",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S870",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 GPU 80nm",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X1900",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2200 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7100 GS",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7200 GS",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GS Low Profile",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GT AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GT Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7350 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7500 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GS AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GS AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 LE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7650 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS 20Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS 24Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS+ 20Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS+ 24Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS+ AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GS AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GTO",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GX2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7950 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7950 GX2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS 640",
    "igp": "No",
    "vram": 0.64,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTX",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6250",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6400",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7300T",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7400T",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7450",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7600 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7900 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7900 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7900 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7950 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5200",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1350",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1350",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1450",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1700",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia APVe",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 90nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1500",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1500M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 350",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3500",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 350M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4500 SDI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4500 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 550",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5500",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5500 SDI",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 550M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 560",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 110M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 120M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 285",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 300M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 440",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 510M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 XT AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 XT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 GTO2",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 CrossFire Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 G5 Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 CrossFire Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 PRO AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300 SE HyperMemory",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 CrossFire Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Stream Processor",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Wii GPU",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 2006 AGP Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 2006 PCIe Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X1800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X600 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 VE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3350",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7200",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7300",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7350",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 LE AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 VE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 LE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GTX",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GTX 512",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6200 TE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6600 NPB 128M",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6600 TE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6800 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7800 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X700 XL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 90nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2500M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4400",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4400G",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4500",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go1400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 SD",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 50 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 55 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9550 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 CrossFire Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 XT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550 HyperMemory",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X740 XL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 CrossFire Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO2",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT Platinum AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari 8300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 GPU 90nm",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9200 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7100",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL X3-256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE AGP 512 MB",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 SE TurboCache",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 TurboCache",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 GT AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 GT Dual",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6610 XL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6700 XL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT DDL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 Ultra DDL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5500 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 EP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 VE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 4300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5750",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5950",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "M9125 PCIe x16",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL T2e",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V3100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V3200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7000",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9550",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9600 PRO Turbo",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9700",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9700 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X600 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 128 MB",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 256 MB",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation Portable GPU 90nm",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID LP PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID LP PCIe",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 330",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4000",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4000 SDI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 540",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 600 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go1000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go540",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 AGP",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 PCIe",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 400 NVS PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000 Mac Edition",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000 Mac Edition PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000 PRO Mac Edition",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9250",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9250 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 PRO AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 SE AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 VE AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XL AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT Platinum",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT Platinum AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT Platinum",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9000 PRO",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9700 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9800 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9600 T2-128",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9600 T2-64S",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9800 X2-256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9800 X2-256T",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5100",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 Rev. 2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 Ultra Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600 XT PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5800 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900 ZT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5950 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5100",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 32M",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 64M",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 NPB 32M",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 NPB 64M",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5250",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5350",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5650",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5900",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 4000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 4000 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 4000 Rev. 2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL T2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia DL256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia HR256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia Precision SDT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia Precision SGT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3000",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3000G",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 100 NVS",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 100 NVS PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 200 NVS",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 700 Go GL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9100",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9100 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 SE PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9550",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9550 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 TX",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO MAXX",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 XXL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V5 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V5 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V8 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V8 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V3",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V3 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 7500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 7500 VE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9500 Z1-128",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9700 X1-128",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9700 X1-256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9700 X1-256p",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 410 Go",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 420 Go",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 440 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 448 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 460 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 488 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Go 4200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 420",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 420 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440 Mac Edition",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-8x",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-8x",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 460",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200-8X",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200-8X",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millenium P650",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millenium P750",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450 x2 MMS",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450 x4 MMS",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9000",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon-P",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 128 MB",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 128 MB",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 256 MB",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 380 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 500 Go GL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 500 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 550 XGL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 580 XGL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 700 XGL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 750 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 900 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 980 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7500 Mac Edition",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9500 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9700 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9700 PRO X4",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 8500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 8500DV",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL4",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 8700",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 8800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go 100",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go 200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 200 LP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 200 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 400",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 400 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Ti",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce3",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce3 Ti200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce3 Ti500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G550",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G550 PCIe",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL 7800",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7500",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7500",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7500C",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 180nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro DCC",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 Go",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 Pro",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7500 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR VIVO",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR VIVO OEM",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR VIVO SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon LE",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon VE",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon VE PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Xbox GPU",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 7200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL2",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL3",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "GameCube GPU",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 GTS",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 GTS PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX DH Pro TV",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX DH Pro TV PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 PRO",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Ultra",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450 LP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 250nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 MXR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 MXR Low Profile",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7200 64 MB",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR MAXX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon SDR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon SDR PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Vanta LT",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4500 AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4500 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5500 AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5500 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128 PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128 PRO Ultra",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL1",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 256 DDR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 256 SDR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "i752",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Marvel G400-TV",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G200A",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G250",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G400",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G400 MAX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 PRO Ultra",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 Ultra",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Fury",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Fury MAXX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility 128",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility 128",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-CL",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M1",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M3",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M4",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-P",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage XL PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 M64",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 M64 Vanta",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 M64 Vanta-16",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 Ultra",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Velocity 100",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 1000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 2000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 2000 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 3000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 3000 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 3500 TV AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "i740",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "i740 8 MB",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Marvel G200",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G200",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G200 SD",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Mystique G200",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Productiva G100",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 GL",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 GL PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 PRO Ultra GL",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 VR AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 VR PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage XL PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva 128ZX",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo Banshee AGP 16 MB",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo Banshee PCI 16 MB",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo2 12 MB",
    "igp": "No",
    "vram": 0.012,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo2 8 MB",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage PRO AGP",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage PRO PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation GPU 350nm",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage LT PRO AGP",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage LT PRO AGP",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage PRO Turbo AGP",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage PRO Turbo PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva 128",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva 128 PCI",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage II",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage II+ DVD",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage IIC AGP",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage IIC PCI",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Video Xpression",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Video Xpression+",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo Graphics 4 MB",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Pro Turbo",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Xpression",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Xpression ISA",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NV1",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "STG-2000",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Video Xpression",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "WinBoost",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "WinCharger",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "WinTurbo",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation GPU 600nm",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro PCI",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro VLB",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra XLR VLB",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "8514-Ultra",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro ISA",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro ISA",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Vantage",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Wonder PCI",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Wonder VLB",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Wonder XL24",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Wonder",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Wonder+",
    "igp": "No",
    "vram": 0.000512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "EGA Wonder 480",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "EGA Wonder 800+",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "EGA Wonder 800",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Solution Plus",
    "igp": "No",
    "vram": 0.000064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Improved Performance",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Color Emulation Card",
    "igp": "No",
    "vram": 0.000032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Solution",
    "igp": "No",
    "vram": 0.000064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8700 Duo",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 8 GB GDDR5X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Ti 10 GB",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470 PhysX Edition",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 480 Core 512",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 490",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 Ti 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 1000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500 X4",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2950 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2950 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850 X3",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5950",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970 X2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V5300X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V7300X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V7350X2",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 285X",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 FURY X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6900 XTX",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega Nano",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 XT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Spectre 1000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Spectre 2000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Spectre 3000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Velocity 200",
    "igp": "No",
    "vram": 0.012,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari 8600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4800 AGP",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4200 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 30HX",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4200 PCI 16 MB",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4200 PCI 32 MB",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4800 AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5000 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 6000",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xe DG1",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xe DG1-SDV",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 5090",
    "igp": "No",
    "vram": 28,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 5080",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 5070",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 5060 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 5060",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 5050",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 1000 Mobile Ada Generation",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI325X",
    "igp": "No",
    "vram": 288,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A400",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 500 Mobile Ada Generation",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "B200 SXM 192 GB",
    "igp": "No",
    "vram": 96,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 5880 Ada Generation",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4080 SUPER",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 Ti SUPER AD102",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 Ti SUPER",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 SUPER",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 GDDR6",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 AD103",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A1000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 2000 Ada Generation",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7600 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060 Ti AD104",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060 AD106",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 A Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4050 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4050 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A380M",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI300X",
    "igp": "No",
    "vram": 192,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI300",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Data Center GPU Max Subsystem",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Data Center GPU Max 1550",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Data Center GPU Max 1350",
    "igp": "No",
    "vram": 96,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Data Center GPU Max 1100",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "ROG Ally GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "ROG Ally Extreme GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6550S",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6550M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6450M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Jetson Orin Nano 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H800 SXM5",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H800 PCIe 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 SXM5 96 GB",
    "igp": "No",
    "vram": 96,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 SXM5 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 PCIe 96 GB",
    "igp": "No",
    "vram": 96,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 PCIe 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 CNX",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W7900",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "L20",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4090 D",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "H100 SXM5 64 GB",
    "igp": "No",
    "vram": 64,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 5000 Mobile Ada Generation",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 5000 Max-Q Ada Generation",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 5000 Embedded Ada Generation",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 5000 Ada Generation",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7900M",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7900 GRE",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7800 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W7800",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W7700",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Jetson AGX Orin 64 GB",
    "igp": "No",
    "vram": 64,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Jetson AGX Orin 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4090 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4090 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A580",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 4500 Ada Generation",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 4000 Mobile Ada Generation",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 3500 Mobile Ada Generation",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 3500 Embedded Ada Generation",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7700 XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6750 GRE 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "L4",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4080 Mobile",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4080 Max-Q",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 Ti",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc Pro A60",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 4000 SFF Ada Generation",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 4000 Ada Generation",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6750 GRE 10 GB",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Steam Deck OLED GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 3000 Mobile Ada Generation",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 2000 Mobile Ada Generation",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 2000 Max-Q Ada Generation",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 2000 Embedded Ada Generation",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7700S",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7600S",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7600M XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7600M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7600",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600 LE",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W7600",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W7500",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Jetson Orin NX 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Jetson Orin NX 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Jetson Orin Nano 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060 Ti 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060 Ti 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4060",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc Pro A60M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A570M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A530M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A1000 Mobile 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Mobile Refresh 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Max-Q Refresh 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Data Center GPU Flex 140",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc Pro A50",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc Pro A40",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A380",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T550 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A500 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A500 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6500M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6500 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6400",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W6400",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1630",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc Pro A30M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A370M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A350M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A350",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A310",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A800 SXM4 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A800 PCIe 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A800 PCIe 40 GB",
    "igp": "No",
    "vram": 40,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arctic Sound-M",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5500",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX 6000 Ada Generation",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7900 XTX",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "L40S",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "L40G",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "L40 CNX",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "L40",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4090",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3090 Ti",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A10M",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 7900 XT",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti 20 GB",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6300M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon PRO W6300",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5500 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5500 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Embedded",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6950 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 5 GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 4080",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 TiM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti 8 GB GA102",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Ti GDDR6X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Ti GA103",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Data Center GPU Flex 170",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A770M",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A770",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A750",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6850M XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6750 XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A730M",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Steam Deck GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A1000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A1000 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800S",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700S",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6650M XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6650M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6650 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600S",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 8 GB GA104",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 OEM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Mobile Refresh 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Max-Q Refresh 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 8 GB GA107",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arc A550M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI250X",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI250",
    "igp": "No",
    "vram": 128,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 PCIe 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI210",
    "igp": "No",
    "vram": 64,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 170HX",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arctic Sound 2T",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Arctic Sound 1T",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "PG506-242",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "PG506-232",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A30 PCIe",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5000",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Ti",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A10G",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A10 PCIe",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500",
    "igp": "No",
    "vram": 20,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 90HX",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 50HX",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A5000 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Embedded",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4000 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4000",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6900X",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6800X Duo",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6800X",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6800",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V620",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 70HX",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "CMP 40HX",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4500 Mobile",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A3000 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800M",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700 XT",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 GA104",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6700M",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T600 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T600",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T1000 8 GB",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T1000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A4 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A2000 Embedded",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A1000 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6600",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6600M",
    "igp": "Yes",
    "vram": 8,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W6600",
    "igp": "Yes",
    "vram": 8,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1200 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Ti Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Ti Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3050 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A2",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A16 PCIe",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T400 4 GB",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T400",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A500 Embedded",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2050 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1010 DDR4",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1010",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID A100B",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID A100A",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 SXM4 80 GB",
    "igp": "No",
    "vram": 80,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 SXM4 40 GB",
    "igp": "No",
    "vram": 40,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A100 PCIe",
    "igp": "No",
    "vram": 40,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro VII",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI100",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V520",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5600M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "RTX A6000",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 6000 Mobile",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-8",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-4",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID RTX T10-16",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3090",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "A40 PCIe",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox Series X GPU",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3080",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6900 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6800",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 590 GME",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5700 XT",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5700",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000 Mobile Refresh",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 5 GPU",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3060 Ti",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 SUPER Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 SUPER Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 SUPER Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 SUPER Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Mobile Refresh",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Max-Q Refresh",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "AeroBox GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5600M",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5600 XT",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5600 OEM",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 TU104",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox Series S GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5500M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5500",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5500 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5300",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1000 Mobile GDDR6",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Iris Xe MAX Graphics",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "H3C XG310",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 TU116",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 TU106",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Ti Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Ti Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Ti Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 GDDR6",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Atari VCS 800 GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Atari VCS 400 GPU",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5300",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "T500 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX450 30.5W 8Gbps",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX450 30.5W 10Gbps",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX450 25W",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX330",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100S PCIe 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM2 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla PG503-216",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla PG500-216",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon VII",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega II Duo",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega II",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 64X",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 48",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700 XT 50th Anniversary",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700 XT",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5700",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5700X",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5700",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 580X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 575X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 570X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9560 PCIe",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9390 PCIe",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 4000 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 4000 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 SUPER",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 SUPER",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 SUPER",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 3000 Mobile Refresh",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 3000 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 3000 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Mobile Refresh",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060 Max-Q Refresh",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2060",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 Ti Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 Ti Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 Ti",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660 SUPER",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1660",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2200",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5500M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5500 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5500 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5300 XT",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350 640SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 3200 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 3200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro W5300M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5500M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 5300M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 630 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T2000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T2000 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1000 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro T1000 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2000 Mobile",
    "igp": "No",
    "vram": 3.75,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P106M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 SUPER",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Mobile",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650 Max-Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1650",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 5300M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Mobile 3 GB",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Switch GPU 16nm",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 640 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 625 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 620 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 610 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 540X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 540 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P520 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX250",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX250",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX230",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX150 GP107",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN V CEO Edition",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM3 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM2 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 PCIe 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 FHHL",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 DGXS 32 GB",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 DGXS 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI60",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI50",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro GV100",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 56 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 8200",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V340",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega M GL",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega M GH",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX Vega M GL",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 20",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 16",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN RTX",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 8000 Passive",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 8000",
    "igp": "No",
    "vram": 48,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 6000 Passive",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 6000",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080 Ti",
    "igp": "No",
    "vram": 11,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P102-101",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P102-100",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Zhongshan Subor Z+ GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla T4",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 590",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580X Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580G",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580 2048SP",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 5000",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro RTX 4000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5200 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5200 Max-Q",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4200 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P104-101",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2080",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 2070",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 GDDR5X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P3200 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P3200 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB Rev. 2",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB GP104",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB GDDR5X",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560X",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560DX",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550X 640SP",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550X",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 540X Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 560X",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 555X",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P620 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P620",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti Max-Q",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Max-Q",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1030 GK107",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 3 GB",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550X Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550X Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550X 640SP",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 540X Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P500 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1030 DDR4",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 SXM2 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla V100 PCIe 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN V",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Vega Frontier Edition Watercooled",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Vega Frontier Edition",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 64 Liquid Cooling",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 64 Limited Edition",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 64",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega 56",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 9100",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 8100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 64",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Vega 56",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V320",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro SSG",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI25",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox One X GPU",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN Xp",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Ti",
    "igp": "No",
    "vram": 11,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P6",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570 X2",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 570",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 7130 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 7100 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Duo Polaris",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 580",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 575",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 570",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5000 Mobile",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4000 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4000 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P4000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P104-100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 11Gbps",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 Ti",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 Max-Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P3000 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P106-100",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "P106-090",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 Max-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB 9Gbps",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2000",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 5 GB",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560D",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560 896SP",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 560",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550 640SP",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550 512SP",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 550",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 540 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 460 1024SP",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4170 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4150 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4130 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 3100",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 560",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 555",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9175 PCIe",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9174 MXM",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9171 MCM",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P600 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P600",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P2000 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P1000 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P1000",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P1000",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M620 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M2200 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M1200 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Switch GPU 20nm",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 2100",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9173 PCIe",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9172 MXM",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 550",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 535 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 530X Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 530 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 520 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon 520 Mobile",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P400",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M520 Mobile",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX150",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX150",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX130",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce MX110",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 1030",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 SXM2",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 PCIe 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 DGXS",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro Duo",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI8",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro GP100",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9300 X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P100 PCIe 12 GB",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "TITAN X Pascal",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P40",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P10",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P6000",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M6000 24 GB",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox One S GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla P4",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 580 OEM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 480 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 480",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 470D",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 470 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 470",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M485X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 7100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 5100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Instinct MI6",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9550 MXM",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro P5000",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M5500 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M3000 SE",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 4 Slim GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 4 Pro GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980MX",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1070",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7150 x2",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7150",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7100X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 Mobile",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 3 GB GP104",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 3 GB",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M10",
    "igp": "Yes",
    "vram": 8,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 460 Mobile",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 460",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 455 OEM",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M470X",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M470",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M465X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M465",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 450 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 430 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro WX 4100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 460",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 455",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro 450",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9260 PCIe",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E9260 MXM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M2000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M40",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M3-3020",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M10-8Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950 Low Power",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050 Ti",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1050",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M465",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M460",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M445",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M440",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 435 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M465",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M445",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M435",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M430",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M430",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M430",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M420",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 435 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 430 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M500M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 945M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940MX",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 930MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 920MX",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 Nano",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 FURY X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 FURY",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 390X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 390 X2",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 390",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9170",
    "igp": "No",
    "vram": 32,
    "vram_category": "Enthusiast Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M40 24 GB",
    "igp": "No",
    "vram": 24,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M40",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M6000",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN X",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980 Ti",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M60",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M6",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M395X Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M395X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M395 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M390X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M390 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 380X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 380 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 380",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 370X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 370 1024SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 370",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 270 1024SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 370",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E8950",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M5000M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M5000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M4000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M4000",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M3000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M6-8Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-8Q",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-4A",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-2Q",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID M60-1Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980 Mobile",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W7170M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M4",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M385X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M385",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M380 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M380",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M375X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M375",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M370X Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M365X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M360",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M280X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M280X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M270X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 A375",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 360 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M380",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M370",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M365X",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M260X",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A360",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 360E",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 360 896SP",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350X OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 350 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 340 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 340 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E8870",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M600M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M2000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro M1000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K1200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 965M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 960",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 950",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 860M OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750 GM206",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 945M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 820M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W6150M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5130M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4300",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4190M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4150M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4130M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M360",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M350",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M350",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M340",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M340",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A360",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M335",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M330",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M320",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M315",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A335",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A330",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A320",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 340X OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 340 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 330 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 310 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 310 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6465",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K620M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 810",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 945A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 940A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 930M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 930A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 920M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 920A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 910M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 845M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 845M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 810M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 295X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 290X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W9100",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W8100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9150",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9100",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K80",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 280",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN Z",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN BLACK",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9050",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S10000 Passive 12GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro D700",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro D500",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K8",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M295X Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M295X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M290X Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M290X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 285",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 265X OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5200",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K560Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K540Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K520Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K500",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K220Q",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 980",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 970",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 880M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750 Ti OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W7100",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro D300",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 970M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 970M",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 870M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 Rev. 2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M275X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M275",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M270X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 M265X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M270",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 A260",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250XE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250X",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M255",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A255",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A240",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E8860",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K620",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K420",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2200M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2200",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K120Q",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 860M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 860M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 850M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 850A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750 Ti",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 745 OEM",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W6170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5100",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4170M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W2100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S4000X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M265",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 M260",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M240 Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M240",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230 Rebrand",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A240",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A230",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 A220",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 230",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8550M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8530M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K200M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K100M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730A",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720A",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710 PCIe x1",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 705 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 840M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 840A",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 830M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 830A",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 825M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 820A",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 810M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 810A",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 805A",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 800M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 800A",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 800A",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 720A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 7120X",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 7120P",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 5120D",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 290X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 290",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40t",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40st",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40s",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40m",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40d",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K40c",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Sky 900",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Sky 700",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 280X2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 280X",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8990 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8970 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8950 OEM",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7990",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Mac Edition",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K6000 SDI",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K6000",
    "igp": "No",
    "vram": 12,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX TITAN",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 Ti",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 Rev. 2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20s",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20m",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Xbox One GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Sky 500",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 270X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 270",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8970M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8870 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8860 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7720 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870 1600SP Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5100M",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000 SYNC",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4100M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K3100M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Playstation 4 GPU",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K520",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K280Q",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K260Q",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K240Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K200",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780M Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 775M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 770",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 X2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 Ti OEM Rebrand",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 Ti OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 OEM Rebrand",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680 Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 675MX Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5000 DVI",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro R5000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4000",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 770M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650 Ti Boost",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 E GPU",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 260 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 255 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 260X",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 260",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250E",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 240 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 240",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R7 240",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8950M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8870M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8850M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8830M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8790M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8770M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8770 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8760 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8750M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8740 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8730M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8730A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8730 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570 OEM Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8550 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7790",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M XT",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7570 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7510 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770 Green Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6610",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K600",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2100M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2000D",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K1100M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 28nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K340",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K180Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K160Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K140Q",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K100",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GRID K1",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 765M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 760M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660M Mac Edition",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650 Ti OEM",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 645 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 755M Mac Edition",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 755M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 750M Mac Edition",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 750M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 745M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 745M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 745A",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 730M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 505 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M6100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M5100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M4150",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M4100",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M3100",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 M230 Rebrand",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 240 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 235X OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 235 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 230 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R5 220 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8750A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8690M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8590M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8570A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8490 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8470 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8450 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 8350 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K510M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 315",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 820M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 740A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 735M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 720M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 710M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640 Rev. 2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630 Rev. 2 PCIe x8",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630 Rev. 2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 625 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 820M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 720M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 710A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 705A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 505 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi SE10X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 5110P",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xeon Phi 3120A",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20Xm",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20X",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970 X2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970 GHz Edition",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Monica BIOS 2",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Monica BIOS 1",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950 Boost",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 7000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W9000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9010",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S9000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S10000 Passive",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S10000",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K20c",
    "igp": "No",
    "vram": 5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla K10",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7950M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7870 XT",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7870 GHz Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7850",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850 1440SP Edition",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000M",
    "igp": "Yes",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000 Mac Edition",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K5000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K4000M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K3000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 690",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680MX Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 680",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 675MX",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 675M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 670",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W8000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W7000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W5000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W4000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro S7000",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 670MX",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 670M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 Ti",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 SE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 645 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640 OEM Rebrand",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7870M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7850M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7770M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7770 GHz Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7750M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7730M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M XT Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7670 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7650M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7650M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7650A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7630M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7550M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K2000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K1000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 40nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5400M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 510",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 660M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650 Ti",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 650",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 Rev. 3",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 650M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 650M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 645M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M LE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M LE",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 640",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 615",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro W600",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7760",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V3900",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M6000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M4000",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Wii U GPU",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7590M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7550M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7530M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7510M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7490M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7470 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7450M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7450A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7450 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7430M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7370M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7350M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7350 OEM PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7350 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7330M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5490",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5470",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro K500M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 410",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5200M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5200M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 310",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 635M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 630M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 625M",
    "igp": "Yes",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 620",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 PCIe x1",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 PCI",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 610",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT Rev. 3",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 620M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 605 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M2000",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla X2090",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla X2070",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S2050",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2090",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2075",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2070-Q",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2070",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M2050",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2090",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2075",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2070",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C2050",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7970",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 7000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 6000 SDI",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 590",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 580 Rev. 2",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5000 SDI",
    "igp": "No",
    "vram": 2.5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5000",
    "igp": "No",
    "vram": 2.5,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti 448",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 OEM",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6990M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6990",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970M Mac Edition",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6950M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6930",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850 X2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6790",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5010M",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4000 Mac Edition",
    "igp": "No",
    "vram": 1.792,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 3000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 580M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti OEM",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560 Ti",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 485M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 v2 ES",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V7900 SDI",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V7900",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7800P",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V5900",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M8900",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 570M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 560M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 555 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 550 Ti",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 v2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 545",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 7690M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6990M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970M Rebrand",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6830M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6750M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6750M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6750",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6730M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6670A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6670",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6650M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6650A",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6630M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6625M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6610M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4450",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6550A",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6530",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6510",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6510",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6490",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6390",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5690",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5630",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4720",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4580",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6760 PCIe",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6760 MXM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 500M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 2000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 2000D",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 1000M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 Rev. 2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 555M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 550M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 545 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 540M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 530 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 525M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 440 Mac Edition",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 440",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 435M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro V4900",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M5950",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6630M Mac Edition",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6490M Mac Edition",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6490M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6470M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450A",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6450",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6430M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6350A",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6350",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6290",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6250",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6230",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5530",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon E6460",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 400",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation Vita GPU",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 4200M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 300",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520MX",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 PCIe x1",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520 PCI",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 520",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 GS Rev. 2",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 610",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 510 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 410M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315 OEM",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro 2270 PCIe x1",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro 2270",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 275 PhysX Edition",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 6000",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 580",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 480",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 570 Rev. 2",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 570",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6950",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6870",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5870 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5870 Eyefinity 6",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5830",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4855",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 5000M",
    "igp": "No",
    "vram": 1.792,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 4000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 480M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 465",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 SE",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 285M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9370",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9350",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V9800P",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V9800",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8800",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7800",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro RG220A",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro RG220",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2460 Multi-View",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Aubrey Isle",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460M",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460 SE v2",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 460",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 445M",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 440 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 S GPU",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6550M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6550M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6530M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5770 X2",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5770 Mac Edition",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5670 640SP Edition",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5670",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5550",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 880M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 600",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro 2000",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 5100M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5870",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5850 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5830",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5770",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5750",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5730",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5670 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 565v",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5650",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 560v",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 550v",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5165",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 450",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 360M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 350M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 445M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 435M",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 430 OEM",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 425M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 420M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 420 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 415M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 415 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 340 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 335M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330M Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330 OEM",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 330 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 325M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 320M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 320 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 240M LE",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT Mac Edition",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405 OEM",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V5800 DVI",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V5800",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V4800",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M7820",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M5800",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6370M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6350M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6330M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5450 PCIe x1",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5450 PCI",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5450",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3570",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 380M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 3100M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 2100M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5470",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 545v",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5450",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5450",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5430",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 540v",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 530v",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 5145",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4550",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 430 PCI",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 430",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS Rev. 3",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 405 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 315 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 305M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V3800",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FirePro M3900",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla T10 Processor",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C1060",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 285 Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 295",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 275",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 OEM",
    "igp": "No",
    "vram": 1.792,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5970",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5870",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4890",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4870 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4860",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3800",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2800M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4870 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4850 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4850 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4850",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 280M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 240 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 160M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 150M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 150 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 230",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 140 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GTX+",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1800",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 230 OEM",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 130 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6570M Mac Edition",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5770",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5750",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4810",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4770",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4750",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4730",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4670 AGP",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4570 Rebrand",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3610",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E4690 PCIe",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E4690 MXM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E4690 MXM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 580",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 380",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1800M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4860",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4830",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4670 Mac Edition",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4670",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4650",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5725",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 260M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTS 250M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 320M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 240M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 240",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 230M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 220",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 130M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120M",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120 OEM",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120 Mac Edition",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V7750",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M7740",
    "igp": "Yes",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro M5725",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4520",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4250",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3410",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 420",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 295",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 380 LP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4570",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4530",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4350",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 4330",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G210M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G210 OEM Rev. 2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G210 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G110M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G105M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G105M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G105M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G103M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce G100 OEM",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 310 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210 Rev. 2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 210",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 205 OEM",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2450 Multi-View PCIe x1",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2450 Multi-View",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S1075",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S1070",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla M1060",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2200 S4",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2200 D2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5800",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 285",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 280",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 Rev. 2",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 Core 216 Rev. 2",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260 Core 216",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 260",
    "igp": "No",
    "vram": 0.896,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2100 S4",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 1000 Model IV",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4800 Mac Edition",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4800",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro CX",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4870 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4850 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4850",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4830",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4730 OEM",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro VX 200",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 2100 D4",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro Plex 1000 Model II",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4700 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3800M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3700M",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3600M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3600M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2700M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3870 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3870",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3850 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3850",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800S",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GTX",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GTS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GTS",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GX2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GT Rebrand",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9800 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9700M GTS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GT Mac Edition",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GT Green Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GSO 512",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GS Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9270",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9250",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8750",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8700",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 130 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GSO",
    "igp": "No",
    "vram": 0.384,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600 GS OEM",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GS",
    "igp": "No",
    "vram": 0.384,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 GPU 65nm",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4710",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4670 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4670",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4650 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3830",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3750",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3730",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3690",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3650 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 770M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1700M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1700 Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 65nm",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3670",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3650",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GT 120M Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9700M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9650M GT",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9650M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600M GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9600M GS",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500M G",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT Rev. 3",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GS Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9500 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V5700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V3750",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2400 PCIe x1",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2400 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder HD 3650",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4570",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4550",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350 PCIe x1",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 4350",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3550",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3470",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450 PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 160M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 150M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 370M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 370 LP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3470",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3430",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 3410",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9400 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300M GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300M G",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9300 GE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 9200M GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 X2 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V3700",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro 2260 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2260 PCIe x1",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2260",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 65nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 XT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation Portable GPU 65nm",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V8650",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V8600",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla S870",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla D870",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Tesla C870",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5600 Mac Edition",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5600",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4600 SDI",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4600",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 Ultra",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS Core 112",
    "igp": "No",
    "vram": 0.64,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS 320",
    "igp": "No",
    "vram": 0.32,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XTX Uber Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 PRO DUAL",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 PRO",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 GT",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3500M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1700",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1900",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800M GTX",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800M GTS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS 512",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7950 GT AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "FireStream 9170",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7700",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7600",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 GPU 80nm",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1700 SE",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1700 FSC",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 GTO",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 GT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 PRO AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050 AGP",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT X2",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 PRO AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2600 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 350",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 320M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 570M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 570",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1600M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2500",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1600 Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2700",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2600 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5250",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8700M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GT Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600M GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GTS Mac Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GTS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GT Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8600 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8500 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400M GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2250 PCIe x1",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2250",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5600",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550 XTX",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550 AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1550",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3450",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 PRO PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2400 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2350 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon E2400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 290",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 140M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 135M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 130M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 370",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 360M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2400 XT Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2400 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon HD 2400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400M GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400M G",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS PCI Rev. 2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS PCI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8300 GS",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X2300 HD",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTX",
    "igp": "No",
    "vram": 0.768,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 8800 GTS 640",
    "igp": "No",
    "vram": 0.64,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Stream Processor",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 CrossFire Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 PRO AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1950 CrossFire Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 G5 Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1900 CrossFire Edition",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 GTO2",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5500 SDI",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 5500",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4500 X2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4500 SDI",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3500",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1500M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1500",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7950 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7900 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7900 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7900 GS",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7450",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7950 GX2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7950 GT",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GX2",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GTO",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GS AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7900 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS+ AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS+ 24Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS+ 20Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS 24Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GS 20Pipes AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X1900",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 XT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 XT AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1650 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 510M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 440",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 300M",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 560",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 550M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 550",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 350M",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Playstation 3 GPU 90nm",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia APVe",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1700",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1600",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1450",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1400",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1300",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5200",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7700",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7600 GT",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7600",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7650 GS",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 LE",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GT Mac Edition",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GT",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GS AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GS AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7600 GS",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GT Mac Edition",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GT AGP",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Wii GPU",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300 SE HyperMemory",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1050",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 285",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 120M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 110M",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1350",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X1350",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7400T",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7300T",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6400",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6250",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7500 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7350 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GS Low Profile",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7300 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7200 GS",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7100 GS",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2200 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireMV 2200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 90nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT Platinum AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO2",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 CrossFire Edition",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 XT",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 XL",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1800 CrossFire Edition",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go1400",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4500",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4400G",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4400",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3450",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2500M",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X800 XT",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 7800 GTX",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6800 Ultra",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GTX 512",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GTX",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 7800 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 LE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GS",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7350",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7300",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7200",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 VE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 SE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X1800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Xbox 360 GPU 90nm",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X740 XL",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550 HyperMemory",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X550",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 XT",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 PRO",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PRO AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PRO",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PCI",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 AGP",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9550 XT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X700 XL",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X700",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V5000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6600 TE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6600 NPB 128M",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 XE",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 VE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 LE AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X600 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 2006 PCIe Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 2006 AGP Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari 8300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1300 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 55 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 50 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 SD",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6200 TE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3350",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation Portable GPU 90nm",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT Platinum",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X850 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT Platinum AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT Platinum",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XL AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 XL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 VE AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 SE AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 PRO AGP",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 XT Mac Edition",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4000 SDI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 4000",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3400",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1400",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 256 MB",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 128 MB",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5950",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce Go 6800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 Ultra DDL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GTO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT DDL",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800 GT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6800",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL X3-256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V7100",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 PRO AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000 PRO Mac Edition",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 400 NVS PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 PCIe",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 AGP",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go540",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go1000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 600 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 540",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID LP PCIe",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X600 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon X600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9700",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9600 PRO Turbo",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V3200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL V3100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL T2e",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5750",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5300",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 VE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5500 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6700 XL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6610 XL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 GT Dual",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 GT AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 GT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6600",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE AGP 512 MB",
    "igp": "Yes",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V5000",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3200",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder X800 GT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9600 XT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9200",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X600 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X300 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9250 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9250",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000 Mac Edition PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000 Mac Edition",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 330",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "QID LP PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9700 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9550",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "M9125 PCIe x16",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 4300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 EP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 TurboCache",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 LE PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL V3100",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9200 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7000",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 SE TurboCache",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V8 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V5 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V5 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 XXL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO MAXX",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3000G",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 3000",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9200",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce PCX 5900",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5950 Ultra",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900 ZT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900 Ultra",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5900",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9800 X2-256T",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9800 X2-256",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9800 PRO",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9700 PRO",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8 Ultra",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8 Ultra",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V8",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5 Ultra",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5 Ultra",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V5",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V3 XT",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari V3",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari Duo V8 Ultra",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9800 SE",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 TX",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9550",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9100 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9100",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 700 Go GL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 200 NVS",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 100 NVS PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 100 NVS",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX Go700",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 2000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro FX 1000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL T2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5650",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5350",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5300",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5250",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 NPB 64M",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 64M",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5800 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5700 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600 XT PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 Ultra Mac Edition",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 Ultra",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9600 T2-64S",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9600 T2-128",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9800 SE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9600 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9600",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9000 PRO",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9600 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9550 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 SE PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9200 SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro NVS 280 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia Precision SGT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia Precision SDT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia PCI",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia HR256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia DL256",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 4000 Rev. 2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 4000 PCI",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 4000",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 NPB 32M",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5200 32M",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX Go5100",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 Rev. 2",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5200 LE",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce FX 5100",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 6200 AGP",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9700 PRO X4",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9700 PRO",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9700",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 256 MB",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 128 MB",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Parhelia 128 MB",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9700 X1-256p",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9700 X1-256",
    "igp": "Yes",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9700 X1-128",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 9500 Z1-128",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9500 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000 PRO",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7500 Mac Edition",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 980 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 900 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 750 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 700 XGL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 580 XGL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 550 XGL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 500 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 500 Go GL",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro4 380 XGL",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL 9000",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millenium P750",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millenium P650",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4600",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4400",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200-8X",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200-8X",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 460",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-SE",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-SE",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-8x",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440 Mac Edition",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 420",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 488 Go",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 460 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 448 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 440 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 7500 VE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 7500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 9500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon-P",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9000",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 9000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450 x4 MMS",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450 x2 MMS",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Ti 4200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 420 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 Go 4200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 420 Go",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 410 Go",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce4 MX 440-8x",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 180nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL4",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Xbox GPU",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon LE",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR VIVO SE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR VIVO OEM",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR VIVO",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7500 LE",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 Pro",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro DCC",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility FireGL 7800",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce3 Ti500",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce3 Ti200",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce3",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Ti",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 400",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 8800",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FireGL 8700",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 8500DV",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 8500",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon VE PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon VE",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7000",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 Go",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7500C",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7500",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Mobility Radeon 7500",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G550 PCIe",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G550",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 400 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 200 PCI",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 200 LP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX 200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go 200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go 100",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation 2 GPU 250nm",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL3",
    "igp": "Yes",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL2",
    "igp": "Yes",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5500 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5500 AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4500 PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4500 AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon SDR PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon SDR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR MAXX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon DDR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7200 64 MB",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 7200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 MXR Low Profile",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro2 MXR",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Ultra",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 PRO",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX DH Pro TV PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX DH Pro TV",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 GTS PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 GTS",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder Radeon 7200",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Vanta LT",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450 LP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G450",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 MX PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce2 Go",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "GameCube GPU",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Fire GL1",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 3500 TV AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 3000 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 3000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 2000 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 2000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo3 1000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Velocity 100",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 Ultra",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Fury MAXX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Fury",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 PRO",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Quadro",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G400 MAX",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G400",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Marvel G400-TV",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 256 SDR",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce 256 DDR",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128 PRO Ultra",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128 PRO",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128 PCI",
    "igp": "Yes",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "All-In-Wonder 128",
    "igp": "Yes",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 M64 Vanta-16",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 M64 Vanta",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT2 M64",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-P",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M4",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M3",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M1",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-M",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility-CL",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility 128",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage Mobility 128",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 Ultra",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 PRO Ultra",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G250",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G200A",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "i752",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage XL PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo2 8 MB",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo2 12 MB",
    "igp": "No",
    "vram": 0.012,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo Banshee PCI 16 MB",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo Banshee AGP 16 MB",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva TNT",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva 128ZX",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 GL PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 GL",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage XL PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 VR PCI",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 VR AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage 128 PRO Ultra GL",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Productiva G100",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Mystique G200",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G200 SD",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Millennium G200",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Matrox",
    "product_name": "Marvel G200",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "i740 8 MB",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "i740",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva 128 PCI",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "Riva 128",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage PRO Turbo PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage PRO Turbo AGP",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage LT PRO AGP",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Rage LT PRO AGP",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage PRO PCI",
    "igp": "No",
    "vram": 0.008,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage PRO AGP",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation GPU 350nm",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo Graphics 4 MB",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Video Xpression+",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Video Xpression",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage IIC PCI",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage IIC AGP",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage II+ DVD",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage II",
    "igp": "No",
    "vram": 0.004,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "3D Rage",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "WinTurbo",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "WinCharger",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "WinBoost",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Video Xpression",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "STG-2000",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NV1",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Xpression ISA",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Xpression",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Pro Turbo",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Sony",
    "product_name": "Playstation GPU 600nm",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra XLR VLB",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro VLB",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro PCI",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Wonder VLB",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Wonder PCI",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro ISA",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra Pro ISA",
    "igp": "No",
    "vram": 0.002,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Wonder XL24",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Vantage",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Ultra",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "8514-Ultra",
    "igp": "No",
    "vram": 0.001,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Wonder+",
    "igp": "No",
    "vram": 0.000512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Wonder",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "EGA Wonder 800+",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "EGA Wonder 480",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "VGA Improved Performance",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Solution Plus",
    "igp": "No",
    "vram": 0.000064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "EGA Wonder 800",
    "igp": "No",
    "vram": 0.000256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Graphics Solution",
    "igp": "No",
    "vram": 0.000064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Color Emulation Card",
    "igp": "No",
    "vram": 0.000032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 FURY X2",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX Vega Nano",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2900 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon R9 285X",
    "igp": "No",
    "vram": 3,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 780 Ti 6 GB",
    "igp": "No",
    "vram": 6,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 490",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 480 Core 512",
    "igp": "No",
    "vram": 1.536,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470 PhysX Edition",
    "igp": "No",
    "vram": 1.28,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1080 Ti 10 GB",
    "igp": "No",
    "vram": 10,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon RX 6900 XTX",
    "igp": "Yes",
    "vram": 16,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V7350X2",
    "igp": "Yes",
    "vram": 16,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V7300X",
    "igp": "Yes",
    "vram": 8,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon HD 6970 X2",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 5950",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3870 AGP",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 3850 X3",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2950 XTX",
    "igp": "No",
    "vram": 0.512,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon HD 2950 PRO",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce RTX 3070 Ti 16 GB",
    "igp": "No",
    "vram": 16,
    "vram_category": "High Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 470 X2",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "GeForce GTX 1060 8 GB GDDR5X",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "FirePro V8700 Duo",
    "igp": "No",
    "vram": 1.024,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xe DG1-SDV",
    "igp": "No",
    "vram": 8,
    "vram_category": "Mid Level Card"
  },
  {
    "manufacturer": "Intel",
    "product_name": "Xe DG1",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 6000",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5000 PCI",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo5 5000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4800 AGP",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4200 PCI 32 MB",
    "igp": "No",
    "vram": 0.032,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4200 PCI 16 MB",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4200 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4-2 4000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4800 AGP",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Voodoo4 4000 AGP",
    "igp": "No",
    "vram": 0.016,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "XGI",
    "product_name": "Volari 8600 XT",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Velocity 200",
    "igp": "No",
    "vram": 0.012,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Spectre 3000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Spectre 2000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "3dfx",
    "product_name": "Spectre 1000",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon X1600 XT Dual",
    "igp": "No",
    "vram": 0.256,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "AMD",
    "product_name": "Radeon Pro V5300X",
    "igp": "No",
    "vram": 4,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500 XT",
    "igp": "No",
    "vram": 0.128,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "NVIDIA",
    "product_name": "NVS 1000",
    "igp": "No",
    "vram": 2,
    "vram_category": "Entry Level Card"
  },
  {
    "manufacturer": "ATI",
    "product_name": "Radeon 8500 X4",
    "igp": "No",
    "vram": 0.064,
    "vram_category": "Entry Level Card"
  }
]
*/