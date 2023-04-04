import sys
import pandas as pd
from lib.Variables import Variables
from lib.Logger import Logger
from lib.Auditor import Auditor
from lib.SnowflakeDatabase import SnowflakeDatabase
from lib.OracleDatabase import OracleDatabase
from lib.DWHNightlyExtractBatch import DWHNightlyExtractBatch


v = Variables("ENV.cfg")
v.set("SCRIPT_NAME", "ht_itm_sell_rpt_ex")
v.set("SOURCE_SYSTEM", "RMS")
v.set("STYLE_TABLE", "DWH_D_PRD_STY_LU")
v.set("ITEM_TABLE", "DWH_D_PRD_ITM_LU")
v.set("SALES_TABLE", "DWH_F_SLS_TXN_LN_ITM_B")
v.set("DAY_TABLE", "DWH_D_TIM_DAY_LU")
v.set("LOCATION_TABLE", "DWH_D_ORG_LOC_LU")
v.set("CUI_INFO", "HTTD_CUI_INFO")
v.set("TEMP_TABLE1", "HT_PDD_STYLE_SLS_INV")
v.set("TEMP_TABLE2", "HT_PDD_STYLE_SLS_INV_2")
v.set("TEMP_TABLE3", "HT_PDD_STYLE_SLS_INV_3")
v.set("TEMP_TABLE4", "HT_PDD_STYLE_SLS_INV_4")
v.get("RMS")
log = Logger(v)
ora_db = OracleDatabase(v, log)
ora_db.start_connection()
audit = Auditor(v, log, ora_db)
dim_module = DWHNightlyExtractBatch(ora_db, v, log, audit)
# cur = ora_db.cursor()
print("Oracle Database Wallet :",v.get("RMS"))
print("Sucessful Connection to Oracle Database")
dim_module.get_param("CURR_DAY")
# print(dim_module.version)
# print(type(dim_module))
# print(cur)