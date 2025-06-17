-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'eyedrops') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'eyedrops') }}

-- 3. кол-во пропущенных значений
{{ column_stats('raw', 'eyedrops') }}