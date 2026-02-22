import pandas as pd

def dropDuplicateEmails(customers: pd.DataFrame) -> pd.DataFrame:
    cleaned_df = customers.drop_duplicates(subset = 'email')
    return cleaned_df
