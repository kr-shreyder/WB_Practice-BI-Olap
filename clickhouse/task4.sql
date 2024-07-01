create role readonly;
create role stage_writer;

grant select on *.* to readonly;
grant insert, create on staging.* to stage_writer;

create user readonly_user identified with sha256_password by 'readonly_password';
create user stage_writer_user identified with sha256_password by 'stage_writer_password';

grant readonly to readonly_user;
grant stage_writer to stage_writer_user;