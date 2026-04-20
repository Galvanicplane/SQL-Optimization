-- BÖLÜM 1: EKLENTİ YÜKLEME 
-- Container ayağa kalktığında pg_stat_statements yüklü olsa da veritabanında aktif etmeliyiz.
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- BÖLÜM 2: BİLİNÇLİ OLARAK KÖTÜ TASARLANMIŞ TABLO
-- İçerisinde kasten PRIMARY KEY veya INDEX bulunmuyor.
DROP TABLE IF EXISTS airports;

CREATE TABLE airports (
    id INT, -- Index veya Primary Key koymadık!
    ident VARCHAR(50),
    type VARCHAR(50),
    name VARCHAR(255),
    latitude_deg FLOAT,
    longitude_deg FLOAT,
    elevation_ft INT,
    continent VARCHAR(10),
    iso_country VARCHAR(10),
    iso_region VARCHAR(20),
    municipality VARCHAR(255),
    scheduled_service VARCHAR(10),
    icao_code VARCHAR(10),
    iata_code VARCHAR(10),
    gps_code VARCHAR(20),
    local_code VARCHAR(20),
    home_link TEXT,
    wikipedia_link TEXT,
    keywords TEXT
);

-- BÖLÜM 3: GERÇEK VERİYİ (UÇUŞ/HAVALİMANI) İÇERİ AKTARMA
-- Container'a map ettiğimiz dizinden CSV verisini çekiyoruz. Asla yapay veri (dummy data) yok!
COPY airports 
FROM '/data/airports.csv' 
WITH (FORMAT csv, HEADER true, NULL '');

-- Eklendiğini teyit edelim
SELECT COUNT(*) FROM airports;
