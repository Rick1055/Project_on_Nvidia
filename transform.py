import pandas as pd
import numpy as np
from sqlalchemy import create_engine

latest_gpu_spec = pd.read_csv("GPUfullSpecs/gpu_specs_v7.csv")
older_gpu_spec = pd.read_csv("GPUfullSpecs/gpu_specs_v6.csv")

pd.set_option("display.max_columns", 85)
pd.set_option("display.max_rows", 85)

gpu_specs = pd.concat([older_gpu_spec,latest_gpu_spec], ignore_index=True)

gpu_specs.columns = gpu_specs.columns.str.replace(r'([a-z])([A-Z])',r'\1_\2', regex=True).str.lower()

gpu_specs["gpu_id"] = gpu_specs.index
gpu_col_id = gpu_specs.pop("gpu_id")
gpu_specs.insert(0,"gpu_id", gpu_col_id)
gpu_specs.set_index("gpu_id")

gpu_specs['manufacturer'] = gpu_specs['manufacturer'].str.strip()

gpu_specs.loc[gpu_specs['gpu_chip']=='DG2-128','release_year'] = 2022
gpu_specs.loc[gpu_specs['gpu_chip']=='DG1','release_year'] = 2020

# Dictionary format: 'Silicon_Prefix': (Core_Launch_Year, Min_Valid_Year, Max_Valid_Year)
nvidia_arch_rules = {
        'AD':  (2022, 2022, 2026), # Ada Lovelace (RTX 40)
        'GA':  (2020, 2020, 2025), # Ampere (RTX 30 - some late mobile/OEM variants)
        'TU':  (2018, 2018, 2024), # Turing (RTX 20 / GTX 16 - GTX 1650 was manufactured for years)
        'GV':  (2017, 2017, 2019), # Volta (Titan V / Workstation)
        'GP':  (2016, 2016, 2021), # Pascal (GTX 10 - GT 1030 DDR4 kept this alive late)
        'GM':  (2014, 2014, 2018), # Maxwell (GTX 900 / 750)
        'GK':  (2012, 2012, 2016), # Kepler (GTX 600 / 700)
        'GF':  (2010, 2010, 2016), # Fermi (GTX 400 / 500 - heavy OEM rebranding)
        'GT2': (2008, 2008, 2011), # Tesla 2.0 (GTX 200)
        'G9':  (2007, 2007, 2011), # Tesla 1.5 (8000 / 9000 - the legendary G92 rebrands)
        'G8':  (2006, 2006, 2009), # Tesla 1.0 (8000)
        'G7':  (2005, 2005, 2008), # Curie (GeForce 7)
        'NV':  (2001, 1999, 2006)  # Legacy (GeForce 256 through GeForce 6)
    }
# Loop through the rules and clean the data
for prefix, (core_year, min_year, max_year) in nvidia_arch_rules.items():
        # Create a mask for this specific architecture prefix with impossible dates
        arch_mask = (
            (gpu_specs['manufacturer'] == 'NVIDIA') & 
            (gpu_specs['gpu_chip'].str.startswith(prefix, na=False)) & 
            ((gpu_specs['release_year'] < min_year) | (gpu_specs['release_year'] > max_year))
        )
        
        # Overwrite only the broken dates, resetting them to the core launch year
        gpu_specs.loc[arch_mask, 'release_year'] = core_year

amd_arch_rules = {
        'Navi 3': (2022, 2022, 2026), # RDNA 3 (RX 7000-series)
        'Navi 2': (2020, 2020, 2024), # RDNA 2 (RX 6000-series)
        'Navi 1': (2019, 2019, 2022), # RDNA 1 (RX 5000-series)
        'Vega':   (2017, 2017, 2021), # RX Vega & long-lived APU variants
        'Polaris':(2016, 2016, 2020), # RX 400/500 series
        'Ellesmere':(2016,2016, 2020),# Polaris 10 internal codename
        'Baffin': (2016, 2016, 2020), # Polaris 11 internal codename
        'Fiji':   (2015, 2015, 2017), # R9 Fury Series
        'Hawaii': (2013, 2013, 2016), # R9 290/390 series
        'Tahiti': (2011, 2011, 2015), # HD 7900 / R9 280 series
        'RV':     (2001, 1999, 2010), # Legacy ATI Radeon (RV100 - RV870)
        'R3':     (2002, 2002, 2005), # Early Legacy ATI
        'R4':     (2004, 2004, 2006), # Early Legacy ATI
        'R5':     (2005, 2005, 2008)  # Early Legacy ATI
    }

# Loop through AMD rules using prefix matching
for prefix, (core_year, min_year, max_year) in amd_arch_rules.items():
        arch_mask = (
            (gpu_specs['manufacturer'] == 'AMD') & 
            (gpu_specs['gpu_chip'].str.startswith(prefix, na=False)) & 
            ((gpu_specs['release_year'] < min_year) | (gpu_specs['release_year'] > max_year))
        )
        gpu_specs.loc[arch_mask, 'release_year'] = core_year

intel_arch_rules = {
        'DG2': (2022, 2022, 2026), # Arc Alchemist Dedicated GPUs
        'DG1': (2020, 2020, 2022), # Iris Xe MAX Dedicated
        'GT':  (2010, 2010, 2024)  # Huge catch-all for Intel Integrated Graphics
    }

