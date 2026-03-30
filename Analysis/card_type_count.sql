WITH card_type AS
(
    SELECT
        gpu_id,
        manufacturer,
        product_name,
        igp AS integrated_graphics,
        mem_size AS vram,
     CASE                                       -- categorizes the GPUs into different tiers for ease of understanding and choosing.
         WHEN mem_size < 8 OR igp = 'Yes'  THEN 'Entry Level Card' 
         WHEN mem_size >= 8 AND mem_size <=12 THEN 'Mid Level Card'
         WHEN mem_size > 12 AND mem_size <=24 THEN 'High Level Card'
         WHEN mem_size > 24 THEN 'Enthusiast Card'
    END AS vram_category
FROM
    gpu_specs
WHERE  
    mem_size IS NOT NULL
)
SELECT
    manufacturer,
    vram_category,
    COUNT(gpu_id) AS no_of_cards --Counts the number of cards from each of the market giants to know which company excels in which particular tier of GPUs
FROM
    card_type
WHERE 
    manufacturer IN ('NVIDIA', 'AMD', 'Intel') --Can include other manufacturers but would not recommend due to their obsolence.For more details,read below.
GROUP BY
    manufacturer,
    vram_category
ORDER BY
    manufacturer ASC,
    no_of_cards DESC;


/*Why only NVIDIA,AMD and Intel were considered where as manufacturers such as ATI, 3dfx, XGI etc. were omitted?
  -THE MODERN GIANTS
   These three big companies currently represent the entirety of the modern PC graphics market, one can even say that they are the current PC market and well they won't be wrong.
   Together,NVIDIA,AMD and Intel control 100% of the modern x86 PC consumer graphics market.There is no fourth competitor.The sheer amount of GPUs produce in a single fiscal year 
   trumps over any company could produce in years.They single handedly populate the 'Mid-tier','Entry-level','High-level' as well as the 'Enthusiast' categories.Their combined 
   market capitalization sits comfortably at over $4.5 Trillion.Between NVIDIA's data centers ,AMD's consoles, and Intels's massive CPU install base,these three companies currently 
   rule the global architectural standards for hardware.

   <i> NVIDIA: The current leader of the GPU market scenario controlling an overwhelming  92% to 94% of the global discrete GPU market.When it comes to dedicated add-in boards for
               PCs, they practically own the space due to them pushing out newer technologies such as the NVIDIA DLSS, Ray Tracing as well as Path tarcing among many others.Their 
               GPUs are the ones which populate the 'High-level' as well as the 'Enthusiast' levels as they are the only ones consistently pushing consumer hardware upto and beyond
               24GB VRAM threshold.

    <ii> AMD: While they hold a smaller slice of the modern GPU market(around 5% to 7%), AMD custom silicon powers the PlayStation 5 and the XBox Series X/S.Their RDNA architecture
              is the baseline for modern game development.AMD pioneered the modern integrated graphics space.Their Ryzen APUs consistently push the boundaries of what integrated
              hardware can do and have proved themselves as a master of this game time and again.This makes AMD a massive contributor to 'Entry-level' tier.

    <iii> Intel: If we combine both the integrated and the discrete graphics, Intel commands roughly 61% of the entire global GPU market.This is due  to every standard office desktop
                 and thin-and-light Laptop ship with Intel processors and their integrated GPUs,they ship more physical GPUs than NVIDIA and AMD combined.With their newly-engineered 
                 Arc series, they achieved an importance milestone of capturing roughly 1% of the discrete GPU market, thus proving that not only are they the masters of inetgrated 
                 hardware but can also engineer dedicated, standalone hardware.

  - THE OMISSION OF THE OLD GUARD
    The filtering out of the older cards is done to prevent the over-inflation of the 'Entry-level' tier of the database and skewing the results.Although these cards are relics of a 
    bygone era, these cards aren't to be under-estimated as they were the forerunners and laid down the foundations for the current the generation of GPUs.

    <i>3dfx: Before 3dfx,PC gaming was mostly a pixelated,2D experience.In 1996,3dfx released the Voodoo graphics accelerator,which practically invented the dedicated 3D gaming market
             overnight.Games like Quake and Tomb Raider were transformed from chunky pixels into smootth,textured 3D worlds.They invented the SLI back in 1998 with Voodoo , a technology 
             so mind-blowing that NVIDIA bought them in the 2000

    <ii>ATI: For over a decade, ATI was the only company which could reliably trade blows with NVIDIA for the overall performance crown.They were so fiercely competitive and historically 
             significant that AMD purchased them in 2006 for $5.4 billion.This is why modern AMD graphics cards still carry ATI's legendary "Radeon" branding.In 2002, ATI released the
             Radeon 9700 Pro,widely considered one of the single greatest graphics cards ever made.It completely demolished NVIDIA's flagship cards of the era and forced the entire industry
             to adapt a Microsoft's new DirectX 9 standard.
          
    <iii>Matrox: In the mid-to-late 1990s, Matrox Millenium was your go-to GPU if you were a professional doing video editing, CAD or high-end workstation tasks.They possessed the absolute
                 2D image quality and crispest analog signal rendering in the market.In 2002, Matrox released the Parhelia GPU.While it ultimately failed to compete in raw 3D gaming speed,
                 it introduced "Surround Gaming"- the ability to run a single video game seamlessly across three separate monitors at the time.Matrox was doing massive ultra-wide,multi-monitor
                 a full-decade before it became mainstream.
 
  - THE BLACK SHEEP OF THE FAMILY (Excluded)
    XGI is the only manufacturer which never really amounted to anything and fizzled out into obscurity.Their most famous attempt was the Volari Duo, a wildly impractical card that crammed 
    two GPU chips onto a single board.It was notoriously hot,loud, and underperforming, causing the company to quickly fade into obscurity.

  - THE CONSOLE OUTLIER (Excluded)
    Sony does not manufacture dedicated PC graphics cards.If they are in this database, the rows are likely referencing the custom,unified-memory APUs designed in collaboration with AMD for 
    Playstation consoles.
*/

/*
[
  {
    "manufacturer": "AMD",
    "vram_category": "Entry Level Card",
    "no_of_cards": "973"
  },
  {
    "manufacturer": "AMD",
    "vram_category": "High Level Card",
    "no_of_cards": "60"
  },
  {
    "manufacturer": "AMD",
    "vram_category": "Enthusiast Card",
    "no_of_cards": "31"
  },
  {
    "manufacturer": "AMD",
    "vram_category": "Mid Level Card",
    "no_of_cards": "180"
  },
  {
    "manufacturer": "Intel",
    "vram_category": "Entry Level Card",
    "no_of_cards": "27"
  },
  {
    "manufacturer": "Intel",
    "vram_category": "Enthusiast Card",
    "no_of_cards": "4"
  },
  {
    "manufacturer": "Intel",
    "vram_category": "Mid Level Card",
    "no_of_cards": "20"
  },
  {
    "manufacturer": "Intel",
    "vram_category": "High Level Card",
    "no_of_cards": "16"
  },
  {
    "manufacturer": "NVIDIA",
    "vram_category": "Enthusiast Card",
    "no_of_cards": "61"
  },
  {
    "manufacturer": "NVIDIA",
    "vram_category": "Entry Level Card",
    "no_of_cards": "2069"
  },
  {
    "manufacturer": "NVIDIA",
    "vram_category": "High Level Card",
    "no_of_cards": "127"
  },
  {
    "manufacturer": "NVIDIA",
    "vram_category": "Mid Level Card",
    "no_of_cards": "244"
  }
]
*/

