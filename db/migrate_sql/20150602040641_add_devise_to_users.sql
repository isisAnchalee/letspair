CREATE TABLE "users" ("id" serial primary key, "username" character varying NOT NULL, "first_name" character varying NOT NULL, "last_name" character varying, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
SELECT 'character varying'::regtype::oid;
