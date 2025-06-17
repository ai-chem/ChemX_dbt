-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'co_crystals') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'co_crystals') }}

-- 3. кол-во пропущенных значений
{{ column_stats('raw', 'co_crystals') }}