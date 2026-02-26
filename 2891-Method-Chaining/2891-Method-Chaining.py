import pandas as pd

def findHeavyAnimals(animals: pd.DataFrame) -> pd.DataFrame:
    animals = (
        animals
        .query('weight > 100')
        .sort_values(by='weight', ascending=False)
        .filter(['name'])
        )
    return animals
