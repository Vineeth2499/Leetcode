import pandas as pd

def selectData(students: pd.DataFrame) -> pd.DataFrame:
    filtered_df = students.loc[students['student_id'] == 101, ['name', 'age']]
    return filtered_df
