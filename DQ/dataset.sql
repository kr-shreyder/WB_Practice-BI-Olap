create table report.dq_wbitem engine MergeTree order by qty_wbitem as
select toStartOfHour(toDateTime(arrival_dt)) dt_hour
     , uniq(wbitem) 						 	qty_wbitem
     , uniq(supplier_id) 					 	qty_supplier
     , countIf(supplier_id, supplier_id < 1) 	supplier_0_qty
     , uniq(tare_sticker)					 	qty_box
     , countIf(tare_sticker, tare_sticker = '') box_0_qty
     , uniq(sku_id)							 	qty_sku
     , countIf(sku_id, sku_id < 1) 				sku_0_qty
     , uniq(nm_id)							 	qty_nm
     , countIf(nm_id, nm_id < 1) 				nm_0_qty
from wbitemDeclaration
group by dt_hour
order by dt_hour;