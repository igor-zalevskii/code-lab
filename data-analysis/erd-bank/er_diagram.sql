CREATE TABLE "languages"(
    "id" SMALLINT NOT NULL,
    "name" VARCHAR(50) NOT NULL
);
ALTER TABLE
    "languages" ADD PRIMARY KEY("id");
ALTER TABLE
    "languages" ADD CONSTRAINT "languages_name_unique" UNIQUE("name");
CREATE TABLE "bank_business_hours"(
    "id" SMALLINT NOT NULL,
    "bank_id" SMALLINT NOT NULL,
    "week_day" VARCHAR(255) CHECK
        ("week_day" IN('')) NOT NULL,
        "open_time" TIME(0)
    WITH
        TIME zone NOT NULL,
        "close_time" TIME(0)
    WITH
        TIME zone NOT NULL
);
CREATE TABLE "customer_manager"(
    "id_customer" UUID NOT NULL,
    "id_manager" INTEGER NOT NULL
);
CREATE TABLE "orders"(
    "id" UUID NOT NULL,
    "customer_id" UUID NOT NULL,
    "product_id" BIGINT NOT NULL,
    "date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "status" VARCHAR(255) CHECK
        ("status" IN('')) NOT NULL,
        "channel" VARCHAR(255)
    CHECK
        ("channel" IN('')) NOT NULL,
        "partner_id" SMALLINT NULL,
        "bank_id" SMALLINT NULL
);
ALTER TABLE
    "orders" ADD PRIMARY KEY("id");
CREATE TABLE "product_descriptions"(
    "id" SMALLINT NOT NULL,
    "product_id" SMALLINT NOT NULL,
    "text" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "language_id" SMALLINT NOT NULL
);
ALTER TABLE
    "product_descriptions" ADD PRIMARY KEY("id");
CREATE TABLE "product_sales"(
    "id" BIGINT NOT NULL,
    "product_id" INTEGER NOT NULL,
    "customer_id" UUID NOT NULL,
    "date" DATE NOT NULL,
    "order_id" UUID NOT NULL
);
ALTER TABLE
    "product_sales" ADD PRIMARY KEY("id");
CREATE TABLE "cities"(
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "country_id" SMALLINT NOT NULL
);
ALTER TABLE
    "cities" ADD PRIMARY KEY("id");
CREATE TABLE "countries"(
    "id" SMALLINT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "counrty_code" VARCHAR(50) NOT NULL
);
ALTER TABLE
    "countries" ADD PRIMARY KEY("id");
ALTER TABLE
    "countries" ADD CONSTRAINT "countries_name_unique" UNIQUE("name");
ALTER TABLE
    "countries" ADD CONSTRAINT "countries_counrty_code_unique" UNIQUE("counrty_code");
CREATE TABLE "addresses"(
    "id" INTEGER NOT NULL,
    "city_id" INTEGER NOT NULL,
    "street" TEXT NOT NULL,
    "zip_code" TEXT NOT NULL
);
ALTER TABLE
    "addresses" ADD PRIMARY KEY("id");
CREATE TABLE "products"(
    "id" SMALLINT NOT NULL,
    "type" VARCHAR(255) CHECK
        ("type" IN('')) NOT NULL,
        "price" FLOAT(53) NULL,
        "status" BOOLEAN NOT NULL,
        "available_online" BOOLEAN NOT NULL,
        "available_for_partners" BOOLEAN NOT NULL,
        "sales_start_date" DATE NOT NULL,
        "sales_end_date" DATE NULL
);
ALTER TABLE
    "products" ADD PRIMARY KEY("id");
