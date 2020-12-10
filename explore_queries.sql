SELECT remote_host, count(*) 
FROM phdata.apachelogs
group by remote_host
order by remote_host desc;

SELECT remote_host, count(*) 
FROM phdata.apachelogs
group by remote_host
order by count(*) desc;

select min(request_time), max(request_time) from phdata.apachelogs;

select date_trunc('second',request_time)
	,remote_host
	, count(*)
from phdata.apachelogs
group by 1,2
order by 1,2

select interval_group, remote_host, count(*)
  from (
    select rowid, 
           request_time, 
           'epoch'::timestamp + '5 seconds'::interval * (extract(epoch from request_time)::int4 / 5) as interval_group,
           remote_host
    from phdata.apachelogs
  ) t1
group by 1,2
having count(*) > 1
order by 1,3 desc

