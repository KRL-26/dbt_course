#####################################
#Practica Definimos Modelo con Python
#####################################
#Model that simply filters for long-term listings or listings with minimum night larger than 30 days
def model(dbt, session):
    listings = dbt.ref("dim_listings_cleansed")

    return (listings.filter(listings["MINIMUM_NIGHTS"] >= 30)
                   .select("LISTING_ID", "LISTING_NAME", "PRICE"))