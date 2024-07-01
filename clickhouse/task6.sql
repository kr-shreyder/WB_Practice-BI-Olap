create table if not exists current.registered_dogs
(
    dog_id         	UInt64,
    owner_id		UInt64,
    name        	LowCardinality(String),
    breed 			LowCardinality(String),
    age  			UInt16,
    arrival_date	Date,
    departure_date	Date
)
engine = MergeTree() order by dog_id;

create materialized view stage.registered_dogs_current to current.registered_dogs as
select dog_id, owner_id, name, breed, age, arrival_date, departure_date
from stage.registered_dogs;