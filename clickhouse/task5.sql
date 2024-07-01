create table if not exists stage.registered_dogs
(
    dog_id         	UInt64,
    owner_id		UInt64,
    name        	LowCardinality(String),
    breed 			LowCardinality(String),
    age  			UInt16,
    arrival_date	Date,
    departure_date	Date
)
engine = MergeTree() ORDER BY dog_id;

create table if not exists buffer.registered_dogs_buf
(
    dog_id         	UInt64,
    owner_id		UInt64,
    name        	LowCardinality(String),
    breed 			LowCardinality(String),
    age  			UInt16,
    arrival_date	Date,
    departure_date	Date
)
engine = Buffer('stage', 'registered_dogs', 16, 10, 100, 10000, 100000, 10000000, 100000000);