CREATE TABLE "customer_info"(
    "customer_id" UUID NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "middle_name" VARCHAR(50) NULL,
    "last_name" VARCHAR(50) NOT NULL,
    "address_id" INTEGER NOT NULL,
    "passport" TEXT NOT NULL,
    "phone_1" VARCHAR(20) NOT NULL,
    "phone_2" VARCHAR(20) NULL,
    "phone_3" VARCHAR(20) NULL,
    "phone_4" VARCHAR(20) NULL,
    "phone_5" VARCHAR(20) NULL,
    "email" VARCHAR(50) NOT NULL
);
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_customer_id_unique" UNIQUE("customer_id");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_passport_unique" UNIQUE("passport");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_phone_1_unique" UNIQUE("phone_1");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_phone_2_unique" UNIQUE("phone_2");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_phone_3_unique" UNIQUE("phone_3");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_phone_4_unique" UNIQUE("phone_4");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_phone_5_unique" UNIQUE("phone_5");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_email_unique" UNIQUE("email");
CREATE TABLE "customers"(
    "id" UUID NOT NULL,
    "birthday" DATE NOT NULL,
    "language_id" SMALLINT NOT NULL,
    "country_birth_id" SMALLINT NOT NULL,
    "sex" VARCHAR(255) CHECK
        ("sex" IN('')) NOT NULL
);
ALTER TABLE
    "customers" ADD PRIMARY KEY("id");
CREATE TABLE "managers"(
    "id" INTEGER NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "middle_name" VARCHAR(50) NULL,
    "last_name" VARCHAR(50) NOT NULL
);
ALTER TABLE
    "managers" ADD PRIMARY KEY("id");
CREATE TABLE "banks"(
    "id" SMALLINT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "geolocation" geography NOT NULL,
    "addresss_id" INTEGER NOT NULL,
    "business_hours_id" SMALLINT NOT NULL
);
ALTER TABLE
    "banks" ADD PRIMARY KEY("id");
CREATE TABLE "manager_bank"(
    "id_manager" INTEGER NOT NULL,
    "id_bank" INTEGER NOT NULL
);
ALTER TABLE
    "manager_bank" ADD PRIMARY KEY("id_manager");
ALTER TABLE
    "product_sales" ADD CONSTRAINT "product_sales_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");
ALTER TABLE
    "product_sales" ADD CONSTRAINT "product_sales_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");
ALTER TABLE
    "cities" ADD CONSTRAINT "cities_country_id_foreign" FOREIGN KEY("country_id") REFERENCES "countries"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");
ALTER TABLE
    "product_descriptions" ADD CONSTRAINT "product_descriptions_language_id_foreign" FOREIGN KEY("language_id") REFERENCES "languages"("id");
ALTER TABLE
    "customers" ADD CONSTRAINT "customers_language_id_foreign" FOREIGN KEY("language_id") REFERENCES "languages"("id");
ALTER TABLE
    "manager_bank" ADD CONSTRAINT "manager_bank_id_manager_foreign" FOREIGN KEY("id_manager") REFERENCES "managers"("id");
ALTER TABLE
    "product_descriptions" ADD CONSTRAINT "product_descriptions_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "customer_manager" ADD CONSTRAINT "customer_manager_id_customer_foreign" FOREIGN KEY("id_customer") REFERENCES "customers"("id");
ALTER TABLE
    "customer_manager" ADD CONSTRAINT "customer_manager_id_manager_foreign" FOREIGN KEY("id_manager") REFERENCES "managers"("id");
ALTER TABLE
    "addresses" ADD CONSTRAINT "addresses_city_id_foreign" FOREIGN KEY("city_id") REFERENCES "cities"("id");
ALTER TABLE
    "manager_bank" ADD CONSTRAINT "manager_bank_id_bank_foreign" FOREIGN KEY("id_bank") REFERENCES "banks"("id");
ALTER TABLE
    "product_sales" ADD CONSTRAINT "product_sales_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");
ALTER TABLE
    "banks" ADD CONSTRAINT "banks_business_hours_id_foreign" FOREIGN KEY("business_hours_id") REFERENCES "bank_business_hours"("id");
ALTER TABLE
    "customers" ADD CONSTRAINT "customers_country_birth_id_foreign" FOREIGN KEY("country_birth_id") REFERENCES "countries"("id");
ALTER TABLE
    "customer_info" ADD CONSTRAINT "customer_info_address_id_foreign" FOREIGN KEY("address_id") REFERENCES "addresses"("id");