-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'nanomag') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'nanomag') }}

-- 3. Подсчет NULL значений
{{ get_null_counts('raw', 'nanomag') }}