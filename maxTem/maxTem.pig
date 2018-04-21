data = load '/01_03/' as (line:chararray);
records = foreach data generate SUBSTRING(line,15,19) as year,
		(int) SUBSTRING(line,87,92) as temperature,
		(int) SUBSTRING(line,92,93) as quality;
filtered_record = filter records by temperature !=9999 and quality in (0,1,4,5,9);
group_record = group filtered_record by year;
max_tem = foreach group_record generate group,MAX(filtered_record.temperature);
dump max_tem;
store max_tem into '/max_tem01_03_by_pig';