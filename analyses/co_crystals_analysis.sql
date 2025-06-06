-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'co_crystals') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'co_crystals') }}

-- 3. Подсчет NULL значений
{{ get_null_counts('raw', 'co_crystals') }}