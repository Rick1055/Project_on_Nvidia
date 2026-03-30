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

gpu_specs["release_year"] = gpu_specs["release_year"].astype("Int64")

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