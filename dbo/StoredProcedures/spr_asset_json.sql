create procedure spr_asset_json
as 
begin
select a.asset_rid,a.asset_name,a.asset_uuid,b.asset_type_name,
STRING_AGG(c.asset_group_rid,',') as asset_group_rid,CASE WHEN d.equipment_type_rid = 1 then 'APU'
WHEN  d.equipment_type_rid = 2 then 'Reefer' 
WHEN  d.equipment_type_rid = 3 then 'HeatKing' 
WHEN  d.equipment_type_rid = 4 then '750i' 
WHEN  d.equipment_type_rid = 5 then 'Unknown' 
WHEN  d.equipment_type_rid = 6 then 'HMI' END as equipmenttype,
a.billing_service_level_rid,
g.logging_interval_description,--activation_status_rid
CASE WHEN a.activation_status_rid = 1 then 'Pending activation'
WHEN  a.activation_status_rid = 2 then 'Activated' 
WHEN  a.activation_status_rid = 3 then 'Deactivated' 
WHEN  a.activation_status_rid = 4 then 'Failed'  END as activation_status,


DATEDIFF_BIG(MILLISECOND, '1970-01-01 00:00:00', d.warranty_start_date) as warranty_start_date,
DATEDIFF_BIG(MILLISECOND, '1970-01-01 00:00:00', d.warranty_end_date) as warranty_end_date,
h.description,
a.user_activation
 
from asset a LEFT OUTER JOIN Asset_type b on a.asset_type_rid = b.asset_type_rid LEFT OUTER JOIN asset_group_mapping c on a.asset_rid=c.asset_rid and a.active = 1
LEFT OUTER JOIN equipment d on a.asset_rid = d.asset_rid LEFT OUTER join equipment_device_mapping e on d.equipment_rid = e.equipment_rid LEFT OUTER join device f on f.device_rid=e.device_rid
left outer join billing_logging_interval g on f.logging_interval_rid_on=g.device_logging_interval_rid_on and f.logging_interval_rid_off=g.device_logging_interval_rid_off
left outer join telematics_mode_type h on h.rid = f.telematics_mode_type_rid
group by a.asset_rid,a.asset_name,a.asset_uuid,b.asset_type_name,d.equipment_type_rid,a.billing_service_level_rid,g.logging_interval_description,warranty_start_date,warranty_end_date,h.description,a.user_activation,a.activation_status_rid
end
GO

