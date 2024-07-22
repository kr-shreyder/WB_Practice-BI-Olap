create table if not exists default.wbitemDeclaration_log
(
    wbitem String,
    supplier_id UInt32,
    tare_sticker String,
    nm_id UInt64,
    vol UInt16
)
engine = MergeTree()
order by wbitem
settings index_granularity = 8192;