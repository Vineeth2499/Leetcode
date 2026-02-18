import pandas as pd

def fillMissingValues(products: pd.DataFrame) -> pd.DataFrame:
    df = products
    df['quantity'] = df['quantity'].fillna(value = 0)
    return df