# Loop through Intel rules using substring matching
for substring, (core_year, min_year, max_year) in intel_arch_rules.items():
        arch_mask = (
            (gpu_specs['manufacturer'] == 'Intel') & 
            (gpu_specs['gpu_chip'].str.contains(substring, na=False, case=False)) & 
            ((gpu_specs['release_year'] < min_year) | (gpu_specs['release_year'] > max_year))
        )
        gpu_specs.loc[arch_mask, 'release_year'] = core_year

console_arch_rules = {
        # Current Gen (PS5 / Xbox Series X|S)
        'Oberon':   (2020, 2020, 2026), # PS5 Custom AMD APU
        'Scarlett': (2020, 2020, 2026), # Xbox Series Custom AMD APU
        'Prospero': (2020, 2020, 2026), # Early PS5/AMD APU codename
        
        # Last Gen (PS4 / Xbox One - including mid-gen refreshes)
        'Liverpool':(2013, 2013, 2020), # Base PS4
        'Durango':  (2013, 2013, 2020), # Base Xbox One
        'Neo':      (2016, 2016, 2022), # PS4 Pro
        'Scorpio':  (2017, 2017, 2022), # Xbox One X
        
        # Xbox 360
        'Xenos':    (2005, 2005, 2015), # Xbox 360 (account for all board revisions)
        
        # Nintendo GameCube / Wii
        'Flipper':  (2001, 2001, 2006), # GameCube
        'Hollywood':(2006, 2006, 2013)  # Wii
    }

    # Loop through Console rules
for chip, (core_year, min_year, max_year) in console_arch_rules.items():
        # Notice we omit checking the 'manufacturer' column here. 
        # In hardware datasets, console APUs are notoriously messy—they might be 
        # labeled as 'AMD', 'ATI', 'Sony', 'Microsoft', or 'Nintendo'. 
        # Since codenames like 'Oberon' or 'Flipper' are highly unique, we just target the chip name directly.
        arch_mask = (
            (gpu_specs['gpu_chip'].str.startswith(chip, na=False)) & 
            ((gpu_specs['release_year'] < min_year) | (gpu_specs['release_year'] > max_year))
        )
        gpu_specs.loc[arch_mask, 'release_year'] = core_year

chip_medians = gpu_specs.groupby('gpu_chip')['release_year'].transform('median')

Q1 = gpu_specs.groupby('gpu_chip')['release_year'].transform(lambda x:x.quantile(0.25))
Q3 = gpu_specs.groupby('gpu_chip')['release_year'].transform(lambda x:x.quantile(0.75))
IQR = Q3 - Q1

anomaly_mask = (gpu_specs['release_year']<(Q1-1.5*IQR))|(gpu_specs['release_year']>(Q3+1.5*IQR))
gpu_specs.loc[anomaly_mask,'release_year'] = chip_medians[anomaly_mask]

gpu_specs['release_year'] = gpu_specs['release_year'].fillna(chip_medians)
gpu_specs["release_year"] = gpu_specs["release_year"].round().astype("Int64")

gpu_specs.info()

schema_dict = {
            "column_name":['manufacturer', 'product_name', 'release_year', 'mem_size',
                           'mem_bus_width', 'gpu_clock', 'mem_clock', 'unified_shader', 'tmu',
                           'rop', 'pixel_shader', 'vertex_shader', 'igp', 'bus', 'mem_type',
                           'gpu_chip'],
            "description":["Which company manufactured the graphics card?",
                           "What is the official retail name of the GPU?",
                           "Which year was this particular GPU released?",
                           "What is the total capacity of the dedicated video memory on the card?",
                           "What is the width of the memory bus(in bits)?",
                           "What is the base processing speed of the main graphics chip (in MHz)?",
                           "What is the operating speed of the dedicated video memory(in MHz)?",
                           "How many unified processing cores does the GPU have?",
                           "How many Texture Mapping Units (TMUs) does the card have?",
                           "How many Render Output Units(ROPs) does the card have?",
                           "How many dedicated pixel shaders are present?",
                           "How many dedicated vertex shaders are present for drawing the wireframe shapes for 3D objects?",
                           "Is this an Integrate Graphics Processor?",
                           "What kind of physical slot or interface does this card use to connect to the computer's motherboard?",
                           "What is the technological generation of the video memory used?",
                           "What is the internal engineering code name for the actual piece of silicon inside the card?"
                          ]}   
try:
    schema_df = pd.DataFrame(schema_dict)
    schema_df.set_index("column_name",inplace=True)
except ValueError:
    print("The number of rows in the both the columns is not same!!! Check before trying again")
pd.set_option('display.max_colwidth',None)

gpu_specs["pixel_shader"] = gpu_specs["pixel_shader"].fillna(0)
gpu_specs["vertex_shader"] = gpu_specs["vertex_shader"].fillna(0)
gpu_specs["unified_shader"] = gpu_specs["unified_shader"].fillna(0)
bad_data_mask = (gpu_specs["release_year"] >= 2000) & (gpu_specs["pixel_shader"] == 0) & (gpu_specs["vertex_shader"] == 0) & (gpu_specs["unified_shader"] == 0)
gpu_specs.loc[bad_data_mask , ["pixel_shader","vertex_shader","unified_shader"]] = np.nan

db_user='Rick'
db_password='Sneshi0708'
db_host='127.0.0.1'
db_port='6000'
db_name='gpu_db'

connection = f'postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}'
engine =create_engine(connection)

gpu_specs.to_sql('gpu_specs',engine,if_exists='replace',index=False)