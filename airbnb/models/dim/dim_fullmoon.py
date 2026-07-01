#####################################
#Practica Definimos Modelo Avanzado con Python
#####################################
#No hace falta instalar esta libreria con pip localmente, porque estos modelo definidos con python corren en remoto 
#Hay que instalar la libreria en la plataforma de snowflake, no en local
import holidays

def is_holiday(date_col):
    german_holidays = holidays.Germany()
    is_holiday = (date_col in german_holidays)
    return is_holiday

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["holidays"],                                         #Aqui decimos que instalamos la libreria. Es como pip install en snowflake
        enabled = False                                                  #Desactivamos este modelo. Ya no podremos hacer run de él
    )

    orders_df = dbt.ref("seed_full_moon_dates")

    df = orders_df.to_pandas()

    df["IS_HOLIDAY"] = df["FULL_MOON_DATE"].apply(is_holiday)

    # return final dataset (Pandas DataFrame)
    return df